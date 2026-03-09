const std = @import("std");
const yazap = @import("yazap");
const common = @import("common.zig");

const CustomHeader = common.CustomHeader;

// ============================================================================
// Raw Command Handler
// ============================================================================

pub fn handleRawCommand(
    ctx: *const common.Context,
    cmd_matches: *const yazap.ArgMatches,
) !void {
    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    // Parse arguments
    const path = cmd_matches.getSingleValue("path") orelse {
        std.debug.print("Error: --path is required for raw command\n", .{});
        return error.MissingPath;
    };

    const method_str = cmd_matches.getSingleValue("method") orelse "GET";
    const method = common.parseHttpMethod(method_str) catch |err| {
        std.debug.print("Error: Invalid HTTP method '{s}'. Supported: GET, POST, PUT, DELETE, PATCH\n", .{method_str});
        return err;
    };

    const query_string = cmd_matches.getSingleValue("query");
    const body = cmd_matches.getSingleValue("data");

    // Build URL (raw - no encoding)
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, query_string);

    // Parse custom headers
    var custom_headers: std.ArrayList(CustomHeader) = .empty;
    if (cmd_matches.getMultiValues("header")) |header_strs| {
        for (header_strs) |h_str| {
            const h = common.parseHeader(h_str) catch |err| {
                std.debug.print("Error: Invalid header format '{s}'. Expected 'Name:Value'\n", .{h_str});
                return err;
            };
            try custom_headers.append(arena_alloc, h);
        }
    }

    // Build header list
    const headers = try common.buildHeaders(arena_alloc, ctx, custom_headers.items);

    // Execute request
    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(arena_alloc, method, url, headers, body);

    // Output
    try common.writeOutput(response);
}

// ============================================================================
// Tests
// ============================================================================

test {
    std.testing.refAllDecls(@This());
}
