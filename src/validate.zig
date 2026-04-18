const std = @import("std");
const common = @import("common.zig");

const CustomHeader = common.CustomHeader;

// ============================================================================
// Validate Command Handler
// ============================================================================

pub fn handleValidateCommand(
    ctx: *const common.Context,
    cmd_matches: *const @import("yazap").ArgMatches,
) !void {
    _ = cmd_matches;

    var arena = std.heap.ArenaAllocator.init(ctx.allocator);
    defer arena.deinit();
    const arena_alloc = arena.allocator();

    const path = "/api/v1/validate";
    const url = try common.buildRawUrl(arena_alloc, ctx.dd_domain, path, null);

    const headers = try common.buildHeaders(arena_alloc, ctx, &[_]CustomHeader{});

    if (ctx.verbose) std.debug.print("{s}\n", .{url});
    const response = try common.executeRequest(ctx.io, arena_alloc, .GET, url, headers, null);

    // Output
    try common.writeOutput(ctx.io, response);
}

// ============================================================================
// Tests
// ============================================================================

