const std = @import("std");
const yazap = @import("yazap");
const common = @import("common.zig");

const QueryParam = common.QueryParam;
const CustomHeader = common.CustomHeader;

// ============================================================================
// Get Command Handlers
// ============================================================================

/// Handle get log by ID command (not supported by API)
pub fn handleLogGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    _ = ctx;

    const log_id = cmd_matches.getSingleValue("LOG_ID") orelse {
        std.debug.print("Error: LOG_ID is required\n", .{});
        return error.MissingLogId;
    };

    std.debug.print("Error: Get single log by ID is not supported by the Datadog API.\n", .{});
    std.debug.print("Use 'list logs' with a specific query to find logs:\n", .{});
    std.debug.print("  dd-cli list logs '@_id:\"{s}\"'\n", .{log_id});

    return error.UnsupportedOperation;
}

pub fn handleHostGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Get positional HOST_NAME argument
    const host_name = cmd_matches.getSingleValue("HOST_NAME") orelse {
        std.debug.print("Error: HOST_NAME argument is required\n", .{});
        return error.MissingHostName;
    };

    const path = "/api/v1/hosts";

    // Build query params with filter parameter (API doesn't support /hosts/{name}, only list with filter)
    const query_params = [_]QueryParam{
        .{ .key = "filter", .value = host_name },
    };

    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, &query_params);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    // Parse response and extract matching host
    const parsed = try std.json.parseFromSlice(std.json.Value, arena_alloc, response, .{});
    if (parsed.value.object.get("host_list")) |host_list_value| {
        const host_list = host_list_value.array.items;
        if (host_list.len == 0) {
            std.debug.print("Error: Host not found: {s}\n", .{host_name});
            return error.HostNotFound;
        }
        // Return first matching host as JSON
        const json_output = try common.valueToJson(arena_alloc, host_list[0]);
        try common.writeOutput(json_output);
    } else {
        try common.writeOutput(response);
    }
}

/// Handle get metrics command - get metadata for a specific metric
pub fn handleMetricsGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Get positional METRIC_NAME argument
    const metric_name = cmd_matches.getSingleValue("METRIC_NAME") orelse {
        std.debug.print("Error: METRIC_NAME argument is required\n", .{});
        std.debug.print("Example: dd-cli get metrics system.cpu.idle\n", .{});
        return error.MissingMetricName;
    };

    // Build path with metric name embedded
    const path = try std.fmt.allocPrint(arena_alloc, "/api/v1/metrics/{s}", .{metric_name});

    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try common.writeOutput(response);
}

/// Handle get api command - get OpenAPI spec for a specific API
pub fn handleApiGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Get positional API_ID argument
    const api_id = cmd_matches.getSingleValue("API_ID") orelse {
        std.debug.print("Error: API_ID argument is required\n", .{});
        std.debug.print("Example: dd-cli get api <api-id>\n", .{});
        std.debug.print("Tip: Use 'dd-cli list apis' to see available API IDs\n", .{});
        return error.MissingApiId;
    };

    // Build path with API ID embedded
    const path = try std.fmt.allocPrint(arena_alloc, "/api/v2/apicatalog/api/{s}/openapi", .{api_id});

    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    // Output
    try common.writeOutput(response);
}

pub fn handleEventGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Get positional EVENT_ID argument
    const event_id = cmd_matches.getSingleValue("EVENT_ID") orelse {
        std.debug.print("Error: EVENT_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get event <EVENT_ID>\n", .{});
        return error.MissingEventId;
    };

    // Build path with event_id embedded
    const path = try std.fmt.allocPrint(arena_alloc, "/api/v2/events/{s}", .{event_id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const base_count = 3;
    var headers = try arena_alloc.alloc(std.http.Header, base_count);
    headers[0] = .{ .name = "DD-API-KEY", .value = ctx.api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = ctx.app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };

    // Execute request with custom error handling
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    var client: std.http.Client = .{ .allocator = ctx.allocator };
    defer client.deinit();

    var body_writer = std.Io.Writer.Allocating.init(ctx.allocator);
    defer body_writer.deinit();

    const result = client.fetch(.{
        .location = .{ .url = url },
        .method = .GET,
        .extra_headers = headers,
        .response_writer = &body_writer.writer,
    }) catch |err| {
        std.debug.print("Error: Network request failed: {}\n", .{err});
        return err;
    };

    // Check response status with custom error message
    if (result.status != .ok) {
        if (result.status == .not_found) {
            std.debug.print("Error: Event not found with ID: {s}\n", .{event_id});
        } else {
            std.debug.print("Error: HTTP request failed with status: {}\n", .{result.status});
            const response_body = body_writer.written();
            if (response_body.len > 0 and (response_body[0] == '{' or response_body[0] == '[')) {
                std.debug.print("Response: {s}\n", .{response_body});
            }
        }
        return error.RequestFailed;
    }

    const response = try ctx.allocator.dupe(u8, body_writer.written());
    defer ctx.allocator.free(response);
    try common.writeOutput(response);
}

pub fn handleMonitorGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Get positional MONITOR_ID argument
    const monitor_id = cmd_matches.getSingleValue("MONITOR_ID") orelse {
        std.debug.print("Error: MONITOR_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get monitor <MONITOR_ID>\n", .{});
        return error.MissingMonitorId;
    };

    // Build path with monitor_id embedded
    const path = try std.fmt.allocPrint(arena_alloc, "/api/v1/monitor/{s}", .{monitor_id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const base_count = 3;
    var headers = try arena_alloc.alloc(std.http.Header, base_count);
    headers[0] = .{ .name = "DD-API-KEY", .value = ctx.api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = ctx.app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };

    // Execute request with custom error handling
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    var client: std.http.Client = .{ .allocator = ctx.allocator };
    defer client.deinit();

    var body_writer = std.Io.Writer.Allocating.init(ctx.allocator);
    defer body_writer.deinit();

    const result = client.fetch(.{
        .location = .{ .url = url },
        .method = .GET,
        .extra_headers = headers,
        .response_writer = &body_writer.writer,
    }) catch |err| {
        std.debug.print("Error: Network request failed: {}\n", .{err});
        return err;
    };

    // Check response status with custom error message
    if (result.status != .ok) {
        if (result.status == .not_found) {
            std.debug.print("Error: Monitor {s} not found (404)\n", .{monitor_id});
        } else {
            std.debug.print("Error: HTTP request failed with status: {}\n", .{result.status});
            const response_body = body_writer.written();
            if (response_body.len > 0 and (response_body[0] == '{' or response_body[0] == '[')) {
                std.debug.print("Response: {s}\n", .{response_body});
            }
        }
        return error.RequestFailed;
    }

    const response = try ctx.allocator.dupe(u8, body_writer.written());
    defer ctx.allocator.free(response);
    try common.writeOutput(response);
}

pub fn handleDowntimeGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Get positional DOWNTIME_ID argument
    const downtime_id = cmd_matches.getSingleValue("DOWNTIME_ID") orelse {
        std.debug.print("Error: DOWNTIME_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get downtime <DOWNTIME_ID>\n", .{});
        return error.MissingDowntimeId;
    };

    // Build path with downtime_id embedded
    const path = try std.fmt.allocPrint(arena_alloc, "/api/v1/downtime/{s}", .{downtime_id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const base_count = 3;
    var headers = try arena_alloc.alloc(std.http.Header, base_count);
    headers[0] = .{ .name = "DD-API-KEY", .value = ctx.api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = ctx.app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };

    // Execute request with custom error handling
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    var client: std.http.Client = .{ .allocator = ctx.allocator };
    defer client.deinit();

    var body_writer = std.Io.Writer.Allocating.init(ctx.allocator);
    defer body_writer.deinit();

    const result = client.fetch(.{
        .location = .{ .url = url },
        .method = .GET,
        .extra_headers = headers,
        .response_writer = &body_writer.writer,
    }) catch |err| {
        std.debug.print("Error: Network request failed: {}\n", .{err});
        return err;
    };

    // Check response status with custom error message
    if (result.status != .ok) {
        if (result.status == .not_found) {
            std.debug.print("Error: Downtime {s} not found (404)\n", .{downtime_id});
        } else {
            std.debug.print("Error: HTTP request failed with status: {}\n", .{result.status});
            const response_body = body_writer.written();
            if (response_body.len > 0 and (response_body[0] == '{' or response_body[0] == '[')) {
                std.debug.print("Response: {s}\n", .{response_body});
            }
        }
        return error.RequestFailed;
    }

    const response = try ctx.allocator.dupe(u8, body_writer.written());
    defer ctx.allocator.free(response);
    try common.writeOutput(response);
}

// ============================================================================
// Tests
// ============================================================================

test {
    std.testing.refAllDecls(@This());
}
