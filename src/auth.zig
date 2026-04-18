const std = @import("std");

fn getHomeDir() error{MissingHomeEnv}![]const u8 {
    return if (std.c.getenv("HOME")) |v| std.mem.span(v) else error.MissingHomeEnv;
}

fn getTokenFilePath(allocator: std.mem.Allocator) ![]const u8 {
    return std.fmt.allocPrint(allocator, "{s}/.config/dd-cli/token.json", .{try getHomeDir()});
}

// ============================================================================
// Stored token format
//
// {"access_token":"...","expires_at":1234567890,"refresh_token":"..."}
//
// `expires_at` is a Unix timestamp (seconds). `refresh_token` may be absent.
// ============================================================================

/// Returns true when the stored token is too close to expiry to use.
pub fn isTokenExpired(expires_at: i64, now: i64) bool {
    const buffer_seconds: i64 = 60;
    return expires_at <= now + buffer_seconds;
}

pub fn loadStoredToken(io: std.Io, allocator: std.mem.Allocator) !?[]const u8 {
    const token_path = try getTokenFilePath(allocator);
    defer allocator.free(token_path);

    const content = std.Io.Dir.cwd().readFileAlloc(io, token_path, allocator, std.Io.Limit.limited(65536)) catch |err| switch (err) {
        error.FileNotFound => return null,
        else => return err,
    };
    defer allocator.free(content);

    const parsed = std.json.parseFromSlice(std.json.Value, allocator, content, .{}) catch return null;
    defer parsed.deinit();

    const root = parsed.value;
    if (root != .object) return null;

    const access_token_val = root.object.get("access_token") orelse return null;
    if (access_token_val != .string) return null;

    const expires_at_val = root.object.get("expires_at") orelse return null;
    const expires_at: i64 = switch (expires_at_val) {
        .integer => |v| v,
        else => return null,
    };

    const now = std.Io.Clock.real.now(io).toSeconds();
    if (!isTokenExpired(expires_at, now)) {
        return try allocator.dupe(u8, access_token_val.string);
    }

    return null;
}

test "isTokenExpired - valid token not expired" {
    try std.testing.expect(!isTokenExpired(1000 + 61, 1000));
}

test "isTokenExpired - token within buffer window is expired" {
    try std.testing.expect(isTokenExpired(1000 + 60, 1000));
}

test "isTokenExpired - already past expiry" {
    try std.testing.expect(isTokenExpired(999, 1000));
}
