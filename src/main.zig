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

    config.app_key = std.process.getEnvVarOwned(allocator, "DD_APP_API_KEY") catch |err| {
        allocator.free(config.api_key);
        std.debug.print("Error: DD_APP_API_KEY environment variable not set\n", .{});
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
    } else {
        std.debug.print("Error: No subcommand specified. Use 'raw', 'validate', or 'host'\n", .{});
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
