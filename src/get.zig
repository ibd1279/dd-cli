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

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
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

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
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

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handleIncidentGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const incident_id = cmd_matches.getSingleValue("INCIDENT_ID") orelse {
        std.debug.print("Error: INCIDENT_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get incident <INCIDENT_ID>\n", .{});
        return error.MissingIncidentId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v2/incidents/{s}", .{incident_id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handleNotebookGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const notebook_id = cmd_matches.getSingleValue("NOTEBOOK_ID") orelse {
        std.debug.print("Error: NOTEBOOK_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get notebook <NOTEBOOK_ID>\n", .{});
        return error.MissingNotebookId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v1/notebooks/{s}", .{notebook_id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handleErrorGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const issue_id = cmd_matches.getSingleValue("ISSUE_ID") orelse {
        std.debug.print("Error: ISSUE_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get error <ISSUE_ID>\n", .{});
        return error.MissingIssueId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v2/error-tracking/issues/{s}", .{issue_id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handleDeviceGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const device_id = cmd_matches.getSingleValue("DEVICE_ID") orelse {
        std.debug.print("Error: DEVICE_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get device <DEVICE_ID>\n", .{});
        return error.MissingDeviceId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v2/ndm/devices/{s}", .{device_id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handleCaseGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const case_id = cmd_matches.getSingleValue("CASE_ID") orelse {
        std.debug.print("Error: CASE_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get case <CASE_ID>\n", .{});
        return error.MissingCaseId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v2/cases/{s}", .{case_id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handleDashboardGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const id = cmd_matches.getSingleValue("DASHBOARD_ID") orelse {
        std.debug.print("Error: DASHBOARD_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get dashboard <DASHBOARD_ID>\n", .{});
        return error.MissingDashboardId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v1/dashboard/{s}", .{id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handleSyntheticGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const id = cmd_matches.getSingleValue("PUBLIC_ID") orelse {
        std.debug.print("Error: PUBLIC_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get synthetic <PUBLIC_ID>\n", .{});
        return error.MissingPublicId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v1/synthetics/tests/{s}", .{id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handleSignalGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const id = cmd_matches.getSingleValue("SIGNAL_ID") orelse {
        std.debug.print("Error: SIGNAL_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get signal <SIGNAL_ID>\n", .{});
        return error.MissingSignalId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v2/security_monitoring/signals/{s}", .{id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handleFindingGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const id = cmd_matches.getSingleValue("FINDING_ID") orelse {
        std.debug.print("Error: FINDING_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get finding <FINDING_ID>\n", .{});
        return error.MissingFindingId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v2/security/findings/{s}", .{id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handlePipelineEventGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const id = cmd_matches.getSingleValue("EVENT_ID") orelse {
        std.debug.print("Error: EVENT_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get pipeline-event <EVENT_ID>\n", .{});
        return error.MissingEventId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v2/ci/pipelines/events/{s}", .{id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);
    try common.writeOutput(response);
}

pub fn handleTestEventGet(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const id = cmd_matches.getSingleValue("EVENT_ID") orelse {
        std.debug.print("Error: EVENT_ID argument is required\n", .{});
        std.debug.print("\nUsage: dd-cli get test-event <EVENT_ID>\n", .{});
        return error.MissingEventId;
    };

    const path = try std.fmt.allocPrint(arena_alloc, "/api/v2/ci/tests/events/{s}", .{id});
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

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
