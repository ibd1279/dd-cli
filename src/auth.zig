const std = @import("std");
const oauth2 = @import("oauth2");

// ============================================================================
// Token file paths
// ============================================================================

/// Returns the path to the dd-cli config directory: `{HOME}/.config/dd-cli`.
/// Caller must free the returned slice.
fn getConfigDir(allocator: std.mem.Allocator) ![]const u8 {
    const home = std.posix.getenv("HOME") orelse return error.MissingHomeEnv;
    return std.fmt.allocPrint(allocator, "{s}/.config/dd-cli", .{home});
}

/// Returns the path to the token file: `{HOME}/.config/dd-cli/token.json`.
/// Caller must free the returned slice.
pub fn getTokenFilePath(allocator: std.mem.Allocator) ![]const u8 {
    const home = std.posix.getenv("HOME") orelse return error.MissingHomeEnv;
    return std.fmt.allocPrint(allocator, "{s}/.config/dd-cli/token.json", .{home});
}

// ============================================================================
// Stored token format
//
// {"access_token":"...","expires_at":1234567890,"refresh_token":"..."}
//
// `expires_at` is a Unix timestamp (seconds). `refresh_token` may be absent.
// ============================================================================

/// Persist a token to disk at the standard token path.
/// Creates parent directories if needed. Sets file permissions to 0o600.
pub fn saveToken(
    allocator: std.mem.Allocator,
    access_token: []const u8,
    refresh_token: ?[]const u8,
    expires_at: i64,
) !void {
    const config_dir = try getConfigDir(allocator);
    defer allocator.free(config_dir);

    const token_path = try getTokenFilePath(allocator);
    defer allocator.free(token_path);

    // Ensure the config directory exists.
    try std.fs.cwd().makePath(config_dir);

    // Build the JSON payload.
    var json_buf: std.ArrayList(u8) = .empty;
    defer json_buf.deinit(allocator);

    const writer = json_buf.writer(allocator);

    if (refresh_token) |rt| {
        try writer.print(
            "{{\"access_token\":\"{s}\",\"expires_at\":{d},\"refresh_token\":\"{s}\"}}",
            .{ access_token, expires_at, rt },
        );
    } else {
        try writer.print(
            "{{\"access_token\":\"{s}\",\"expires_at\":{d}}}",
            .{ access_token, expires_at },
        );
    }

    // Write to file then restrict permissions.
    const file = try std.fs.cwd().createFile(token_path, .{ .truncate = true });
    defer file.close();

    try file.writeAll(json_buf.items);
    try file.chmod(0o600);
}

/// Delete the stored token file. Silently succeeds if the file does not exist.
pub fn deleteToken(allocator: std.mem.Allocator) !void {
    const token_path = try getTokenFilePath(allocator);
    defer allocator.free(token_path);

    std.fs.cwd().deleteFile(token_path) catch |err| switch (err) {
        error.FileNotFound => {},
        else => return err,
    };
}

// ============================================================================
// Token loading and refresh
// ============================================================================

/// Build an oauth2.Config for Datadog using only `client_id` (PKCE public client).
/// `redirect_uri` is optional; pass null when not needed (e.g., token refresh).
fn buildDatadogConfig(
    dd_domain: []const u8,
    client_id: []const u8,
    redirect_uri: ?[]const u8,
    allocator: std.mem.Allocator,
) !struct {
    config: oauth2.Config,
    auth_url: []u8,
    token_url: []u8,
} {
    const auth_url = try std.fmt.allocPrint(
        allocator,
        "https://app.{s}/oauth2/v1/authorize",
        .{dd_domain},
    );
    errdefer allocator.free(auth_url);

    const token_url = try std.fmt.allocPrint(
        allocator,
        "https://app.{s}/oauth2/v1/token",
        .{dd_domain},
    );
    errdefer allocator.free(token_url);

    const config = oauth2.Config{
        .auth_url = auth_url,
        .token_url = token_url,
        .options = .{
            .client_id = client_id,
            .redirect_uri = redirect_uri,
        },
        .client_auth_method = .none,
    };

    return .{ .config = config, .auth_url = auth_url, .token_url = token_url };
}

/// Attempt to refresh a stored token.  Reads `DD_CLIENT_ID` from the
/// environment, calls the Datadog token endpoint, persists the new token, and
/// returns the new access token string (owned by caller).
fn refreshStoredToken(
    allocator: std.mem.Allocator,
    dd_domain: []const u8,
    stored_refresh_token: []const u8,
) ![]const u8 {
    const client_id = std.posix.getenv("DD_CLIENT_ID") orelse {
        return error.MissingClientId;
    };

    const built = try buildDatadogConfig(dd_domain, client_id, null, allocator);
    defer allocator.free(built.auth_url);
    defer allocator.free(built.token_url);

    var http_client = std.http.Client{ .allocator = allocator };
    defer http_client.deinit();

    const token = try oauth2.refreshToken(
        allocator,
        &http_client,
        built.config,
        stored_refresh_token,
    );
    defer token.deinit(allocator);

    const expires_at = token.issued_at + token.expires_in;

    try saveToken(allocator, token.access_token, token.refresh_token, expires_at);

    // Return a copy of the access token so the caller owns it independently of
    // the token struct that was just freed above.
    return allocator.dupe(u8, token.access_token);
}

/// Load a valid access token from disk.
///
/// - Returns the access token string (caller must free) when a non-expired
///   token is found.
/// - Attempts a refresh when the token is expired but a refresh token is
///   present; returns the refreshed access token on success.
/// - Returns `null` when no stored token exists or when refresh fails.
pub fn loadStoredToken(
    allocator: std.mem.Allocator,
    dd_domain: []const u8,
) !?[]const u8 {
    const token_path = try getTokenFilePath(allocator);
    defer allocator.free(token_path);

    const content = std.fs.cwd().readFileAlloc(allocator, token_path, 65536) catch |err| switch (err) {
        error.FileNotFound => return null,
        else => return err,
    };
    defer allocator.free(content);

    // Parse JSON.
    const parsed = std.json.parseFromSlice(std.json.Value, allocator, content, .{}) catch return null;
    defer parsed.deinit();

    const root = parsed.value;
    if (root != .object) return null;

    const access_token_val = root.object.get("access_token") orelse return null;
    if (access_token_val != .string) return null;
    const access_token_str = access_token_val.string;

    const expires_at_val = root.object.get("expires_at") orelse return null;
    const expires_at: i64 = switch (expires_at_val) {
        .integer => |v| v,
        else => return null,
    };

    const now = std.time.timestamp();
    const buffer_seconds: i64 = 60;

    if (expires_at > now + buffer_seconds) {
        // Token is still valid.
        const duped: []const u8 = try allocator.dupe(u8, access_token_str);
        return duped;
    }

    // Token has expired; try to refresh.
    const refresh_token_val = root.object.get("refresh_token") orelse return null;
    if (refresh_token_val != .string) return null;
    const refresh_token_str = refresh_token_val.string;

    return refreshStoredToken(allocator, dd_domain, refresh_token_str) catch null;
}

// ============================================================================
// Auth commands
// ============================================================================

const dd_scopes = &[_][]const u8{
    "dashboards_read",
    "events_read",
    "logs_read_data",
    "metrics_read",
    "monitors_read",
    "apm_read",
    "infrastructure_read",
};

/// Perform an interactive OAuth2 PKCE login against Datadog.
///
/// Resolves `client_id` from `client_id_arg` first, then the `DD_CLIENT_ID`
/// environment variable.  Prints the authorization URL, attempts to open the
/// system browser, waits for the local callback, exchanges the code, and saves
/// the resulting token.
pub fn handleLoginCommand(
    allocator: std.mem.Allocator,
    dd_domain: []const u8,
    client_id_arg: ?[]const u8,
) !void {
    // Resolve client_id.
    const client_id: []const u8 = client_id_arg orelse
        std.posix.getenv("DD_CLIENT_ID") orelse {
        std.debug.print(
            "Error: client_id is required. Pass --client-id or set the DD_CLIENT_ID environment variable.\n",
            .{},
        );
        return error.MissingClientId;
    };

    // Start local callback server.
    var callback_server = try oauth2.CallbackServer.init(allocator);
    defer callback_server.deinit();

    const redirect_uri = try callback_server.getRedirectUri(allocator);
    defer allocator.free(redirect_uri);

    // Generate PKCE material.
    const verifier = try oauth2.generateVerifier(allocator);
    defer allocator.free(verifier);

    const challenge = try oauth2.generateChallenge(allocator, verifier);
    defer allocator.free(challenge);

    const state = try oauth2.generateState(allocator);
    defer allocator.free(state);

    // Build the Datadog oauth2.Config (we own auth_url and token_url).
    const built = try buildDatadogConfig(dd_domain, client_id, redirect_uri, allocator);
    defer allocator.free(built.auth_url);
    defer allocator.free(built.token_url);

    var config = built.config;
    config.options.scopes = dd_scopes;

    // Build the authorization URL.
    const auth_url = try oauth2.buildAuthUrl(allocator, config, state, challenge);
    defer allocator.free(auth_url);

    std.debug.print("Opening browser for authorization...\n", .{});
    std.debug.print("If the browser does not open, visit:\n  {s}\n\n", .{auth_url});

    // Try to open the browser (best-effort; ignore errors).
    var child = std.process.Child.init(&.{ "open", auth_url }, allocator);
    _ = child.spawnAndWait() catch {};

    std.debug.print("Waiting for authorization callback...\n", .{});

    // Block until the browser completes the redirect.
    const callback_result = try callback_server.waitForCallback();
    defer callback_result.deinit(allocator);

    switch (callback_result) {
        .oauth_error => |e| {
            if (e.error_description) |desc| {
                std.debug.print("Authorization error: {s} - {s}\n", .{ e.error_code, desc });
            } else {
                std.debug.print("Authorization error: {s}\n", .{e.error_code});
            }
            return error.AuthorizationFailed;
        },
        .success => |s| {
            // Verify the CSRF state matches.
            if (!std.mem.eql(u8, s.state, state)) {
                std.debug.print("Error: state mismatch — possible CSRF attack.\n", .{});
                return error.StateMismatch;
            }

            // Exchange the authorization code for a token.
            var http_client = std.http.Client{ .allocator = allocator };
            defer http_client.deinit();

            const token = try oauth2.exchangeCodeForToken(
                allocator,
                &http_client,
                config,
                s.code,
                verifier,
            );
            defer token.deinit(allocator);

            const expires_at = token.issued_at + token.expires_in;
            try saveToken(allocator, token.access_token, token.refresh_token, expires_at);
        },
    }

    std.debug.print("Successfully logged in. Token saved.\n", .{});
}

/// Remove the stored token from disk.
pub fn handleLogoutCommand(allocator: std.mem.Allocator) !void {
    try deleteToken(allocator);
    std.debug.print("Logged out. Token removed.\n", .{});
}
