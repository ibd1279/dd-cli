const std = @import("std");
const yazap = @import("yazap");
const common = @import("common.zig");

const QueryParam = common.QueryParam;
const CustomHeader = common.CustomHeader;
const NamedQuery = common.NamedQuery;
const NamedCompute = common.NamedCompute;

// ============================================================================
// Compute Specification Type
// ============================================================================

/// Compute specification parsed from user input
const ComputeSpec = struct {
    aggregation: []const u8,
    metric: ?[]const u8,
};

// ============================================================================
// Compute Helpers
// ============================================================================

/// Parse compute string like "count:*", "avg:@duration", "sum:@http.response_time"
fn parseCompute(input: []const u8) !ComputeSpec {
    const colon_idx = std.mem.indexOf(u8, input, ":") orelse return error.InvalidComputeFormat;

    const aggregation = input[0..colon_idx];
    const metric_part = input[colon_idx + 1 ..];

    if (aggregation.len == 0) return error.InvalidComputeFormat;

    // For "count:*", metric is not used
    if (std.mem.eql(u8, aggregation, "count")) {
        return ComputeSpec{
            .aggregation = aggregation,
            .metric = null,
        };
    }

    // For other aggregations, metric is required
    if (metric_part.len == 0) return error.MissingMetric;

    return ComputeSpec{
        .aggregation = aggregation,
        .metric = metric_part,
    };
}

/// Build JSON string for compute array element
fn buildComputeJson(allocator: std.mem.Allocator, compute_str: []const u8) ![]const u8 {
    const spec = try parseCompute(compute_str);

    // Validate aggregation type
    const valid_aggregations = [_][]const u8{
        "count", "avg", "sum", "min", "max", "median", "cardinality",
        "pc75",  "pc90", "pc95", "pc98", "pc99",
    };
    var is_valid = false;
    for (valid_aggregations) |valid| {
        if (std.mem.eql(u8, spec.aggregation, valid)) {
            is_valid = true;
            break;
        }
    }
    if (!is_valid) return error.InvalidAggregationType;

    // Build JSON based on aggregation type
    if (spec.metric) |metric| {
        // For metrics: {"aggregation":"avg","metric":"@duration","type":"total"}
        const escaped_metric = try common.jsonEscape(allocator, metric);
        defer allocator.free(escaped_metric);

        return std.fmt.allocPrint(
            allocator,
            "{{\"aggregation\":\"{s}\",\"metric\":\"{s}\",\"type\":\"total\"}}",
            .{ spec.aggregation, escaped_metric },
        );
    } else {
        // For count: {"aggregation":"count","type":"total"}
        return std.fmt.allocPrint(
            allocator,
            "{{\"aggregation\":\"count\",\"type\":\"total\"}}",
            .{},
        );
    }
}

/// Build JSON array for group-by facets
fn buildGroupByJson(allocator: std.mem.Allocator, facets: []const []const u8, limit: i64) ![]const u8 {
    if (facets.len == 0) {
        return try allocator.dupe(u8, "[]");
    }

    var result: std.ArrayList(u8) = .empty;
    defer result.deinit(allocator);

    try result.append(allocator, '[');

    for (facets, 0..) |facet, i| {
        if (i > 0) {
            try result.append(allocator, ',');
        }

        const escaped_facet = try common.jsonEscape(allocator, facet);
        defer allocator.free(escaped_facet);

        const facet_json = try std.fmt.allocPrint(
            allocator,
            "{{\"facet\":\"{s}\",\"limit\":{d}}}",
            .{ escaped_facet, limit },
        );
        defer allocator.free(facet_json);

        try result.appendSlice(allocator, facet_json);
    }

    try result.append(allocator, ']');

    return result.toOwnedSlice(allocator);
}

// ============================================================================
// Multiple Query/Compute Support - Parsing Functions
// ============================================================================

/// Parse query string with optional name: "name=query" or "query"
fn parseNamedQuery(input: []const u8) !NamedQuery {
    if (input.len == 0) return error.InvalidQueryFormat;

    // Look for first '=' to split name from query
    if (std.mem.indexOf(u8, input, "=")) |eq_idx| {
        // Has explicit name
        const name = input[0..eq_idx];
        const query = input[eq_idx + 1 ..];

        if (name.len == 0) return error.InvalidNameFormat;
        if (query.len == 0) return error.InvalidQueryFormat;

        // Check for multiple equals signs (only one allowed)
        if (std.mem.indexOf(u8, query, "=") != null) {
            return error.InvalidNameFormat;
        }

        return NamedQuery{
            .name = name,
            .query = query,
        };
    } else {
        // No explicit name, will be auto-numbered
        return NamedQuery{
            .name = null,
            .query = input,
        };
    }
}

/// Parse compute string with optional name: "name=aggregation:metric" or "aggregation:metric"
fn parseNamedCompute(input: []const u8) !NamedCompute {
    if (input.len == 0) return error.InvalidComputeFormat;

    // Look for first '=' to split name from compute spec
    if (std.mem.indexOf(u8, input, "=")) |eq_idx| {
        // Has explicit name
        const name = input[0..eq_idx];
        const compute_spec = input[eq_idx + 1 ..];

        if (name.len == 0) return error.InvalidNameFormat;
        if (compute_spec.len == 0) return error.InvalidComputeFormat;

        // Parse the compute spec using existing function
        const spec = try parseCompute(compute_spec);

        return NamedCompute{
            .name = name,
            .aggregation = spec.aggregation,
            .metric = spec.metric,
        };
    } else {
        // No explicit name, will be auto-numbered
        const spec = try parseCompute(input);

        return NamedCompute{
            .name = null,
            .aggregation = spec.aggregation,
            .metric = spec.metric,
        };
    }
}

/// Assign names to queries: use explicit names or auto-number (query1, query2, ...)
fn assignQueryNames(allocator: std.mem.Allocator, queries: []const NamedQuery) ![]const []const u8 {
    var names = try allocator.alloc([]const u8, queries.len);
    var auto_number: usize = 1;

    for (queries, 0..) |query, i| {
        if (query.name) |explicit_name| {
            // Use explicit name
            names[i] = explicit_name;
        } else {
            // Auto-number: query1, query2, ...
            names[i] = try std.fmt.allocPrint(allocator, "query{d}", .{auto_number});
            auto_number += 1;
        }
    }

    return names;
}

/// Assign names to computes: use explicit names or auto-number (compute1, compute2, ...)
fn assignComputeNames(allocator: std.mem.Allocator, computes: []const NamedCompute) ![]const []const u8 {
    var names = try allocator.alloc([]const u8, computes.len);
    var auto_number: usize = 1;

    for (computes, 0..) |compute, i| {
        if (compute.name) |explicit_name| {
            // Use explicit name
            names[i] = explicit_name;
        } else {
            // Auto-number: compute1, compute2, ...
            names[i] = try std.fmt.allocPrint(allocator, "compute{d}", .{auto_number});
            auto_number += 1;
        }
    }

    return names;
}

/// Validate that all query names are unique
fn validateQueryNames(names: []const []const u8) !void {
    for (names, 0..) |name1, i| {
        for (names[i + 1 ..]) |name2| {
            if (std.mem.eql(u8, name1, name2)) {
                return error.DuplicateQueryName;
            }
        }
    }
}

/// Validate that formulas only reference existing query names
/// Note: This is basic validation - extracts identifier-like tokens and checks them
fn validateFormulas(formulas: []const []const u8, query_names: []const []const u8) !void {
    for (formulas) |formula| {
        // Extract potential variable names from formula
        // Look for alphanumeric sequences that start with a letter or underscore
        var i: usize = 0;
        while (i < formula.len) {
            // Skip non-identifier characters
            if (!std.ascii.isAlphabetic(formula[i]) and formula[i] != '_') {
                i += 1;
                continue;
            }

            // Extract identifier
            const start = i;
            while (i < formula.len and (std.ascii.isAlphanumeric(formula[i]) or formula[i] == '_')) {
                i += 1;
            }
            const identifier = formula[start..i];

            // Skip common math/function keywords
            const keywords = [_][]const u8{ "abs", "log", "exp", "sqrt", "sin", "cos", "tan", "min", "max", "sum", "avg" };
            var is_keyword = false;
            for (keywords) |kw| {
                if (std.mem.eql(u8, identifier, kw)) {
                    is_keyword = true;
                    break;
                }
            }
            if (is_keyword) continue;

            // Check if this identifier is a valid query name
            var is_valid = false;
            for (query_names) |name| {
                if (std.mem.eql(u8, identifier, name)) {
                    is_valid = true;
                    break;
                }
            }

            // If it looks like a query reference (starts with "query" or is in query_names) but isn't valid, error
            if (!is_valid and (std.mem.startsWith(u8, identifier, "query") or std.mem.startsWith(u8, identifier, "compute"))) {
                return error.InvalidFormulaReference;
            }
        }
    }
}

// ============================================================================
// Multiple Query/Compute Support - JSON Building Functions
// ============================================================================

/// Build JSON array for metrics queries
fn buildMetricsQueriesJson(
    allocator: std.mem.Allocator,
    queries: []const NamedQuery,
    names: []const []const u8,
) ![]const u8 {
    if (queries.len == 0) return error.NoQueriesProvided;

    var result: std.ArrayList(u8) = .empty;
    defer result.deinit(allocator);

    try result.append(allocator, '[');

    for (queries, 0..) |query, i| {
        if (i > 0) {
            try result.append(allocator, ',');
        }

        const escaped_query = try common.jsonEscape(allocator, query.query);
        defer allocator.free(escaped_query);

        const escaped_name = try common.jsonEscape(allocator, names[i]);
        defer allocator.free(escaped_name);

        const query_json = try std.fmt.allocPrint(
            allocator,
            "{{\"data_source\":\"metrics\",\"query\":\"{s}\",\"name\":\"{s}\"}}",
            .{ escaped_query, escaped_name },
        );
        defer allocator.free(query_json);

        try result.appendSlice(allocator, query_json);
    }

    try result.append(allocator, ']');

    return result.toOwnedSlice(allocator);
}

/// Build JSON array for metrics formulas
/// If formulas is null, creates default formulas (one per query using query name)
fn buildMetricsFormulasJson(
    allocator: std.mem.Allocator,
    formulas: ?[]const []const u8,
    query_names: []const []const u8,
) ![]const u8 {
    var result: std.ArrayList(u8) = .empty;
    defer result.deinit(allocator);

    try result.append(allocator, '[');

    if (formulas) |formula_list| {
        // Use provided formulas
        for (formula_list, 0..) |formula, i| {
            if (i > 0) {
                try result.append(allocator, ',');
            }

            const escaped_formula = try common.jsonEscape(allocator, formula);
            defer allocator.free(escaped_formula);

            const formula_json = try std.fmt.allocPrint(
                allocator,
                "{{\"formula\":\"{s}\"}}",
                .{escaped_formula},
            );
            defer allocator.free(formula_json);

            try result.appendSlice(allocator, formula_json);
        }
    } else {
        // No formulas provided: create default formulas (one per query)
        for (query_names, 0..) |name, i| {
            if (i > 0) {
                try result.append(allocator, ',');
            }

            const escaped_name = try common.jsonEscape(allocator, name);
            defer allocator.free(escaped_name);

            const formula_json = try std.fmt.allocPrint(
                allocator,
                "{{\"formula\":\"{s}\"}}",
                .{escaped_name},
            );
            defer allocator.free(formula_json);

            try result.appendSlice(allocator, formula_json);
        }
    }

    try result.append(allocator, ']');

    return result.toOwnedSlice(allocator);
}

/// Build JSON array for multiple compute operations
fn buildMultipleComputesJson(
    allocator: std.mem.Allocator,
    computes: []const NamedCompute,
) ![]const u8 {
    if (computes.len == 0) return error.NoComputesProvided;

    var result: std.ArrayList(u8) = .empty;
    defer result.deinit(allocator);

    try result.append(allocator, '[');

    for (computes, 0..) |compute, i| {
        if (i > 0) {
            try result.append(allocator, ',');
        }

        // Build JSON based on whether metric exists
        const compute_json = if (compute.metric) |metric| blk: {
            const escaped_metric = try common.jsonEscape(allocator, metric);
            defer allocator.free(escaped_metric);

            break :blk try std.fmt.allocPrint(
                allocator,
                "{{\"aggregation\":\"{s}\",\"metric\":\"{s}\",\"type\":\"total\"}}",
                .{ compute.aggregation, escaped_metric },
            );
        } else blk: {
            // For count (no metric)
            break :blk try std.fmt.allocPrint(
                allocator,
                "{{\"aggregation\":\"count\",\"type\":\"total\"}}",
                .{},
            );
        };
        defer allocator.free(compute_json);

        try result.appendSlice(allocator, compute_json);
    }

    try result.append(allocator, ']');

    return result.toOwnedSlice(allocator);
}

// ============================================================================
// Aggregate Command Handlers
// ============================================================================

/// Handle logs aggregate command
pub fn handleLogsAggregate(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Parse command options
    const filter = cmd_matches.getSingleValue("FILTER") orelse cmd_matches.getSingleValue("query") orelse "*";

    // Collect compute operations (support multiple)
    var computes: std.ArrayList(NamedCompute) = .empty;
    defer computes.deinit(arena_alloc);

    if (cmd_matches.getMultiValues("compute")) |compute_args| {
        for (compute_args) |compute_str| {
            const named_compute = try parseNamedCompute(compute_str);

            // Validate aggregation type
            const valid_aggregations = [_][]const u8{
                "count", "avg", "sum", "min", "max", "median", "cardinality",
                "pc75",  "pc90", "pc95", "pc98", "pc99",
            };
            var is_valid = false;
            for (valid_aggregations) |valid| {
                if (std.mem.eql(u8, named_compute.aggregation, valid)) {
                    is_valid = true;
                    break;
                }
            }
            if (!is_valid) {
                std.debug.print("Error: Invalid aggregation type '{s}'\n", .{named_compute.aggregation});
                return error.InvalidAggregationType;
            }

            try computes.append(arena_alloc, named_compute);
        }
    }

    // Validate: at least one compute required
    if (computes.items.len == 0) {
        std.debug.print("Error: --compute is required for aggregate operations\n", .{});
        std.debug.print("Examples:\n", .{});
        std.debug.print("  dd-cli aggregate logs --compute count:*\n", .{});
        std.debug.print("  dd-cli aggregate logs --compute 'count:*' --compute 'avg:@duration'\n", .{});
        std.debug.print("  dd-cli aggregate logs --compute total='count:*' --compute avg_dur='avg:@duration'\n", .{});
        return error.MissingCompute;
    }

    const indexes_str = cmd_matches.getSingleValue("indexes") orelse "*";
    const limit_str = cmd_matches.getSingleValue("limit") orelse "10";
    const limit = std.fmt.parseInt(i64, limit_str, 10) catch {
        std.debug.print("Error: Invalid limit value '{s}'. Must be a positive integer.\n", .{limit_str});
        return error.InvalidLimit;
    };

    // Parse indexes (comma-separated)
    var indexes: std.ArrayList([]const u8) = .empty;
    var index_iter = std.mem.splitScalar(u8, indexes_str, ',');
    while (index_iter.next()) |index| {
        const trimmed = std.mem.trim(u8, index, " \t");
        if (trimmed.len > 0) {
            try indexes.append(arena_alloc, trimmed);
        }
    }

    // Get group-by facets (optional, repeatable)
    var group_by_facets: std.ArrayList([]const u8) = .empty;
    if (cmd_matches.getMultiValues("group-by")) |facets| {
        for (facets) |facet| {
            try group_by_facets.append(arena_alloc, facet);
        }
    }

    // Build JSON for multiple computes
    const compute_json = try buildMultipleComputesJson(arena_alloc, computes.items);
    defer arena_alloc.free(compute_json);

    const group_by_json = try buildGroupByJson(arena_alloc, group_by_facets.items, limit);
    defer arena_alloc.free(group_by_json);

    // Build indexes JSON array
    var indexes_json: std.ArrayList(u8) = .empty;
    defer indexes_json.deinit(arena_alloc);
    try indexes_json.append(arena_alloc, '[');
    for (indexes.items, 0..) |index, i| {
        if (i > 0) {
            try indexes_json.append(arena_alloc, ',');
        }
        const escaped = try common.jsonEscape(arena_alloc, index);
        defer arena_alloc.free(escaped);
        try indexes_json.writer(arena_alloc).print("\"{s}\"", .{escaped});
    }
    try indexes_json.append(arena_alloc, ']');

    // Build filter JSON
    const escaped_filter = try common.jsonEscape(arena_alloc, filter);
    defer arena_alloc.free(escaped_filter);

    const from_json = if (ctx.from_timestamp) |from| blk: {
        const escaped = try common.jsonEscape(arena_alloc, from);
        defer arena_alloc.free(escaped);
        break :blk try std.fmt.allocPrint(arena_alloc, "\"{s}\"", .{escaped});
    } else try arena_alloc.dupe(u8, "null");

    const to_json = if (ctx.to_timestamp) |to| blk: {
        const escaped = try common.jsonEscape(arena_alloc, to);
        defer arena_alloc.free(escaped);
        break :blk try std.fmt.allocPrint(arena_alloc, "\"{s}\"", .{escaped});
    } else try arena_alloc.dupe(u8, "null");

    // Build complete request body
    const request_body = try std.fmt.allocPrint(
        arena_alloc,
        \\{{
        \\  "compute": {s},
        \\  "filter": {{
        \\    "from": {s},
        \\    "to": {s},
        \\    "query": "{s}",
        \\    "indexes": {s}
        \\  }},
        \\  "group_by": {s}
        \\}}
        ,
        .{
            compute_json,
            from_json,
            to_json,
            escaped_filter,
            indexes_json.items,
            group_by_json,
        },
    );

    // Build URL
    const path = "/api/v2/logs/analytics/aggregate";
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    // Build headers
    const base_count = 5;
    var headers = try arena_alloc.alloc(std.http.Header, base_count);
    headers[0] = .{ .name = "DD-API-KEY", .value = ctx.api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = ctx.app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };
    headers[3] = .{ .name = "Content-Type", .value = "application/json" };
    headers[4] = .{ .name = "Accept-Encoding", .value = "identity" };

    // Execute request
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(ctx.allocator, std.http.Method.POST, url, headers, request_body);
    defer ctx.allocator.free(response);

    // Write output
    try common.writeOutput(response);
}

/// Handle aggregate metrics command - query timeseries data with MQL (V2 API)
pub fn handleMetricsAggregate(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Collect queries from -q/--query options
    var queries: std.ArrayList(NamedQuery) = .empty;
    defer queries.deinit(arena_alloc);

    // Get -q/--query multi-values
    if (cmd_matches.getMultiValues("query")) |query_args| {
        for (query_args) |query_str| {
            const named_query = try parseNamedQuery(query_str);
            try queries.append(arena_alloc, named_query);
        }
    }

    // Validate: at least one query required
    if (queries.items.len == 0) {
        std.debug.print("Error: At least one query is required\n", .{});
        std.debug.print("Examples:\n", .{});
        std.debug.print("  dd-cli --from 1h aggregate metrics -q 'avg:system.cpu.idle{{*}}'\n", .{});
        std.debug.print("  dd-cli --from 1h aggregate metrics -q cpu='avg:system.cpu.idle{{*}}' -q mem='avg:system.mem.used{{*}}'\n", .{});
        return error.MissingQuery;
    }

    // Assign names to queries
    const query_names = try assignQueryNames(arena_alloc, queries.items);

    // Validate no duplicate names
    validateQueryNames(query_names) catch {
        std.debug.print("Error: Duplicate query names detected. Each query must have a unique name.\n", .{});
        return error.DuplicateQueryName;
    };

    // Get optional formulas
    const formulas = cmd_matches.getMultiValues("formula");

    // Validate formulas reference existing query names
    if (formulas) |formula_list| {
        validateFormulas(formula_list, query_names) catch {
            std.debug.print("Error: Formula references unknown query. Available queries: ", .{});
            for (query_names, 0..) |name, i| {
                if (i > 0) std.debug.print(", ", .{});
                std.debug.print("{s}", .{name});
            }
            std.debug.print("\n", .{});
            return error.InvalidFormulaReference;
        };
    }

    const path = "/api/v2/query/timeseries";

    // Convert ISO 8601 timestamps to Unix epoch milliseconds (required by Metrics V2 API)
    const from_unix_ms = if (ctx.from_timestamp) |from_iso|
        try common.parseIso8601ToUnix(from_iso) * 1000
    else
        return error.MissingFromTimestamp;

    const to_unix_ms = if (ctx.to_timestamp) |to_iso|
        try common.parseIso8601ToUnix(to_iso) * 1000
    else
        return error.MissingToTimestamp;

    // Build queries JSON array
    const queries_json = try buildMetricsQueriesJson(arena_alloc, queries.items, query_names);
    defer arena_alloc.free(queries_json);

    // Build formulas JSON array
    const formulas_json = try buildMetricsFormulasJson(arena_alloc, formulas, query_names);
    defer arena_alloc.free(formulas_json);

    // Build V2 API request body with queries and formulas
    const request_body = try std.fmt.allocPrint(
        arena_alloc,
        \\{{
        \\  "data": {{
        \\    "type": "timeseries_request",
        \\    "attributes": {{
        \\      "from": {d},
        \\      "to": {d},
        \\      "queries": {s},
        \\      "formulas": {s}
        \\    }}
        \\  }}
        \\}}
        ,
        .{ from_unix_ms, to_unix_ms, queries_json, formulas_json },
    );

    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    // Build headers (need Content-Type for POST)
    const base_count = 4;
    var headers = try arena_alloc.alloc(std.http.Header, base_count);
    headers[0] = .{ .name = "DD-API-KEY", .value = ctx.api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = ctx.app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };
    headers[3] = .{ .name = "Content-Type", .value = "application/json" };

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .POST, url, headers, request_body);

    // Output
    try common.writeOutput(response);
}

/// Handle aggregate spans command
pub fn handleSpansAggregate(
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

    // Collect compute operations
    var computes: std.ArrayList(NamedCompute) = .empty;
    defer computes.deinit(arena_alloc);

    if (cmd_matches.getMultiValues("compute")) |compute_args| {
        for (compute_args) |compute_str| {
            const named_compute = try parseNamedCompute(compute_str);

            // Validate aggregation type for spans
            const valid_aggregations = [_][]const u8{
                "count", "avg", "sum", "min", "max", "cardinality",
                "pc50",  "pc75", "pc90", "pc95", "pc98", "pc99",
            };
            var is_valid = false;
            for (valid_aggregations) |valid| {
                if (std.mem.eql(u8, named_compute.aggregation, valid)) {
                    is_valid = true;
                    break;
                }
            }
            if (!is_valid) {
                std.debug.print("Error: Invalid aggregation type '{s}'\n", .{named_compute.aggregation});
                std.debug.print("Valid types: count, avg, sum, min, max, pc50, pc75, pc90, pc95, pc98, pc99, cardinality\n", .{});
                return error.InvalidAggregationType;
            }

            try computes.append(arena_alloc, named_compute);
        }
    }

    // Validate: at least one compute required
    if (computes.items.len == 0) {
        std.debug.print("Error: --compute is required for aggregate operations\n", .{});
        std.debug.print("Examples:\n", .{});
        std.debug.print("  dd-cli aggregate spans --compute count:*\n", .{});
        std.debug.print("  dd-cli aggregate spans --compute 'count:*' --compute 'avg:@duration'\n", .{});
        std.debug.print("  dd-cli aggregate spans --compute total='count:*' --compute avg_dur='avg:@duration'\n", .{});
        return error.MissingCompute;
    }

    // Get group-by facets
    const limit_str = cmd_matches.getSingleValue("limit") orelse "10";
    const limit = std.fmt.parseInt(i64, limit_str, 10) catch {
        std.debug.print("Error: Invalid limit value '{s}'. Must be a positive integer.\n", .{limit_str});
        return error.InvalidLimit;
    };

    var group_by_facets: std.ArrayList([]const u8) = .empty;
    if (cmd_matches.getMultiValues("group-by")) |facets| {
        for (facets) |facet| {
            try group_by_facets.append(arena_alloc, facet);
        }
    }

    // Build unified query
    const query = try common.buildSpansQuery(arena_alloc, base_filter, service, operation, null);

    // Build JSON for computes
    const compute_json = try buildMultipleComputesJson(arena_alloc, computes.items);
    defer arena_alloc.free(compute_json);

    const group_by_json = try buildGroupByJson(arena_alloc, group_by_facets.items, limit);
    defer arena_alloc.free(group_by_json);

    // Build filter JSON
    const escaped_filter = try common.jsonEscape(arena_alloc, query);
    defer arena_alloc.free(escaped_filter);

    const from_json = if (ctx.from_timestamp) |from| blk: {
        const escaped = try common.jsonEscape(arena_alloc, from);
        defer arena_alloc.free(escaped);
        break :blk try std.fmt.allocPrint(arena_alloc, "\"{s}\"", .{escaped});
    } else try arena_alloc.dupe(u8, "null");

    const to_json = if (ctx.to_timestamp) |to| blk: {
        const escaped = try common.jsonEscape(arena_alloc, to);
        defer arena_alloc.free(escaped);
        break :blk try std.fmt.allocPrint(arena_alloc, "\"{s}\"", .{escaped});
    } else try arena_alloc.dupe(u8, "null");

    // Build complete request body (with data wrapper AND required type field)
    const request_body = try std.fmt.allocPrint(
        arena_alloc,
        \\{{
        \\  "data": {{
        \\    "type": "aggregate_request",
        \\    "attributes": {{
        \\      "compute": {s},
        \\      "filter": {{
        \\        "from": {s},
        \\        "to": {s},
        \\        "query": "{s}"
        \\      }},
        \\      "group_by": {s}
        \\    }}
        \\  }}
        \\}}
        ,
        .{
            compute_json,
            from_json,
            to_json,
            escaped_filter,
            group_by_json,
        },
    );

    // Build URL
    const path = "/api/v2/spans/analytics/aggregate";
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    // Build headers
    const base_count = 5;
    var headers = try arena_alloc.alloc(std.http.Header, base_count);
    headers[0] = .{ .name = "DD-API-KEY", .value = ctx.api_key };
    headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = ctx.app_key };
    headers[2] = .{ .name = "Accept", .value = "application/json" };
    headers[3] = .{ .name = "Content-Type", .value = "application/json" };
    headers[4] = .{ .name = "Accept-Encoding", .value = "identity" };

    // Execute request
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(ctx.allocator, std.http.Method.POST, url, headers, request_body);
    defer ctx.allocator.free(response);

    // Write output
    try common.writeOutput(response);
}

pub fn handleNetworkConnectionsAggregate(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Extract network-specific options
    const tags = cmd_matches.getSingleValue("tags");
    const group_by = cmd_matches.getSingleValue("group-by");

    const path = "/api/v2/network/connections/aggregate";

    // Build query parameters
    var params_list: std.ArrayList(QueryParam) = .empty;
    defer params_list.deinit(arena_alloc);

    if (tags) |t| try params_list.append(arena_alloc, .{ .key = "filter[tags]", .value = t });
    if (group_by) |g| try params_list.append(arena_alloc, .{ .key = "group_by", .value = g });

    const query_params = try common.buildQueryParamsWithUnixTimestamps(arena_alloc, ctx, params_list.items);
    defer arena_alloc.free(query_params);

    // Execute request and output response
    const url = try common.buildUrl(arena_alloc, ctx.dd_domain, path, query_params);
    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, .GET, url, headers, null);

    try common.writeOutput(response);
}

pub fn handleNetworkDnsAggregate(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Extract DNS-specific options
    const tags = cmd_matches.getSingleValue("tags");
    const group_by = cmd_matches.getSingleValue("group-by");

    const path = "/api/v2/network/dns/aggregate";

    // Build query parameters
    var params_list: std.ArrayList(QueryParam) = .empty;
    defer params_list.deinit(arena_alloc);

    if (tags) |t| try params_list.append(arena_alloc, .{ .key = "filter[tags]", .value = t });
    if (group_by) |g| try params_list.append(arena_alloc, .{ .key = "group_by", .value = g });

    const query_params = try common.buildQueryParamsWithUnixTimestamps(arena_alloc, ctx, params_list.items);
    defer arena_alloc.free(query_params);

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

test "parseCompute - count aggregation" {
    const result = try parseCompute("count:*");
    try std.testing.expectEqualStrings("count", result.aggregation);
    try std.testing.expect(result.metric == null);
}

test "parseCompute - metric aggregations" {
    // avg with metric
    const avg_result = try parseCompute("avg:@duration");
    try std.testing.expectEqualStrings("avg", avg_result.aggregation);
    try std.testing.expect(avg_result.metric != null);
    try std.testing.expectEqualStrings("@duration", avg_result.metric.?);

    // sum with metric
    const sum_result = try parseCompute("sum:@http.response_time");
    try std.testing.expectEqualStrings("sum", sum_result.aggregation);
    try std.testing.expect(sum_result.metric != null);
    try std.testing.expectEqualStrings("@http.response_time", sum_result.metric.?);

    // max with metric
    const max_result = try parseCompute("max:@memory.usage");
    try std.testing.expectEqualStrings("max", max_result.aggregation);
    try std.testing.expect(max_result.metric != null);
    try std.testing.expectEqualStrings("@memory.usage", max_result.metric.?);
}

test "parseCompute - error cases" {
    // Missing colon
    try std.testing.expectError(error.InvalidComputeFormat, parseCompute("count"));

    // Empty aggregation
    try std.testing.expectError(error.InvalidComputeFormat, parseCompute(":metric"));

    // Missing metric for non-count aggregation
    try std.testing.expectError(error.MissingMetric, parseCompute("avg:"));
}

test "buildComputeJson - count aggregation" {
    const result = try buildComputeJson(std.testing.allocator, "count:*");
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("{\"aggregation\":\"count\",\"type\":\"total\"}", result);
}

test "buildComputeJson - metric aggregations" {
    // avg
    {
        const result = try buildComputeJson(std.testing.allocator, "avg:@duration");
        defer std.testing.allocator.free(result);
        try std.testing.expectEqualStrings("{\"aggregation\":\"avg\",\"metric\":\"@duration\",\"type\":\"total\"}", result);
    }

    // sum
    {
        const result = try buildComputeJson(std.testing.allocator, "sum:@http.response_time");
        defer std.testing.allocator.free(result);
        try std.testing.expectEqualStrings("{\"aggregation\":\"sum\",\"metric\":\"@http.response_time\",\"type\":\"total\"}", result);
    }

    // min
    {
        const result = try buildComputeJson(std.testing.allocator, "min:@latency");
        defer std.testing.allocator.free(result);
        try std.testing.expectEqualStrings("{\"aggregation\":\"min\",\"metric\":\"@latency\",\"type\":\"total\"}", result);
    }

    // max
    {
        const result = try buildComputeJson(std.testing.allocator, "max:@cpu.usage");
        defer std.testing.allocator.free(result);
        try std.testing.expectEqualStrings("{\"aggregation\":\"max\",\"metric\":\"@cpu.usage\",\"type\":\"total\"}", result);
    }
}

test "buildComputeJson - percentile aggregations" {
    // pc75
    {
        const result = try buildComputeJson(std.testing.allocator, "pc75:@duration");
        defer std.testing.allocator.free(result);
        try std.testing.expectEqualStrings("{\"aggregation\":\"pc75\",\"metric\":\"@duration\",\"type\":\"total\"}", result);
    }

    // pc90
    {
        const result = try buildComputeJson(std.testing.allocator, "pc90:@duration");
        defer std.testing.allocator.free(result);
        try std.testing.expectEqualStrings("{\"aggregation\":\"pc90\",\"metric\":\"@duration\",\"type\":\"total\"}", result);
    }

    // pc95
    {
        const result = try buildComputeJson(std.testing.allocator, "pc95:@http.response_time");
        defer std.testing.allocator.free(result);
        try std.testing.expectEqualStrings("{\"aggregation\":\"pc95\",\"metric\":\"@http.response_time\",\"type\":\"total\"}", result);
    }

    // pc98
    {
        const result = try buildComputeJson(std.testing.allocator, "pc98:@latency");
        defer std.testing.allocator.free(result);
        try std.testing.expectEqualStrings("{\"aggregation\":\"pc98\",\"metric\":\"@latency\",\"type\":\"total\"}", result);
    }

    // pc99
    {
        const result = try buildComputeJson(std.testing.allocator, "pc99:@duration");
        defer std.testing.allocator.free(result);
        try std.testing.expectEqualStrings("{\"aggregation\":\"pc99\",\"metric\":\"@duration\",\"type\":\"total\"}", result);
    }
}

test "buildComputeJson - invalid aggregation type" {
    try std.testing.expectError(error.InvalidAggregationType, buildComputeJson(std.testing.allocator, "invalid:@metric"));
    try std.testing.expectError(error.InvalidAggregationType, buildComputeJson(std.testing.allocator, "percentile:@duration"));
}

test "buildGroupByJson - empty facets" {
    const facets: []const []const u8 = &.{};
    const result = try buildGroupByJson(std.testing.allocator, facets, 10);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[]", result);
}

test "buildGroupByJson - single facet" {
    const facets: []const []const u8 = &.{"host"};
    const result = try buildGroupByJson(std.testing.allocator, facets, 10);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[{\"facet\":\"host\",\"limit\":10}]", result);
}

test "buildGroupByJson - multiple facets" {
    const facets: []const []const u8 = &.{ "host", "service", "status" };
    const result = try buildGroupByJson(std.testing.allocator, facets, 20);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[{\"facet\":\"host\",\"limit\":20},{\"facet\":\"service\",\"limit\":20},{\"facet\":\"status\",\"limit\":20}]", result);
}

test "buildGroupByJson - facets with special characters" {
    const facets: []const []const u8 = &.{"@http.status_code"};
    const result = try buildGroupByJson(std.testing.allocator, facets, 5);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[{\"facet\":\"@http.status_code\",\"limit\":5}]", result);
}

test "parseNamedQuery - with explicit name" {
    const result = try parseNamedQuery("cpu=avg:system.cpu.idle{*}");
    try std.testing.expectEqualStrings("cpu", result.name.?);
    try std.testing.expectEqualStrings("avg:system.cpu.idle{*}", result.query);
}

test "parseNamedQuery - without name (auto-number)" {
    const result = try parseNamedQuery("avg:system.cpu.idle{*}");
    try std.testing.expect(result.name == null);
    try std.testing.expectEqualStrings("avg:system.cpu.idle{*}", result.query);
}

test "parseNamedQuery - invalid format (multiple equals)" {
    try std.testing.expectError(error.InvalidNameFormat, parseNamedQuery("a=b=c"));
}

test "parseNamedQuery - empty name" {
    try std.testing.expectError(error.InvalidNameFormat, parseNamedQuery("=avg:cpu{*}"));
}

test "parseNamedQuery - empty query" {
    try std.testing.expectError(error.InvalidQueryFormat, parseNamedQuery("cpu="));
}

test "parseNamedCompute - with explicit name" {
    const result = try parseNamedCompute("total=count:*");
    try std.testing.expectEqualStrings("total", result.name.?);
    try std.testing.expectEqualStrings("count", result.aggregation);
    try std.testing.expect(result.metric == null);
}

test "parseNamedCompute - without name" {
    const result = try parseNamedCompute("avg:@duration");
    try std.testing.expect(result.name == null);
    try std.testing.expectEqualStrings("avg", result.aggregation);
    try std.testing.expectEqualStrings("@duration", result.metric.?);
}

test "parseNamedCompute - invalid compute format" {
    try std.testing.expectError(error.InvalidComputeFormat, parseNamedCompute("invalid"));
}

test "assignQueryNames - all explicit" {
    const queries = [_]NamedQuery{
        .{ .name = "cpu", .query = "avg:cpu{*}" },
        .{ .name = "mem", .query = "avg:mem{*}" },
    };
    const names = try assignQueryNames(std.testing.allocator, &queries);
    defer std.testing.allocator.free(names);

    try std.testing.expectEqualStrings("cpu", names[0]);
    try std.testing.expectEqualStrings("mem", names[1]);
}

test "assignQueryNames - all auto-numbered" {
    const queries = [_]NamedQuery{
        .{ .name = null, .query = "avg:cpu{*}" },
        .{ .name = null, .query = "avg:mem{*}" },
    };
    const names = try assignQueryNames(std.testing.allocator, &queries);
    defer {
        for (names) |name| std.testing.allocator.free(name);
        std.testing.allocator.free(names);
    }

    try std.testing.expectEqualStrings("query1", names[0]);
    try std.testing.expectEqualStrings("query2", names[1]);
}

test "assignQueryNames - mixed explicit and auto" {
    const queries = [_]NamedQuery{
        .{ .name = "cpu", .query = "avg:cpu{*}" },
        .{ .name = null, .query = "avg:mem{*}" },
        .{ .name = null, .query = "avg:disk{*}" },
    };
    const names = try assignQueryNames(std.testing.allocator, &queries);
    defer {
        for (names[1..]) |name| std.testing.allocator.free(name);
        std.testing.allocator.free(names);
    }

    try std.testing.expectEqualStrings("cpu", names[0]);
    try std.testing.expectEqualStrings("query1", names[1]);
    try std.testing.expectEqualStrings("query2", names[2]);
}

test "assignComputeNames - all explicit" {
    const computes = [_]NamedCompute{
        .{ .name = "total", .aggregation = "count", .metric = null },
        .{ .name = "avg_dur", .aggregation = "avg", .metric = "@duration" },
    };
    const names = try assignComputeNames(std.testing.allocator, &computes);
    defer std.testing.allocator.free(names);

    try std.testing.expectEqualStrings("total", names[0]);
    try std.testing.expectEqualStrings("avg_dur", names[1]);
}

test "assignComputeNames - all auto-numbered" {
    const computes = [_]NamedCompute{
        .{ .name = null, .aggregation = "count", .metric = null },
        .{ .name = null, .aggregation = "avg", .metric = "@duration" },
    };
    const names = try assignComputeNames(std.testing.allocator, &computes);
    defer {
        for (names) |name| std.testing.allocator.free(name);
        std.testing.allocator.free(names);
    }

    try std.testing.expectEqualStrings("compute1", names[0]);
    try std.testing.expectEqualStrings("compute2", names[1]);
}

test "validateQueryNames - no duplicates" {
    const names = [_][]const u8{ "query1", "query2", "query3" };
    try validateQueryNames(&names);
}

test "validateQueryNames - duplicate detection" {
    const names = [_][]const u8{ "query1", "query2", "query1" };
    try std.testing.expectError(error.DuplicateQueryName, validateQueryNames(&names));
}

test "validateFormulas - valid references" {
    const formulas = [_][]const u8{ "query1 + query2", "query1 / query2" };
    const query_names = [_][]const u8{ "query1", "query2" };
    try validateFormulas(&formulas, &query_names);
}

test "validateFormulas - simple reference" {
    const formulas = [_][]const u8{"query1"};
    const query_names = [_][]const u8{"query1"};
    try validateFormulas(&formulas, &query_names);
}

test "validateFormulas - invalid reference" {
    const formulas = [_][]const u8{"query1 + query3"};
    const query_names = [_][]const u8{ "query1", "query2" };
    try std.testing.expectError(error.InvalidFormulaReference, validateFormulas(&formulas, &query_names));
}

test "buildMetricsQueriesJson - single query" {
    const queries = [_]NamedQuery{
        .{ .name = null, .query = "avg:system.cpu.idle{*}" },
    };
    const names = [_][]const u8{"query1"};
    const result = try buildMetricsQueriesJson(std.testing.allocator, &queries, &names);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[{\"data_source\":\"metrics\",\"query\":\"avg:system.cpu.idle{*}\",\"name\":\"query1\"}]", result);
}

test "buildMetricsQueriesJson - multiple queries" {
    const queries = [_]NamedQuery{
        .{ .name = "cpu", .query = "avg:system.cpu.idle{*}" },
        .{ .name = "mem", .query = "avg:system.mem.used{*}" },
    };
    const names = [_][]const u8{ "cpu", "mem" };
    const result = try buildMetricsQueriesJson(std.testing.allocator, &queries, &names);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[{\"data_source\":\"metrics\",\"query\":\"avg:system.cpu.idle{*}\",\"name\":\"cpu\"},{\"data_source\":\"metrics\",\"query\":\"avg:system.mem.used{*}\",\"name\":\"mem\"}]", result);
}

test "buildMetricsQueriesJson - query with special characters" {
    const queries = [_]NamedQuery{
        .{ .name = null, .query = "avg:system.\"cpu.idle\"{host:prod}" },
    };
    const names = [_][]const u8{"query1"};
    const result = try buildMetricsQueriesJson(std.testing.allocator, &queries, &names);
    defer std.testing.allocator.free(result);

    // Should escape the quotes in the query
    try std.testing.expect(std.mem.indexOf(u8, result, "\\\"cpu.idle\\\"") != null);
}

test "buildMetricsFormulasJson - with formulas" {
    const formulas = [_][]const u8{ "query1 + query2", "query1 / query2" };
    const query_names = [_][]const u8{ "query1", "query2" };
    const result = try buildMetricsFormulasJson(std.testing.allocator, &formulas, &query_names);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[{\"formula\":\"query1 + query2\"},{\"formula\":\"query1 / query2\"}]", result);
}

test "buildMetricsFormulasJson - without formulas (auto)" {
    const query_names = [_][]const u8{ "cpu", "mem" };
    const result = try buildMetricsFormulasJson(std.testing.allocator, null, &query_names);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[{\"formula\":\"cpu\"},{\"formula\":\"mem\"}]", result);
}

test "buildMultipleComputesJson - single compute" {
    const computes = [_]NamedCompute{
        .{ .name = null, .aggregation = "count", .metric = null },
    };
    const result = try buildMultipleComputesJson(std.testing.allocator, &computes);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[{\"aggregation\":\"count\",\"type\":\"total\"}]", result);
}

test "buildMultipleComputesJson - multiple computes" {
    const computes = [_]NamedCompute{
        .{ .name = null, .aggregation = "count", .metric = null },
        .{ .name = null, .aggregation = "avg", .metric = "@duration" },
        .{ .name = null, .aggregation = "pc99", .metric = "@response_time" },
    };
    const result = try buildMultipleComputesJson(std.testing.allocator, &computes);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[{\"aggregation\":\"count\",\"type\":\"total\"},{\"aggregation\":\"avg\",\"metric\":\"@duration\",\"type\":\"total\"},{\"aggregation\":\"pc99\",\"metric\":\"@response_time\",\"type\":\"total\"}]", result);
}

test "buildMultipleComputesJson - mixed with and without metrics" {
    const computes = [_]NamedCompute{
        .{ .name = "total", .aggregation = "count", .metric = null },
        .{ .name = "avg_dur", .aggregation = "avg", .metric = "@duration" },
    };
    const result = try buildMultipleComputesJson(std.testing.allocator, &computes);
    defer std.testing.allocator.free(result);

    try std.testing.expectEqualStrings("[{\"aggregation\":\"count\",\"type\":\"total\"},{\"aggregation\":\"avg\",\"metric\":\"@duration\",\"type\":\"total\"}]", result);
}
