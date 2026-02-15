const std = @import("std");
const yazap = @import("yazap");

const App = yazap.App;
const Arg = yazap.Arg;

// ============================================================================
// Types
// ============================================================================

const Config = struct {
    allocator: std.mem.Allocator,
    dd_domain: []const u8,
    dd_domain_owned: ?[]const u8,
    api_key: []const u8,
    app_key: []const u8,
    from_timestamp: ?[]const u8,
    to_timestamp: ?[]const u8,

    fn deinit(self: *Config) void {
        if (self.dd_domain_owned) |domain| self.allocator.free(domain);
        self.allocator.free(self.api_key);
        self.allocator.free(self.app_key);
    }
};

const QueryParam = struct {
    key: []const u8,
    value: []const u8,
};

const CustomHeader = struct {
    name: []const u8,
    value: []const u8,
};

const LogsFilter = struct {
    from: ?[]const u8, // ISO 8601 timestamp, optional
    to: ?[]const u8, // ISO 8601 timestamp, optional
    query: []const u8, // Search query string
    indexes: []const []const u8, // Array of index names
};

const LogsPage = struct {
    cursor: ?[]const u8, // Pagination cursor (null for first page)
    limit: usize, // Logs per request (max 1000)
};

// ============================================================================
// Configuration Helpers
// ============================================================================

/// Initialize configuration from environment and CLI args
fn initConfig(
    allocator: std.mem.Allocator,
    domain_arg: ?[]const u8,
    from_arg: ?[]const u8,
    to_arg: ?[]const u8,
) !Config {
    var config: Config = undefined;
    config.allocator = allocator;
    config.dd_domain_owned = null;
    config.from_timestamp = from_arg;
    config.to_timestamp = to_arg;

    // Priority: CLI arg > DD_SITE env > "datadoghq.com"
    config.dd_domain = blk: {
        if (domain_arg) |domain| {
            break :blk domain;
        }
        if (std.process.getEnvVarOwned(allocator, "DD_SITE")) |site| {
            config.dd_domain_owned = site;
            break :blk site;
        } else |_| {
            break :blk "datadoghq.com";
        }
    };

    // Validate domain
    if (!isValidDatadogDomain(config.dd_domain)) {
        // Clean up if we allocated dd_domain_owned before failing
        if (config.dd_domain_owned) |domain| allocator.free(domain);
        std.debug.print("Error: Invalid Datadog domain: {s}\n", .{config.dd_domain});
        std.debug.print("Valid domains should end with 'datadoghq.com', 'datadoghq.eu', or similar\n", .{});
        return error.InvalidDomain;
    }

    // Get API keys from environment (both required)
    config.api_key = std.process.getEnvVarOwned(allocator, "DD_API_KEY") catch |err| {
        std.debug.print("Error: DD_API_KEY environment variable not set\n", .{});
        std.debug.print("Required for API authentication\n", .{});
        return err;
    };

    config.app_key = std.process.getEnvVarOwned(allocator, "DD_APPLICATION_KEY") catch |err| {
        allocator.free(config.api_key);
        std.debug.print("Error: DD_APPLICATION_KEY environment variable not set\n", .{});
        std.debug.print("Required for API read operations\n", .{});
        return err;
    };

    return config;
}

fn isValidDatadogDomain(domain: []const u8) bool {
    // Valid Datadog domains end with datadoghq.* or are exactly datadoghq.*
    const valid_suffixes = [_][]const u8{
        "datadoghq.com",
        "datadoghq.eu",
        "ddog-gov.com",
        "ap1.datadoghq.com",
        "us3.datadoghq.com",
        "us5.datadoghq.com",
    };

    for (valid_suffixes) |suffix| {
        if (std.mem.eql(u8, domain, suffix) or std.mem.endsWith(u8, domain, suffix)) {
            return true;
        }
    }

    return false;
}

// ============================================================================
// URL Building Helpers
// ============================================================================

/// URL-encode a string per RFC 3986
/// Unreserved: A-Z a-z 0-9 - _ . ~
/// Everything else: %XX hex encoding
fn urlEncode(allocator: std.mem.Allocator, input: []const u8) ![]const u8 {
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    for (input) |byte| {
        if (std.ascii.isAlphanumeric(byte) or byte == '-' or byte == '_' or byte == '.' or byte == '~') {
            try result.append(allocator, byte);
        } else {
            try result.writer(allocator).print("%{X:0>2}", .{byte});
        }
    }

    return try result.toOwnedSlice(allocator);
}

/// Build full URL with encoded query parameters
/// Used by friendly commands (host, validate)
fn buildUrl(
    allocator: std.mem.Allocator,
    domain: []const u8,
    path: []const u8,
    query_params: ?[]const QueryParam,
) ![]const u8 {
    // Add api. prefix if not present
    const api_domain = if (std.mem.startsWith(u8, domain, "api."))
        domain
    else
        try std.fmt.allocPrint(allocator, "api.{s}", .{domain});
    defer if (!std.mem.startsWith(u8, domain, "api.")) allocator.free(api_domain);

    // Build query string with URL encoding
    var query_string: ?[]const u8 = null;
    if (query_params) |params| {
        if (params.len > 0) {
            var query_buf: std.ArrayList(u8) = .empty;
            defer query_buf.deinit(allocator);

            for (params, 0..) |param, i| {
                if (i > 0) try query_buf.append(allocator, '&');
                // Encode both key and value for proper URL safety
                const encoded_key = try urlEncode(allocator, param.key);
                defer allocator.free(encoded_key);
                const encoded_value = try urlEncode(allocator, param.value);
                defer allocator.free(encoded_value);
                try query_buf.writer(allocator).print("{s}={s}", .{ encoded_key, encoded_value });
            }

            query_string = try query_buf.toOwnedSlice(allocator);
        }
    }
    defer if (query_string) |qs| allocator.free(qs);

    // Build full URL
    if (query_string) |qs| {
        return try std.fmt.allocPrint(allocator, "https://{s}{s}?{s}", .{ api_domain, path, qs });
    } else {
        return try std.fmt.allocPrint(allocator, "https://{s}{s}", .{ api_domain, path });
    }
}

/// Build URL for raw command - concatenates strings as-is (no encoding)
fn buildRawUrl(
    allocator: std.mem.Allocator,
    domain: []const u8,
    path: []const u8,
    query_string: ?[]const u8,
) ![]const u8 {
    // Add api. prefix if not present
    const api_domain = if (std.mem.startsWith(u8, domain, "api."))
        domain
    else
        try std.fmt.allocPrint(allocator, "api.{s}", .{domain});
    defer if (!std.mem.startsWith(u8, domain, "api.")) allocator.free(api_domain);

    // Build full URL without encoding
    if (query_string) |qs| {
        return try std.fmt.allocPrint(allocator, "https://{s}{s}?{s}", .{ api_domain, path, qs });
    } else {
        return try std.fmt.allocPrint(allocator, "https://{s}{s}", .{ api_domain, path });
    }
}

// ============================================================================
// Header Management
// ============================================================================

/// Parse header string "Name:Value" into struct
/// Splits on FIRST colon only (supports colons in values)
fn parseHeader(header_str: []const u8) !CustomHeader {
    const colon_pos = std.mem.indexOfScalar(u8, header_str, ':') orelse {
        return error.InvalidHeader;
    };

    return CustomHeader{
        .name = header_str[0..colon_pos],
        .value = header_str[colon_pos + 1 ..],
    };
}

/// Build header list: base headers + custom headers
fn buildHeaders(
    allocator: std.mem.Allocator,
    api_key: []const u8,
    app_key: []const u8,
    custom_headers: []const CustomHeader,
) ![]std.http.Header {
    const base_count = 3;
    const total_count = base_count + custom_headers.len;

    var headers = try allocator.alloc(std.http.Header, total_count);

    // Base headers
    headers[0] = .{ .name = "DD-API-KEY", .value = api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };

    // Custom headers
    for (custom_headers, 0..) |custom, i| {
        headers[base_count + i] = .{ .name = custom.name, .value = custom.value };
    }

    return headers;
}

// ============================================================================
// HTTP Request Execution
// ============================================================================

/// Parse HTTP method string to enum
fn parseHttpMethod(method_str: []const u8) !std.http.Method {
    // Use stack buffer - HTTP methods are short (max 7 chars)
    if (method_str.len > 16) {
        return error.InvalidHttpMethod;
    }

    var buf: [16]u8 = undefined;
    const upper = std.ascii.upperString(buf[0..method_str.len], method_str);

    if (std.mem.eql(u8, upper, "GET")) return .GET;
    if (std.mem.eql(u8, upper, "POST")) return .POST;
    if (std.mem.eql(u8, upper, "PUT")) return .PUT;
    if (std.mem.eql(u8, upper, "DELETE")) return .DELETE;
    if (std.mem.eql(u8, upper, "PATCH")) return .PATCH;

    return error.InvalidHttpMethod;
}

/// Execute HTTP request
fn executeRequest(
    allocator: std.mem.Allocator,
    method: std.http.Method,
    url: []const u8,
    headers: []const std.http.Header,
    body: ?[]const u8,
) ![]const u8 {
    var client: std.http.Client = .{
        .allocator = allocator,
    };
    defer client.deinit();

    var body_writer = std.Io.Writer.Allocating.init(allocator);
    defer body_writer.deinit();

    const result = try client.fetch(.{
        .location = .{ .url = url },
        .method = method,
        .extra_headers = headers,
        .response_writer = &body_writer.writer,
        .payload = body,
    });

    // Check response status
    if (result.status != .ok) {
        std.debug.print("Error: HTTP request failed with status: {}\n", .{result.status});
        const response_body = body_writer.written();
        if (response_body.len > 0 and (response_body[0] == '{' or response_body[0] == '[')) {
            std.debug.print("Response: {s}\n", .{response_body});
        }
        return error.RequestFailed;
    }

    return try allocator.dupe(u8, body_writer.written());
}

// ============================================================================
// Query Parameter Helpers
// ============================================================================

/// Build query parameters including optional date range from config
fn buildQueryParams(
    allocator: std.mem.Allocator,
    config: *const Config,
    extra_params: []const QueryParam,
) ![]QueryParam {
    var params: std.ArrayList(QueryParam) = .empty;
    errdefer params.deinit(allocator);

    // Add extra params first
    for (extra_params) |param| {
        try params.append(allocator, param);
    }

    // Add date range if present
    if (config.from_timestamp) |from| {
        try params.append(allocator, .{ .key = "from", .value = from });
    }
    if (config.to_timestamp) |to| {
        try params.append(allocator, .{ .key = "to", .value = to });
    }

    return try params.toOwnedSlice(allocator);
}

// ============================================================================
// Output Helpers
// ============================================================================

/// Write response to stdout with newline
/// Uses unbuffered writes to avoid buffer size limitations
fn writeOutput(response: []const u8) !void {
    const stdout = std.fs.File.stdout();
    try stdout.writeAll(response);
    try stdout.writeAll("\n");
}

// ============================================================================
// Logs API Helpers
// ============================================================================

// Datadog Logs API constants
const DATADOG_MAX_PAGE_SIZE: usize = 1000;
const DATADOG_DEFAULT_PAGE_SIZE: usize = 1000;

/// Escape a string for JSON (handles all control characters)
fn jsonEscape(allocator: std.mem.Allocator, input: []const u8) ![]const u8 {
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    for (input) |c| {
        switch (c) {
            '"' => try result.appendSlice(allocator, "\\\""),
            '\\' => try result.appendSlice(allocator, "\\\\"),
            '\n' => try result.appendSlice(allocator, "\\n"),
            '\r' => try result.appendSlice(allocator, "\\r"),
            '\t' => try result.appendSlice(allocator, "\\t"),
            '\x08' => try result.appendSlice(allocator, "\\b"),
            '\x0C' => try result.appendSlice(allocator, "\\f"),
            0x00...0x07, 0x0B, 0x0E...0x1F => {
                try result.writer(allocator).print("\\u{x:0>4}", .{c});
            },
            else => try result.append(allocator, c),
        }
    }

    return result.toOwnedSlice(allocator);
}

/// Build JSON request body for logs search API
fn buildLogsSearchBody(
    arena: std.mem.Allocator,
    filter: LogsFilter,
    page: LogsPage,
    sort: ?[]const u8,
) ![]const u8 {
    var body: std.ArrayList(u8) = .empty;
    errdefer body.deinit(arena);

    try body.appendSlice(arena, "{\"filter\":{");

    // Add query
    try body.appendSlice(arena, "\"query\":\"");
    const escaped_query = try jsonEscape(arena, filter.query);
    try body.appendSlice(arena, escaped_query);
    try body.appendSlice(arena, "\"");

    // Add indexes
    try body.appendSlice(arena, ",\"indexes\":[");
    for (filter.indexes, 0..) |index, i| {
        if (i > 0) try body.appendSlice(arena, ",");
        try body.appendSlice(arena, "\"");
        const escaped_index = try jsonEscape(arena, index);
        try body.appendSlice(arena, escaped_index);
        try body.appendSlice(arena, "\"");
    }
    try body.appendSlice(arena, "]");

    // Add optional time range
    if (filter.from) |from| {
        try body.appendSlice(arena, ",\"from\":\"");
        const escaped_from = try jsonEscape(arena, from);
        try body.appendSlice(arena, escaped_from);
        try body.appendSlice(arena, "\"");
    }
    if (filter.to) |to| {
        try body.appendSlice(arena, ",\"to\":\"");
        const escaped_to = try jsonEscape(arena, to);
        try body.appendSlice(arena, escaped_to);
        try body.appendSlice(arena, "\"");
    }

    try body.appendSlice(arena, "},\"page\":{");

    // Add page limit
    const limit_str = try std.fmt.allocPrint(arena, "{d}", .{page.limit});
    try body.appendSlice(arena, "\"limit\":");
    try body.appendSlice(arena, limit_str);

    // Add cursor if present
    if (page.cursor) |cursor| {
        try body.appendSlice(arena, ",\"cursor\":\"");
        const escaped_cursor = try jsonEscape(arena, cursor);
        try body.appendSlice(arena, escaped_cursor);
        try body.appendSlice(arena, "\"");
    }

    try body.appendSlice(arena, "}");

    // Add sort if present
    if (sort) |s| {
        try body.appendSlice(arena, ",\"sort\":\"");
        const escaped_sort = try jsonEscape(arena, s);
        try body.appendSlice(arena, escaped_sort);
        try body.appendSlice(arena, "\"");
    }

    try body.appendSlice(arena, "}");

    return body.toOwnedSlice(arena);
}

/// Convert a std.json.Value to JSON string
fn valueToJson(allocator: std.mem.Allocator, value: std.json.Value) error{OutOfMemory}![]const u8 {
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    try valueToJsonWriter(allocator, value, &result);
    return result.toOwnedSlice(allocator);
}

fn valueToJsonWriter(allocator: std.mem.Allocator, value: std.json.Value, list: *std.ArrayList(u8)) error{OutOfMemory}!void {
    switch (value) {
        .null => try list.appendSlice(allocator, "null"),
        .bool => |b| try list.appendSlice(allocator, if (b) "true" else "false"),
        .integer => |i| {
            const str = try std.fmt.allocPrint(allocator, "{d}", .{i});
            defer allocator.free(str);
            try list.appendSlice(allocator, str);
        },
        .float => |f| {
            const str = try std.fmt.allocPrint(allocator, "{d}", .{f});
            defer allocator.free(str);
            try list.appendSlice(allocator, str);
        },
        .number_string => |ns| try list.appendSlice(allocator, ns),
        .string => |s| {
            try list.append(allocator, '"');
            const escaped = try jsonEscape(allocator, s);
            defer allocator.free(escaped);
            try list.appendSlice(allocator, escaped);
            try list.append(allocator, '"');
        },
        .array => |arr| {
            try list.append(allocator, '[');
            for (arr.items, 0..) |item, i| {
                if (i > 0) try list.append(allocator, ',');
                try valueToJsonWriter(allocator, item, list);
            }
            try list.append(allocator, ']');
        },
        .object => |obj| {
            try list.append(allocator, '{');
            var first = true;
            var iter = obj.iterator();
            while (iter.next()) |entry| {
                if (!first) try list.append(allocator, ',');
                first = false;
                try list.append(allocator, '"');
                const escaped_key = try jsonEscape(allocator, entry.key_ptr.*);
                defer allocator.free(escaped_key);
                try list.appendSlice(allocator, escaped_key);
                try list.appendSlice(allocator, "\":");
                try valueToJsonWriter(allocator, entry.value_ptr.*, list);
            }
            try list.append(allocator, '}');
        },
    }
}

/// Write a single log line as JSON to stdout with immediate flush
fn writeLogLine(allocator: std.mem.Allocator, log_value: std.json.Value) !void {
    const json_str = try valueToJson(allocator, log_value);
    defer allocator.free(json_str);

    const stdout_file = std.fs.File.stdout();
    try stdout_file.writeAll(json_str);
    try stdout_file.writeAll("\n");
}

/// Stream logs with automatic pagination
fn streamLogsSearch(
    allocator: std.mem.Allocator,
    url_base: []const u8,
    headers: []const std.http.Header,
    filter: LogsFilter,
    page_limit: usize,
    sort: ?[]const u8,
    limit: ?usize, // null = unlimited
    auto_paginate: bool,
) !void {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    var total_output: usize = 0;
    var cursor: ?[]const u8 = null;
    defer if (cursor) |c| allocator.free(c); // Free cursor at end of function
    var page_num: usize = 1;

    while (true) {
        // Check if we've hit the limit
        if (limit) |max| {
            if (total_output >= max) break;
        }

        // Build request body with current cursor
        const page = LogsPage{
            .cursor = cursor,
            .limit = page_limit,
        };
        const body = try buildLogsSearchBody(arena.allocator(), filter, page, sort);

        // Execute request
        var client: std.http.Client = .{
            .allocator = arena.allocator(),
        };
        defer client.deinit();

        var body_writer = std.Io.Writer.Allocating.init(arena.allocator());
        defer body_writer.deinit();

        const result = client.fetch(.{
            .location = .{ .url = url_base },
            .method = .POST,
            .extra_headers = headers,
            .response_writer = &body_writer.writer,
            .payload = body,
        }) catch |err| {
            std.debug.print("Error: Request failed on page {d}\n", .{page_num});
            std.debug.print("Successfully retrieved {d} logs before failure.\n", .{total_output});
            std.debug.print("Network error: {}\n", .{err});
            return err;
        };

        // Check response status
        if (result.status != .ok) {
            std.debug.print("Error: HTTP request failed with status: {}\n", .{result.status});
            const response_body = body_writer.written();
            if (response_body.len > 0 and (response_body[0] == '{' or response_body[0] == '[')) {
                std.debug.print("Response: {s}\n", .{response_body});
            }
            if (result.status == .too_many_requests) {
                std.debug.print("Successfully retrieved {d} logs before rate limit.\n", .{total_output});
                std.debug.print("Consider reducing --limit or narrowing --query to reduce data volume.\n", .{});
            } else if (page_num > 1) {
                std.debug.print("Successfully retrieved {d} logs before failure.\n", .{total_output});
            }
            return error.RequestFailed;
        }

        // Parse response
        const response_body = body_writer.written();
        const parsed = std.json.parseFromSlice(
            std.json.Value,
            arena.allocator(),
            response_body,
            .{},
        ) catch |err| {
            std.debug.print("Error: Failed to parse JSON response on page {d}\n", .{page_num});
            std.debug.print("Successfully retrieved {d} logs before failure.\n", .{total_output});
            return err;
        };
        defer parsed.deinit();

        // Extract data array
        const data_array = if (parsed.value.object.get("data")) |data|
            if (data == .array) data.array else return error.InvalidResponse
        else
            return error.InvalidResponse;

        // Stream each log
        for (data_array.items) |log| {
            // Check limit before output
            if (limit) |max| {
                if (total_output >= max) break;
            }

            try writeLogLine(allocator, log);
            total_output += 1;
        }

        // Check if we should continue pagination
        if (!auto_paginate) break; // Single page mode

        // Extract next cursor
        const next_cursor = if (parsed.value.object.get("meta")) |meta|
            if (meta.object.get("page")) |page_meta|
                if (page_meta.object.get("after")) |after|
                    if (after == .string) after.string else null
                else
                    null
            else
                null
        else
            null;

        // Stop if no more pages
        if (next_cursor == null) break;

        // Update cursor for next iteration
        // Free old cursor before allocating new one (escaping arena memory)
        if (cursor) |old_cursor| allocator.free(old_cursor);
        cursor = try allocator.dupe(u8, next_cursor.?);

        page_num += 1;

        // Reset arena for next iteration
        _ = arena.reset(.retain_capacity);
    }
}

// ============================================================================
// Command Handlers
// ============================================================================

fn handleRawCommand(
    allocator: std.mem.Allocator,
    root_matches: *const yazap.ArgMatches,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Get global options from root_matches
    const domain_arg = root_matches.getSingleValue("domain");
    const from_arg = root_matches.getSingleValue("from");
    const to_arg = root_matches.getSingleValue("to");
    var config = try initConfig(allocator, domain_arg, from_arg, to_arg);
    defer config.deinit();

    // Parse arguments
    const path = cmd_matches.getSingleValue("path") orelse {
        std.debug.print("Error: --path is required for raw command\n", .{});
        return error.MissingPath;
    };

    const method_str = cmd_matches.getSingleValue("method") orelse "GET";
    const method = parseHttpMethod(method_str) catch |err| {
        std.debug.print("Error: Invalid HTTP method '{s}'. Supported: GET, POST, PUT, DELETE, PATCH\n", .{method_str});
        return err;
    };

    const query_string = cmd_matches.getSingleValue("query");
    const body = cmd_matches.getSingleValue("data");

    // Build URL (raw - no encoding)
    const url = try buildRawUrl(arena_alloc, config.dd_domain, path, query_string);

    // Parse custom headers
    var custom_headers: std.ArrayList(CustomHeader) = .empty;
    if (cmd_matches.getMultiValues("header")) |header_strs| {
        for (header_strs) |h_str| {
            const h = parseHeader(h_str) catch |err| {
                std.debug.print("Error: Invalid header format '{s}'. Expected 'Name:Value'\n", .{h_str});
                return err;
            };
            try custom_headers.append(arena_alloc, h);
        }
    }

    // Build header list
    const headers = try buildHeaders(arena_alloc, config.api_key, config.app_key, custom_headers.items);

    // Execute request
    const response = try executeRequest(arena_alloc, method, url, headers, body);

    // Output
    try writeOutput(response);
}

fn handleValidateCommand(
    allocator: std.mem.Allocator,
    root_matches: *const yazap.ArgMatches,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    _ = cmd_matches;

    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const domain_arg = root_matches.getSingleValue("domain");
    const from_arg = root_matches.getSingleValue("from");
    const to_arg = root_matches.getSingleValue("to");
    var config = try initConfig(allocator, domain_arg, from_arg, to_arg);
    defer config.deinit();

    // Hardcoded path
    const path = "/api/v1/validate";
    const url = try buildRawUrl(arena_alloc, config.dd_domain, path, null);

    const headers = try buildHeaders(arena_alloc, config.api_key, config.app_key, &[_]CustomHeader{});

    const response = try executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try writeOutput(response);
}

fn handleHostList(
    allocator: std.mem.Allocator,
    root_matches: *const yazap.ArgMatches,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const domain_arg = root_matches.getSingleValue("domain");
    const from_arg = root_matches.getSingleValue("from");
    const to_arg = root_matches.getSingleValue("to");
    var config = try initConfig(allocator, domain_arg, from_arg, to_arg);
    defer config.deinit();

    // Optional FILTER positional argument
    const filter = cmd_matches.getSingleValue("FILTER");

    const path = "/api/v1/hosts";

    // Build query params including optional filter and date range
    const extra_params = if (filter) |f|
        &[_]QueryParam{.{ .key = "filter", .value = f }}
    else
        &[_]QueryParam{};

    const query_params = try buildQueryParams(arena_alloc, &config, extra_params);
    defer arena_alloc.free(query_params);

    const url = try buildUrl(arena_alloc, config.dd_domain, path, query_params);

    const headers = try buildHeaders(arena_alloc, config.api_key, config.app_key, &[_]CustomHeader{});

    const response = try executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try writeOutput(response);
}

fn handleHostGet(
    allocator: std.mem.Allocator,
    root_matches: *const yazap.ArgMatches,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const domain_arg = root_matches.getSingleValue("domain");
    const from_arg = root_matches.getSingleValue("from");
    const to_arg = root_matches.getSingleValue("to");
    var config = try initConfig(allocator, domain_arg, from_arg, to_arg);
    defer config.deinit();

    // Get positional HOST_NAME argument
    const host_name = cmd_matches.getSingleValue("HOST_NAME") orelse {
        std.debug.print("Error: HOST_NAME argument is required\n", .{});
        return error.MissingHostName;
    };

    // URL encode host name for path safety
    const encoded_host = try urlEncode(arena_alloc, host_name);

    // Build path with host name
    const path = try std.fmt.allocPrint(arena_alloc, "/api/v1/hosts/{s}", .{encoded_host});
    const url = try buildUrl(arena_alloc, config.dd_domain, path, null);

    const headers = try buildHeaders(arena_alloc, config.api_key, config.app_key, &[_]CustomHeader{});

    const response = try executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try writeOutput(response);
}

fn handleLogsSearch(
    allocator: std.mem.Allocator,
    root_matches: *const yazap.ArgMatches,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Get global options
    const domain_arg = root_matches.getSingleValue("domain");
    const from_arg = root_matches.getSingleValue("from");
    const to_arg = root_matches.getSingleValue("to");
    var config = try initConfig(allocator, domain_arg, from_arg, to_arg);
    defer config.deinit();

    // Parse command options
    const query = cmd_matches.getSingleValue("query") orelse "*";
    const indexes_str = cmd_matches.getSingleValue("indexes") orelse "*";
    const sort = cmd_matches.getSingleValue("sort") orelse "-timestamp";
    const auto_paginate = cmd_matches.containsArg("auto-paginate");

    // Parse page size (default DATADOG_DEFAULT_PAGE_SIZE, max DATADOG_MAX_PAGE_SIZE)
    const page_size_str = cmd_matches.getSingleValue("page-size");
    const page_size = if (page_size_str) |ps_str|
        std.fmt.parseInt(usize, ps_str, 10) catch {
            std.debug.print("Error: Invalid page-size value '{s}'. Must be a positive integer.\n", .{ps_str});
            return error.InvalidPageSize;
        }
    else
        DATADOG_DEFAULT_PAGE_SIZE;

    if (page_size > DATADOG_MAX_PAGE_SIZE) {
        std.debug.print("Error: page-size cannot exceed {d} (API limit)\n", .{DATADOG_MAX_PAGE_SIZE});
        return error.PageSizeTooLarge;
    }

    // Parse limit
    const limit_str = cmd_matches.getSingleValue("limit");
    const limit: ?usize = if (limit_str) |l_str|
        std.fmt.parseInt(usize, l_str, 10) catch {
            std.debug.print("Error: Invalid limit value '{s}'. Must be a positive integer.\n", .{l_str});
            return error.InvalidLimit;
        }
    else if (auto_paginate)
        null // unlimited with auto-paginate
    else
        DATADOG_DEFAULT_PAGE_SIZE; // default for single page

    // Parse indexes (comma-separated)
    var indexes: std.ArrayList([]const u8) = .empty;
    var index_iter = std.mem.splitScalar(u8, indexes_str, ',');
    while (index_iter.next()) |index| {
        const trimmed = std.mem.trim(u8, index, " \t");
        if (trimmed.len > 0) {
            try indexes.append(arena_alloc, trimmed);
        }
    }

    // Build filter
    const filter = LogsFilter{
        .from = config.from_timestamp,
        .to = config.to_timestamp,
        .query = query,
        .indexes = indexes.items,
    };

    // Build URL
    const path = "/api/v2/logs/events/search";
    const url = try buildRawUrl(arena_alloc, config.dd_domain, path, null);

    // Build headers (need Content-Type for POST, Accept-Encoding to disable compression)
    const base_count = 5; // DD-API-KEY, DD-APPLICATION-KEY, Accept, Content-Type, Accept-Encoding
    var headers = try arena_alloc.alloc(std.http.Header, base_count);
    headers[0] = .{ .name = "DD-API-KEY", .value = config.api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = config.app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };
    headers[3] = .{ .name = "Content-Type", .value = "application/json" };
    headers[4] = .{ .name = "Accept-Encoding", .value = "identity" }; // Disable compression

    // Stream logs with pagination
    try streamLogsSearch(
        allocator,
        url,
        headers,
        filter,
        page_size,
        sort,
        limit,
        auto_paginate,
    );
}

// ============================================================================
// Main Entry Point
// ============================================================================

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Set up argument parser with subcommands
    var app = App.init(allocator, "dd-cli", "Query Datadog API with subcommands for common operations");
    defer app.deinit();

    var root = app.rootCommand();

    // Global flags
    try root.addArg(Arg.singleValueOption("domain", 'd', "Datadog domain (e.g., datadoghq.com, datadoghq.eu)"));
    try root.addArg(Arg.singleValueOption("from", null, "Start time in ISO 8601 format (e.g., 2024-01-15T10:00:00Z)"));
    try root.addArg(Arg.singleValueOption("to", null, "End time in ISO 8601 format (e.g., 2024-01-15T11:00:00Z)"));

    // Raw command - low-level API access
    var raw_cmd = app.createCommand("raw", "Low-level API access with full control");
    try raw_cmd.addArg(Arg.singleValueOption("path", 'p', "API path (e.g., /api/v1/hosts)"));
    try raw_cmd.addArg(Arg.singleValueOption("method", 'X', "HTTP method (default: GET)"));
    try raw_cmd.addArg(Arg.singleValueOption("query", 'q', "Pre-formatted query string"));
    try raw_cmd.addArg(Arg.multiValuesOption("header", 'H', "Custom header (Name:Value, repeatable)", 20));
    try raw_cmd.addArg(Arg.singleValueOption("data", null, "Request body"));
    try root.addSubcommand(raw_cmd);

    // Validate command - credential validation
    const validate_cmd = app.createCommand("validate", "Validate API credentials");
    try root.addSubcommand(validate_cmd);

    // Host command with subcommands
    var host_cmd = app.createCommand("host", "Host infrastructure management");

    var host_list_cmd = app.createCommand("list", "List/search hosts");
    var filter_arg = Arg.positional("FILTER", "Filter query string (optional)", null);
    filter_arg.setMinValues(0);
    try host_list_cmd.addArg(filter_arg);
    try host_cmd.addSubcommand(host_list_cmd);

    var host_get_cmd = app.createCommand("get", "Get specific host information");
    try host_get_cmd.addArg(Arg.positional("HOST_NAME", "Host identifier", null));
    try host_cmd.addSubcommand(host_get_cmd);

    try root.addSubcommand(host_cmd);

    // Logs command with subcommands
    var logs_cmd = app.createCommand("logs", "Query logs");

    var logs_search_cmd = app.createCommand("search", "Search log events");
    try logs_search_cmd.addArg(Arg.singleValueOption("query", 'q', "Search query (default: *)"));
    try logs_search_cmd.addArg(Arg.singleValueOption("indexes", 'i', "Comma-separated indexes (default: *)"));
    try logs_search_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max total logs (default: 1000 without --auto-paginate, unlimited with)"));
    try logs_search_cmd.addArg(Arg.singleValueOption("page-size", null, "Logs per API request (default: 1000, max: 1000)"));
    try logs_search_cmd.addArg(Arg.singleValueOption("sort", 's', "Sort order (default: -timestamp)"));
    try logs_search_cmd.addArg(Arg.booleanOption("auto-paginate", null, "Fetch multiple pages automatically"));
    try logs_cmd.addSubcommand(logs_search_cmd);

    try root.addSubcommand(logs_cmd);

    // Parse arguments
    const matches = try app.parseProcess();

    // Dispatch to appropriate handler
    if (matches.subcommandMatches("raw")) |*raw_matches| {
        try handleRawCommand(allocator, &matches, raw_matches);
    } else if (matches.subcommandMatches("validate")) |*val_matches| {
        try handleValidateCommand(allocator, &matches, val_matches);
    } else if (matches.subcommandMatches("host")) |*host_matches| {
        if (host_matches.subcommandMatches("list")) |*list_matches| {
            try handleHostList(allocator, &matches, list_matches);
        } else if (host_matches.subcommandMatches("get")) |*get_matches| {
            try handleHostGet(allocator, &matches, get_matches);
        } else {
            std.debug.print("Error: Unknown host subcommand. Use 'host list' or 'host get'\n", .{});
            return error.UnknownSubcommand;
        }
    } else if (matches.subcommandMatches("logs")) |*logs_matches| {
        if (logs_matches.subcommandMatches("search")) |*search_matches| {
            try handleLogsSearch(allocator, &matches, search_matches);
        } else {
            std.debug.print("Error: Use 'logs search' subcommand\n", .{});
            return error.UnknownSubcommand;
        }
    } else {
        std.debug.print("Error: No subcommand specified. Use 'raw', 'validate', 'host', or 'logs'\n", .{});
        return error.NoSubcommand;
    }
}

// ============================================================================
// Tests
// ============================================================================

test {
    std.testing.refAllDecls(@This());
}

test "isValidDatadogDomain - valid domains" {
    try std.testing.expect(isValidDatadogDomain("datadoghq.com"));
    try std.testing.expect(isValidDatadogDomain("datadoghq.eu"));
    try std.testing.expect(isValidDatadogDomain("api.datadoghq.com"));
    try std.testing.expect(isValidDatadogDomain("app.datadoghq.com"));
    try std.testing.expect(isValidDatadogDomain("us3.datadoghq.com"));
}

test "isValidDatadogDomain - invalid domains" {
    try std.testing.expect(!isValidDatadogDomain("example.com"));
    try std.testing.expect(!isValidDatadogDomain("evil-datadoghq.com.attacker.com"));
    try std.testing.expect(!isValidDatadogDomain("notdatadog.com"));
}

test "urlEncode - special characters" {
    const result = try urlEncode(std.testing.allocator, "env:prod,role:db");
    defer std.testing.allocator.free(result);
    try std.testing.expectEqualStrings("env%3Aprod%2Crole%3Adb", result);
}

test "urlEncode - spaces and mixed characters" {
    const result = try urlEncode(std.testing.allocator, "hello world: test");
    defer std.testing.allocator.free(result);
    try std.testing.expectEqualStrings("hello%20world%3A%20test", result);
}

test "urlEncode - unreserved characters" {
    const result = try urlEncode(std.testing.allocator, "abc-DEF_123.~");
    defer std.testing.allocator.free(result);
    try std.testing.expectEqualStrings("abc-DEF_123.~", result);
}

test "parseHeader - with colon in value" {
    const h = try parseHeader("Authorization:Bearer tok:en:123");
    try std.testing.expectEqualStrings("Authorization", h.name);
    try std.testing.expectEqualStrings("Bearer tok:en:123", h.value);
}

test "parseHeader - missing colon" {
    try std.testing.expectError(error.InvalidHeader, parseHeader("NoColonHere"));
}

test "parseHttpMethod - valid methods" {
    try std.testing.expectEqual(std.http.Method.GET, try parseHttpMethod("GET"));
    try std.testing.expectEqual(std.http.Method.POST, try parseHttpMethod("POST"));
    try std.testing.expectEqual(std.http.Method.PUT, try parseHttpMethod("PUT"));
    try std.testing.expectEqual(std.http.Method.DELETE, try parseHttpMethod("DELETE"));
    try std.testing.expectEqual(std.http.Method.PATCH, try parseHttpMethod("PATCH"));
}

test "parseHttpMethod - case insensitive" {
    try std.testing.expectEqual(std.http.Method.GET, try parseHttpMethod("get"));
    try std.testing.expectEqual(std.http.Method.POST, try parseHttpMethod("post"));
}

test "parseHttpMethod - invalid method" {
    try std.testing.expectError(error.InvalidHttpMethod, parseHttpMethod("INVALID"));
}

test "buildUrl - with query params" {
    const params = [_]QueryParam{
        .{ .key = "filter", .value = "env:prod" },
        .{ .key = "count", .value = "10" },
    };
    const url = try buildUrl(std.testing.allocator, "datadoghq.com", "/api/v1/hosts", &params);
    defer std.testing.allocator.free(url);
    try std.testing.expectEqualStrings(
        "https://api.datadoghq.com/api/v1/hosts?filter=env%3Aprod&count=10",
        url,
    );
}

test "buildUrl - without query params" {
    const url = try buildUrl(std.testing.allocator, "datadoghq.com", "/api/v1/validate", null);
    defer std.testing.allocator.free(url);
    try std.testing.expectEqualStrings("https://api.datadoghq.com/api/v1/validate", url);
}

test "buildUrl - domain already has api prefix" {
    const url = try buildUrl(std.testing.allocator, "api.datadoghq.eu", "/api/v1/hosts", null);
    defer std.testing.allocator.free(url);
    try std.testing.expectEqualStrings("https://api.datadoghq.eu/api/v1/hosts", url);
}

test "buildRawUrl - no encoding" {
    const url = try buildRawUrl(
        std.testing.allocator,
        "datadoghq.com",
        "/api/v1/hosts",
        "filter=env:prod&count=10",
    );
    defer std.testing.allocator.free(url);
    // Query string should be unchanged (no encoding)
    try std.testing.expectEqualStrings(
        "https://api.datadoghq.com/api/v1/hosts?filter=env:prod&count=10",
        url,
    );
}

test "buildRawUrl - without query string" {
    const url = try buildRawUrl(std.testing.allocator, "datadoghq.com", "/api/v1/validate", null);
    defer std.testing.allocator.free(url);
    try std.testing.expectEqualStrings("https://api.datadoghq.com/api/v1/validate", url);
}

test "buildUrl - query keys are encoded" {
    const params = [_]QueryParam{
        .{ .key = "filter[name]", .value = "test value" },
    };
    const url = try buildUrl(std.testing.allocator, "datadoghq.com", "/api/v1/search", &params);
    defer std.testing.allocator.free(url);
    // Both key and value should be encoded
    try std.testing.expectEqualStrings(
        "https://api.datadoghq.com/api/v1/search?filter%5Bname%5D=test%20value",
        url,
    );
}

test "buildQueryParams - includes date range" {
    const config = Config{
        .allocator = std.testing.allocator,
        .dd_domain = "datadoghq.com",
        .dd_domain_owned = null,
        .api_key = "test_key",
        .app_key = "test_app_key",
        .from_timestamp = "2024-01-15T00:00:00Z",
        .to_timestamp = "2024-01-15T23:59:59Z",
    };

    const extra = [_]QueryParam{
        .{ .key = "filter", .value = "env:prod" },
    };

    const params = try buildQueryParams(std.testing.allocator, &config, &extra);
    defer std.testing.allocator.free(params);

    // Should have filter + from + to
    try std.testing.expectEqual(@as(usize, 3), params.len);
    try std.testing.expectEqualStrings("filter", params[0].key);
    try std.testing.expectEqualStrings("env:prod", params[0].value);
    try std.testing.expectEqualStrings("from", params[1].key);
    try std.testing.expectEqualStrings("2024-01-15T00:00:00Z", params[1].value);
    try std.testing.expectEqualStrings("to", params[2].key);
    try std.testing.expectEqualStrings("2024-01-15T23:59:59Z", params[2].value);
}

test "buildQueryParams - no date range" {
    const config = Config{
        .allocator = std.testing.allocator,
        .dd_domain = "datadoghq.com",
        .dd_domain_owned = null,
        .api_key = "test_key",
        .app_key = "test_app_key",
        .from_timestamp = null,
        .to_timestamp = null,
    };

    const extra = [_]QueryParam{
        .{ .key = "filter", .value = "env:prod" },
    };

    const params = try buildQueryParams(std.testing.allocator, &config, &extra);
    defer std.testing.allocator.free(params);

    // Should only have filter
    try std.testing.expectEqual(@as(usize, 1), params.len);
    try std.testing.expectEqualStrings("filter", params[0].key);
}

test "buildLogsSearchBody - basic request" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const filter = LogsFilter{
        .from = "2024-01-15T10:00:00Z",
        .to = "2024-01-15T11:00:00Z",
        .query = "*",
        .indexes = &[_][]const u8{"*"},
    };
    const page = LogsPage{ .cursor = null, .limit = 1000 };

    const body = try buildLogsSearchBody(arena.allocator(), filter, page, "-timestamp");

    // Verify valid JSON structure
    const parsed = try std.json.parseFromSlice(std.json.Value, arena.allocator(), body, .{});
    defer parsed.deinit();

    try std.testing.expect(parsed.value.object.get("filter") != null);
    try std.testing.expect(parsed.value.object.get("page") != null);
    try std.testing.expectEqual(@as(i64, 1000), parsed.value.object.get("page").?.object.get("limit").?.integer);
}

test "buildLogsSearchBody - with cursor" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const filter = LogsFilter{
        .from = "2024-01-15T10:00:00Z",
        .to = "2024-01-15T11:00:00Z",
        .query = "status:error",
        .indexes = &[_][]const u8{"main"},
    };
    const page = LogsPage{ .cursor = "eyJhZnRlciI6InRlc3QiLCJ2YWx1ZXMiOltdfQ==", .limit = 1000 };

    const body = try buildLogsSearchBody(arena.allocator(), filter, page, "-timestamp");

    // Verify cursor included
    const parsed = try std.json.parseFromSlice(std.json.Value, arena.allocator(), body, .{});
    defer parsed.deinit();

    const page_obj = parsed.value.object.get("page").?.object;
    try std.testing.expect(page_obj.get("cursor") != null);
    try std.testing.expectEqualStrings("eyJhZnRlciI6InRlc3QiLCJ2YWx1ZXMiOltdfQ==", page_obj.get("cursor").?.string);
}

test "buildLogsSearchBody - optional time range" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const filter = LogsFilter{
        .from = null,
        .to = null,
        .query = "*",
        .indexes = &[_][]const u8{"*"},
    };
    const page = LogsPage{ .cursor = null, .limit = 500 };

    const body = try buildLogsSearchBody(arena.allocator(), filter, page, null);

    // Verify structure (should not have from/to if not provided)
    const parsed = try std.json.parseFromSlice(std.json.Value, arena.allocator(), body, .{});
    defer parsed.deinit();

    try std.testing.expect(parsed.value.object.get("filter") != null);
    const filter_obj = parsed.value.object.get("filter").?.object;
    try std.testing.expect(filter_obj.get("from") == null);
    try std.testing.expect(filter_obj.get("to") == null);
}

test "buildLogsSearchBody - multiple indexes" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const filter = LogsFilter{
        .from = null,
        .to = null,
        .query = "service:web",
        .indexes = &[_][]const u8{ "main", "staging", "prod" },
    };
    const page = LogsPage{ .cursor = null, .limit = 100 };

    const body = try buildLogsSearchBody(arena.allocator(), filter, page, "-timestamp");

    // Verify indexes array
    const parsed = try std.json.parseFromSlice(std.json.Value, arena.allocator(), body, .{});
    defer parsed.deinit();

    const filter_obj = parsed.value.object.get("filter").?.object;
    const indexes = filter_obj.get("indexes").?.array;
    try std.testing.expectEqual(@as(usize, 3), indexes.items.len);
    try std.testing.expectEqualStrings("main", indexes.items[0].string);
    try std.testing.expectEqualStrings("staging", indexes.items[1].string);
    try std.testing.expectEqualStrings("prod", indexes.items[2].string);
}
