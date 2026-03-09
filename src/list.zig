const std = @import("std");
const yazap = @import("yazap");
const common = @import("common.zig");

const QueryParam = common.QueryParam;
const CustomHeader = common.CustomHeader;
const LogsListRequest = common.LogsListRequest;
const LogsQueryFilter = common.LogsQueryFilter;
const LogsListRequestPage = common.LogsListRequestPage;

// ============================================================================
// Logs Streaming Helpers
// ============================================================================

/// Build JSON request body for logs search API using generated types
fn buildLogsSearchRequest(
    from_timestamp: ?[]const u8,
    to_timestamp: ?[]const u8,
    query: []const u8,
    indexes: []const []const u8,
    cursor: ?[]const u8,
    limit: i64,
    _: ?[]const u8, // sort parameter (unused - API expects LogsSort struct)
) LogsListRequest {
    return LogsListRequest{
        .filter = LogsQueryFilter{
            .from = from_timestamp,
            .to = to_timestamp,
            .query = query,
            .indexes = indexes,
            .storage_tier = null,
        },
        .page = LogsListRequestPage{
            .cursor = cursor,
            .limit = limit,
        },
        .sort = null, // FIXME: sort should be a string, but API expects LogsSort struct
        .options = null,
    };
}

/// Stream logs with automatic pagination
fn streamLogsSearch(
    allocator: std.mem.Allocator,
    url_base: []const u8,
    headers: []const std.http.Header,
    from_timestamp: ?[]const u8,
    to_timestamp: ?[]const u8,
    query: []const u8,
    indexes: []const []const u8,
    page_limit: i64,
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

        // Build request using generated types
        const request = buildLogsSearchRequest(
            from_timestamp,
            to_timestamp,
            query,
            indexes,
            cursor,
            page_limit,
            sort,
        );

        // Serialize to JSON using fmt
        const body = try std.fmt.allocPrint(arena.allocator(), "{f}", .{std.json.fmt(request, .{ .emit_null_optional_fields = false })});

        // Execute request
        // Use outer allocator for client to survive arena reset
        var client: std.http.Client = .{
            .allocator = allocator,
        };
        defer client.deinit();

        // Use outer allocator for body_writer so it survives arena reset
        var body_writer = std.Io.Writer.Allocating.init(allocator);
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

            try common.writeLogLine(allocator, log);
            total_output += 1;
        }

        // Check if we should continue pagination
        if (!auto_paginate) {
            parsed.deinit();
            break; // Single page mode
        }

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
        if (next_cursor == null) {
            parsed.deinit();
            break;
        }

        // Update cursor for next iteration
        // Free old cursor before allocating new one (escaping arena memory)
        if (cursor) |old_cursor| allocator.free(old_cursor);
        cursor = try allocator.dupe(u8, next_cursor.?);

        page_num += 1;

        // Clean up parsed data before resetting arena
        parsed.deinit();

        // Reset arena for next iteration
        _ = arena.reset(.retain_capacity);
    }
}

// ============================================================================
// Spans Streaming Helpers
// ============================================================================

/// Stream spans with automatic pagination
fn streamSpansSearch(
    allocator: std.mem.Allocator,
    url_base: []const u8,
    headers: []const std.http.Header,
    from_timestamp: ?[]const u8,
    to_timestamp: ?[]const u8,
    query: []const u8,
    page_limit: i64,
    sort: ?[]const u8,
    limit: ?usize,
    auto_paginate: bool,
) !void {
    var arena = std.heap.ArenaAllocator.init(allocator);
    defer arena.deinit();

    var total_output: usize = 0;
    var cursor: ?[]const u8 = null;
    defer if (cursor) |c| allocator.free(c);
    var page_num: usize = 1;

    while (true) {
        // Check if we've hit the limit
        if (limit) |max| {
            if (total_output >= max) break;
        }

        // Build request JSON
        const escaped_query = try common.jsonEscape(arena.allocator(), query);
        defer arena.allocator().free(escaped_query);

        const from_json = if (from_timestamp) |from| blk: {
            const escaped = try common.jsonEscape(arena.allocator(), from);
            defer arena.allocator().free(escaped);
            break :blk try std.fmt.allocPrint(arena.allocator(), "\"{s}\"", .{escaped});
        } else try arena.allocator().dupe(u8, "null");

        const to_json = if (to_timestamp) |to| blk: {
            const escaped = try common.jsonEscape(arena.allocator(), to);
            defer arena.allocator().free(escaped);
            break :blk try std.fmt.allocPrint(arena.allocator(), "\"{s}\"", .{escaped});
        } else try arena.allocator().dupe(u8, "null");

        const cursor_json = if (cursor) |c| blk: {
            const escaped = try common.jsonEscape(arena.allocator(), c);
            defer arena.allocator().free(escaped);
            break :blk try std.fmt.allocPrint(arena.allocator(), "\"{s}\"", .{escaped});
        } else try arena.allocator().dupe(u8, "null");

        const sort_json = if (sort) |s| blk: {
            const escaped = try common.jsonEscape(arena.allocator(), s);
            defer arena.allocator().free(escaped);
            break :blk try std.fmt.allocPrint(arena.allocator(), "\"{s}\"", .{escaped});
        } else try arena.allocator().dupe(u8, "\"-timestamp\"");

        const body = try std.fmt.allocPrint(
            arena.allocator(),
            \\{{
            \\  "data": {{
            \\    "attributes": {{
            \\      "filter": {{
            \\        "from": {s},
            \\        "to": {s},
            \\        "query": "{s}"
            \\      }},
            \\      "sort": {s},
            \\      "page": {{
            \\        "limit": {d},
            \\        "cursor": {s}
            \\      }}
            \\    }},
            \\    "type": "search_request"
            \\  }}
            \\}}
            ,
            .{
                from_json,
                to_json,
                escaped_query,
                sort_json,
                page_limit,
                cursor_json,
            },
        );

        // Execute request
        var client: std.http.Client = .{
            .allocator = allocator,
        };
        defer client.deinit();

        var body_writer = std.Io.Writer.Allocating.init(allocator);
        defer body_writer.deinit();

        const result = client.fetch(.{
            .location = .{ .url = url_base },
            .method = .POST,
            .extra_headers = headers,
            .response_writer = &body_writer.writer,
            .payload = body,
        }) catch |err| {
            std.debug.print("Error: Request failed on page {d}\n", .{page_num});
            std.debug.print("Successfully retrieved {d} spans before failure.\n", .{total_output});
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
                std.debug.print("Successfully retrieved {d} spans before rate limit.\n", .{total_output});
                std.debug.print("Consider reducing --limit or narrowing query.\n", .{});
            } else if (page_num > 1) {
                std.debug.print("Successfully retrieved {d} spans before failure.\n", .{total_output});
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
            std.debug.print("Successfully retrieved {d} spans before failure.\n", .{total_output});
            return err;
        };

        // Extract data array
        const data_array = if (parsed.value.object.get("data")) |data|
            if (data == .array) data.array else return error.InvalidResponse
        else
            return error.InvalidResponse;

        // Stream each span
        for (data_array.items) |span| {
            // Check limit before output
            if (limit) |max| {
                if (total_output >= max) break;
            }

            try common.writeLogLine(allocator, span);
            total_output += 1;
        }

        // Check if we should continue pagination
        if (!auto_paginate) {
            parsed.deinit();
            break;
        }

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
        if (next_cursor == null) {
            parsed.deinit();
            break;
        }

        // Update cursor for next iteration
        if (cursor) |old_cursor| allocator.free(old_cursor);
        cursor = try allocator.dupe(u8, next_cursor.?);

        page_num += 1;

        // Clean up parsed data before resetting arena
        parsed.deinit();

        // Reset arena for next iteration
        _ = arena.reset(.retain_capacity);
    }
}

// ============================================================================
// List Command Handlers
// ============================================================================

pub fn handleLogsSearch(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Parse command options (positional FILTER argument, defaults to "*")
    const query = cmd_matches.getSingleValue("FILTER") orelse "*";
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
        common.DATADOG_DEFAULT_PAGE_SIZE;

    if (page_size > common.DATADOG_MAX_PAGE_SIZE) {
        std.debug.print("Error: page-size cannot exceed {d} (API limit)\n", .{common.DATADOG_MAX_PAGE_SIZE});
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
        common.DATADOG_DEFAULT_PAGE_SIZE; // default for single page

    // Parse indexes (comma-separated)
    var indexes: std.ArrayList([]const u8) = .empty;
    var index_iter = std.mem.splitScalar(u8, indexes_str, ',');
    while (index_iter.next()) |index| {
        const trimmed = std.mem.trim(u8, index, " \t");
        if (trimmed.len > 0) {
            try indexes.append(arena_alloc, trimmed);
        }
    }

    // Build URL
    const path = "/api/v2/logs/events/search";
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    // Build headers (need Content-Type for POST, Accept-Encoding to disable compression)
    const base_count = 5; // DD-API-KEY, DD-APPLICATION-KEY, Accept, Content-Type, Accept-Encoding
    var headers = try arena_alloc.alloc(std.http.Header, base_count);
    headers[0] = .{ .name = "DD-API-KEY", .value = ctx.api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = ctx.app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };
    headers[3] = .{ .name = "Content-Type", .value = "application/json" };
    headers[4] = .{ .name = "Accept-Encoding", .value = "identity" }; // Disable compression

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    // Stream logs with pagination using API types
    try streamLogsSearch(
        ctx.allocator,
        url,
        headers,
        ctx.from_timestamp,
        ctx.to_timestamp,
        query,
        indexes.items,
        @intCast(page_size),
        sort,
        limit,
        auto_paginate,
    );
}

pub fn handleHostList(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Optional FILTER positional argument
    const filter = cmd_matches.getSingleValue("FILTER");

    const path = "/api/v1/hosts";

    // Build query params - hosts API requires 'from' as Unix seconds (integer), not ISO
    var params_list: std.ArrayList(QueryParam) = .empty;
    defer params_list.deinit(arena_alloc);

    if (filter) |f| try params_list.append(arena_alloc, .{ .key = "filter", .value = f });

    if (ctx.from_timestamp) |from| {
        const unix_seconds = try common.parseIso8601ToUnix(from);
        const unix_str = try std.fmt.allocPrint(arena_alloc, "{d}", .{unix_seconds});
        try params_list.append(arena_alloc, .{ .key = "from", .value = unix_str });
    }

    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, params_list.items);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try common.writeOutput(response);
}

pub fn handleMetricsList(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Optional QUERY positional argument (default: "*")
    const query = cmd_matches.getSingleValue("QUERY") orelse "*";

    const path = "/api/v1/search";

    // Build query params with search query
    const query_params = [_]QueryParam{
        .{ .key = "q", .value = query },
    };

    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, &query_params);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try common.writeOutput(response);
}

pub fn handleApisList(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Build path
    const path = "/api/v2/apicatalog/api";

    // Build query parameters
    var query_params: std.ArrayList(QueryParam) = .empty;
    defer query_params.deinit(arena_alloc);

    // Add query filter if provided (positional argument)
    if (cmd_matches.getSingleValue("QUERY")) |query_val| {
        try query_params.append(arena_alloc, .{ .key = "query", .value = query_val });
    }

    // Add pagination parameters if provided
    if (cmd_matches.getSingleValue("limit")) |limit_val| {
        try query_params.append(arena_alloc, .{ .key = "page[limit]", .value = limit_val });
    }

    if (cmd_matches.getSingleValue("offset")) |offset_val| {
        try query_params.append(arena_alloc, .{ .key = "page[offset]", .value = offset_val });
    }

    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, query_params.items);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try common.writeOutput(response);
}

pub fn handleServicesList(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Parse command options
    const filter = cmd_matches.getSingleValue("FILTER");
    const env = cmd_matches.getSingleValue("env");

    // Build query parameters
    var params: std.ArrayList(QueryParam) = .empty;
    defer params.deinit(arena_alloc);

    // Add filter[env] (required by API, default to "*" for all environments)
    const env_val = env orelse "*";
    try params.append(arena_alloc, .{ .key = "filter[env]", .value = env_val });

    // Add service filter if specified
    if (filter) |filter_val| {
        try params.append(arena_alloc, .{ .key = "filter[service]", .value = filter_val });
    }

    // Add schema_version
    try params.append(arena_alloc, .{ .key = "schema_version", .value = "v2" });

    // Build URL
    const path = "/api/v2/apm/services";
    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, params.items);

    // Build headers
    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    // Execute request
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try common.writeOutput(response);
}

pub fn handleSpansSearch(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Parse command options
    const base_filter = cmd_matches.getSingleValue("FILTER");
    const service = cmd_matches.getSingleValue("service");
    const operation = cmd_matches.getSingleValue("operation");
    const resource = cmd_matches.getSingleValue("resource");
    const sort = cmd_matches.getSingleValue("sort") orelse "-timestamp";
    const auto_paginate = cmd_matches.containsArg("auto-paginate");

    // Build unified query
    const query = try common.buildSpansQuery(arena_alloc, base_filter, service, operation, resource);

    // Parse page size
    const page_size_str = cmd_matches.getSingleValue("page-size");
    const page_size = if (page_size_str) |ps_str|
        std.fmt.parseInt(usize, ps_str, 10) catch {
            std.debug.print("Error: Invalid page-size value '{s}'. Must be a positive integer.\n", .{ps_str});
            return error.InvalidPageSize;
        }
    else
        common.DATADOG_DEFAULT_PAGE_SIZE;

    if (page_size > common.DATADOG_MAX_PAGE_SIZE) {
        std.debug.print("Error: page-size cannot exceed {d} (API limit)\n", .{common.DATADOG_MAX_PAGE_SIZE});
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
        null
    else
        common.DATADOG_DEFAULT_PAGE_SIZE;

    // Build URL
    const path = "/api/v2/spans/events/search";
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    // Build headers
    const base_count = 5;
    var headers = try arena_alloc.alloc(std.http.Header, base_count);
    headers[0] = .{ .name = "DD-API-KEY", .value = ctx.api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = ctx.app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };
    headers[3] = .{ .name = "Content-Type", .value = "application/json" };
    headers[4] = .{ .name = "Accept-Encoding", .value = "identity" };

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    // Stream spans with pagination
    try streamSpansSearch(
        ctx.allocator,
        url,
        headers,
        ctx.from_timestamp,
        ctx.to_timestamp,
        query,
        @intCast(page_size),
        sort,
        limit,
        auto_paginate,
    );
}

pub fn handleEventsSearch(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Parse command options
    const query = cmd_matches.getSingleValue("FILTER") orelse "*";
    const sort = cmd_matches.getSingleValue("sort") orelse "-timestamp";
    const auto_paginate = cmd_matches.containsArg("auto-paginate");

    // Parse page-size (validate max 1000)
    const page_size_str = cmd_matches.getSingleValue("page-size");
    const page_size = if (page_size_str) |ps_str|
        std.fmt.parseInt(usize, ps_str, 10) catch {
            std.debug.print("Error: Invalid page-size value '{s}'. Must be a positive integer.\n", .{ps_str});
            return error.InvalidPageSize;
        }
    else
        common.DATADOG_DEFAULT_PAGE_SIZE;

    if (page_size > common.DATADOG_MAX_PAGE_SIZE) {
        std.debug.print("Error: page-size cannot exceed {d} (API limit)\n", .{common.DATADOG_MAX_PAGE_SIZE});
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
        null // unlimited
    else
        common.DATADOG_DEFAULT_PAGE_SIZE;

    // Build URL and headers
    const path = "/api/v2/events/search";
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const base_count = 5;
    var headers = try arena_alloc.alloc(std.http.Header, base_count);
    headers[0] = .{ .name = "DD-API-KEY", .value = ctx.api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = ctx.app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };
    headers[3] = .{ .name = "Content-Type", .value = "application/json" };
    headers[4] = .{ .name = "Accept-Encoding", .value = "identity" };

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    // Stream events with pagination
    try common.streamEventsSearch(
        ctx.allocator,
        url,
        headers,
        ctx.from_timestamp,
        ctx.to_timestamp,
        query,
        @intCast(page_size),
        sort,
        limit,
        auto_paginate,
    );
}

pub fn handleMonitorsList(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Optional QUERY positional argument
    const query = cmd_matches.getSingleValue("QUERY");

    // Optional limit argument
    const limit = cmd_matches.getSingleValue("limit");

    const path = "/api/v1/monitor";

    // Build query params (no timestamps - monitors API does not use time range)
    var extra_params_list: std.ArrayList(QueryParam) = .empty;
    defer extra_params_list.deinit(arena_alloc);

    if (query) |q| {
        try extra_params_list.append(arena_alloc, .{ .key = "query", .value = q });
    }
    if (limit) |l| {
        try extra_params_list.append(arena_alloc, .{ .key = "page_size", .value = l });
    }

    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, extra_params_list.items);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try common.writeOutput(response);
}

pub fn handleDowntimesList(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Optional --active flag
    const active = cmd_matches.containsArg("active");

    // Optional limit argument
    const limit = cmd_matches.getSingleValue("limit");

    const path = "/api/v1/downtime";

    // Build query params (no timestamps - downtimes API does not use time range)
    var extra_params_list: std.ArrayList(QueryParam) = .empty;
    defer extra_params_list.deinit(arena_alloc);

    if (active) {
        try extra_params_list.append(arena_alloc, .{ .key = "current_only", .value = "true" });
    }
    if (limit) |l| {
        try extra_params_list.append(arena_alloc, .{ .key = "page_size", .value = l });
    }

    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, extra_params_list.items);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try common.writeOutput(response);
}

pub fn handleContainersList(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Extract container-specific options
    const tags = cmd_matches.getSingleValue("tags");
    const group_by = cmd_matches.getSingleValue("group-by");
    const sort = cmd_matches.getSingleValue("sort");
    const limit = cmd_matches.getSingleValue("limit");
    const cursor = cmd_matches.getSingleValue("cursor");

    const path = "/api/v2/containers";

    // Build query parameters
    var params_list: std.ArrayList(QueryParam) = .empty;
    defer params_list.deinit(arena_alloc);

    if (tags) |t| try params_list.append(arena_alloc, .{ .key = "filter[tags]", .value = t });
    if (group_by) |g| try params_list.append(arena_alloc, .{ .key = "group_by", .value = g });
    if (sort) |s| try params_list.append(arena_alloc, .{ .key = "sort", .value = s });
    if (limit) |l| try params_list.append(arena_alloc, .{ .key = "page[size]", .value = l });
    if (cursor) |c| try params_list.append(arena_alloc, .{ .key = "page[cursor]", .value = c });

    const query_params = try common.buildQueryParams(arena_alloc, ctx, params_list.items);
    defer arena_alloc.free(query_params);

    // Execute request and output response
    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, query_params);
    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    try common.writeOutput(response);
}

pub fn handleProcessesList(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Warn if --from/--to provided (processes API doesn't support time filtering)
    if (ctx.from_explicit or ctx.to_explicit) {
        std.debug.print("Warning: --from and --to flags are ignored for 'list processes' (API does not support time filtering)\n", .{});
    }

    // Extract process-specific options
    const search = cmd_matches.getSingleValue("search");
    const tags = cmd_matches.getSingleValue("tags");
    const limit = cmd_matches.getSingleValue("limit");
    const cursor = cmd_matches.getSingleValue("cursor");

    const path = "/api/v2/processes";

    // Build query parameters (no timestamps - API doesn't support time filtering)
    var params_list: std.ArrayList(QueryParam) = .empty;
    defer params_list.deinit(arena_alloc);

    if (search) |s| try params_list.append(arena_alloc, .{ .key = "search", .value = s });
    if (tags) |t| try params_list.append(arena_alloc, .{ .key = "tags", .value = t });
    if (limit) |l| try params_list.append(arena_alloc, .{ .key = "page[limit]", .value = l });
    if (cursor) |c| try params_list.append(arena_alloc, .{ .key = "page[cursor]", .value = c });

    const query_params = try params_list.toOwnedSlice(arena_alloc);

    // Execute request and output response
    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, query_params);
    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    try common.writeOutput(response);
}

// ============================================================================
// Tests
// ============================================================================

test {
    std.testing.refAllDecls(@This());
}

test "buildLogsSearchRequest - basic request" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const request = buildLogsSearchRequest(
        "2024-01-15T10:00:00Z",
        "2024-01-15T11:00:00Z",
        "*",
        &[_][]const u8{"*"},
        null,
        1000,
        "-timestamp",
    );

    // Serialize and verify
    const body = try std.fmt.allocPrint(arena.allocator(), "{f}", .{std.json.fmt(request, .{ .emit_null_optional_fields = false })});

    // Verify valid JSON structure
    const parsed = try std.json.parseFromSlice(std.json.Value, arena.allocator(), body, .{});
    defer parsed.deinit();

    try std.testing.expect(parsed.value.object.get("filter") != null);
    try std.testing.expect(parsed.value.object.get("page") != null);
    try std.testing.expectEqual(@as(i64, 1000), parsed.value.object.get("page").?.object.get("limit").?.integer);
}

test "buildLogsSearchRequest - with cursor" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const request = buildLogsSearchRequest(
        "2024-01-15T10:00:00Z",
        "2024-01-15T11:00:00Z",
        "status:error",
        &[_][]const u8{"main"},
        "eyJhZnRlciI6InRlc3QiLCJ2YWx1ZXMiOltdfQ==",
        1000,
        "-timestamp",
    );

    // Serialize and verify
    const body = try std.fmt.allocPrint(arena.allocator(), "{f}", .{std.json.fmt(request, .{ .emit_null_optional_fields = false })});

    // Verify cursor included
    const parsed = try std.json.parseFromSlice(std.json.Value, arena.allocator(), body, .{});
    defer parsed.deinit();

    const page_obj = parsed.value.object.get("page").?.object;
    try std.testing.expect(page_obj.get("cursor") != null);
    try std.testing.expectEqualStrings("eyJhZnRlciI6InRlc3QiLCJ2YWx1ZXMiOltdfQ==", page_obj.get("cursor").?.string);
}

test "buildLogsSearchRequest - optional time range" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const request = buildLogsSearchRequest(
        null,
        null,
        "*",
        &[_][]const u8{"*"},
        null,
        500,
        null,
    );

    // Serialize and verify
    const body = try std.fmt.allocPrint(arena.allocator(), "{f}", .{std.json.fmt(request, .{ .emit_null_optional_fields = false })});

    // Verify structure (should not have from/to if not provided)
    const parsed = try std.json.parseFromSlice(std.json.Value, arena.allocator(), body, .{});
    defer parsed.deinit();

    try std.testing.expect(parsed.value.object.get("filter") != null);
    const filter_obj = parsed.value.object.get("filter").?.object;
    try std.testing.expect(filter_obj.get("from") == null);
    try std.testing.expect(filter_obj.get("to") == null);
}

test "buildLogsSearchRequest - multiple indexes" {
    var arena = std.heap.ArenaAllocator.init(std.testing.allocator);
    defer arena.deinit();

    const request = buildLogsSearchRequest(
        null,
        null,
        "service:web",
        &[_][]const u8{ "main", "staging", "prod" },
        null,
        100,
        "-timestamp",
    );

    // Serialize and verify
    const body = try std.fmt.allocPrint(arena.allocator(), "{f}", .{std.json.fmt(request, .{ .emit_null_optional_fields = false })});

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
