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

/// Returns the path to the per-domain client credentials file:
/// `{HOME}/.config/dd-cli/client_{domain}.json`. Caller must free.
fn getClientCredentialsPath(allocator: std.mem.Allocator, domain: []const u8) ![]const u8 {
    const home = std.posix.getenv("HOME") orelse return error.MissingHomeEnv;
    return std.fmt.allocPrint(allocator, "{s}/.config/dd-cli/client_{s}.json", .{ home, domain });
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
            "{{\"access_token\":{f},\"expires_at\":{d},\"refresh_token\":{f}}}",
            .{ std.json.fmt(access_token, .{}), expires_at, std.json.fmt(rt, .{}) },
        );
    } else {
        try writer.print(
            "{{\"access_token\":{f},\"expires_at\":{d}}}",
            .{ std.json.fmt(access_token, .{}), expires_at },
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
// Client credentials persistence (DCR)
//
// {"client_id":"...","client_secret":"..."}
//
// `client_secret` is omitted when null (public clients).
// ============================================================================

/// Loaded client credentials returned by `loadClientCredentials`.
/// The caller owns all string fields and must free them.
const ClientCredentials = struct {
    client_id: []u8,
    client_secret: ?[]u8,
};

/// Persist DCR client credentials to `~/.config/dd-cli/client_{domain}.json`.
/// Creates config dir if needed. Sets file permissions to 0o600.
pub fn saveClientCredentials(
    allocator: std.mem.Allocator,
    domain: []const u8,
    client_id: []const u8,
    client_secret: ?[]const u8,
) !void {
    const config_dir = try getConfigDir(allocator);
    defer allocator.free(config_dir);

    const creds_path = try getClientCredentialsPath(allocator, domain);
    defer allocator.free(creds_path);

    try std.fs.cwd().makePath(config_dir);

    var json_buf: std.ArrayList(u8) = .empty;
    defer json_buf.deinit(allocator);

    const writer = json_buf.writer(allocator);

    if (client_secret) |cs| {
        try writer.print(
            "{{\"client_id\":{f},\"client_secret\":{f}}}",
            .{ std.json.fmt(client_id, .{}), std.json.fmt(cs, .{}) },
        );
    } else {
        try writer.print("{{\"client_id\":{f}}}", .{std.json.fmt(client_id, .{})});
    }

    const file = try std.fs.cwd().createFile(creds_path, .{ .truncate = true });
    defer file.close();

    try file.writeAll(json_buf.items);
    try file.chmod(0o600);
}

/// Load DCR client credentials from `~/.config/dd-cli/client_{domain}.json`.
///
/// Returns null if the file does not exist or the JSON is malformed.
/// On success the caller owns all returned strings and must free them.
pub fn loadClientCredentials(
    allocator: std.mem.Allocator,
    domain: []const u8,
) !?ClientCredentials {
    const creds_path = try getClientCredentialsPath(allocator, domain);
    defer allocator.free(creds_path);

    const content = std.fs.cwd().readFileAlloc(allocator, creds_path, 65536) catch |err| switch (err) {
        error.FileNotFound => return null,
        else => return err,
    };
    defer allocator.free(content);

    const parsed = std.json.parseFromSlice(std.json.Value, allocator, content, .{}) catch return null;
    defer parsed.deinit();

    const root = parsed.value;
    if (root != .object) return null;

    const client_id_val = root.object.get("client_id") orelse return null;
    if (client_id_val != .string) return null;
    const client_id = allocator.dupe(u8, client_id_val.string) catch return null;

    const client_secret: ?[]u8 = if (root.object.get("client_secret")) |v|
        if (v == .string) blk: {
            const s = allocator.dupe(u8, v.string) catch {
                allocator.free(client_id);
                return null;
            };
            break :blk s;
        } else null
    else
        null;

    return .{ .client_id = client_id, .client_secret = client_secret };
}

// ============================================================================
// Token loading and refresh
// ============================================================================

/// Build an oauth2.Config for Datadog.
///
/// When `client_secret` is null, uses `.none` auth (public PKCE client).
/// When `client_secret` is non-null, sets `.client_secret_post` and stores
/// the secret in `config.options.client_secret`. The caller must ensure the
/// secret slice outlives the config.
///
/// `redirect_uri` is optional; pass null when not needed (e.g., token refresh).
fn buildDatadogConfig(
    dd_domain: []const u8,
    client_id: []const u8,
    redirect_uri: ?[]const u8,
    client_secret: ?[]const u8,
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
        "https://api.{s}/oauth2/v1/token",
        .{dd_domain},
    );
    errdefer allocator.free(token_url);

    var config = oauth2.Config{
        .auth_url = auth_url,
        .token_url = token_url,
        .options = .{
            .client_id = client_id,
            .redirect_uri = redirect_uri,
        },
        .client_auth_method = .none,
    };

    if (client_secret) |cs| {
        config.options.client_secret = cs;
        config.client_auth_method = .client_secret_post;
    }

    return .{ .config = config, .auth_url = auth_url, .token_url = token_url };
}

/// Register a new OAuth2 client via RFC 7591 Dynamic Client Registration.
///
/// Posts to `https://api.{domain}/api/v2/oauth2/register`. Caller owns the
/// returned ClientRegistrationResponse and must call `response.deinit(allocator)`.
fn registerNewClient(
    allocator: std.mem.Allocator,
    http_client: *std.http.Client,
    domain: []const u8,
    redirect_uri: []const u8,
) !oauth2.ClientRegistrationResponse {
    const reg_url = try std.fmt.allocPrint(
        allocator,
        "https://api.{s}/api/v2/oauth2/register",
        .{domain},
    );
    defer allocator.free(reg_url);

    const request = oauth2.ClientRegistrationRequest{
        .client_name = "dd-cli",
        .redirect_uris = &.{redirect_uri},
        .grant_types = &.{ "authorization_code", "refresh_token" },
    };

    return oauth2.registerClient(allocator, http_client, reg_url, request, false);
}

/// Attempt to refresh a stored token.
///
/// Resolves client credentials by checking the stored DCR file first, then
/// falling back to the `DD_CLIENT_ID` environment variable (with no secret).
/// Calls the Datadog token endpoint, persists the new token, and returns the
/// new access token string (owned by caller).
fn refreshStoredToken(
    allocator: std.mem.Allocator,
    dd_domain: []const u8,
    stored_refresh_token: []const u8,
) ![]const u8 {
    // Prefer stored DCR credentials; fall back to env var.
    var loaded_creds: ?ClientCredentials = null;
    defer if (loaded_creds) |creds| {
        allocator.free(creds.client_id);
        if (creds.client_secret) |cs| allocator.free(cs);
    };

    const client_id: []const u8 = blk: {
        if (try loadClientCredentials(allocator, dd_domain)) |creds| {
            loaded_creds = creds;
            break :blk creds.client_id;
        }
        break :blk std.posix.getenv("DD_CLIENT_ID") orelse return error.MissingClientId;
    };

    const client_secret: ?[]const u8 = if (loaded_creds) |creds| creds.client_secret else null;

    const built = try buildDatadogConfig(dd_domain, client_id, null, client_secret, allocator);
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
/// Client ID resolution order:
///  1. `--client-id` argument (skips DCR)
///  2. Stored DCR credentials file (`~/.config/dd-cli/client_{domain}.json`)
///  3. Dynamic Client Registration against `https://app.{domain}/oauth2/v1/register`
///
/// After resolving credentials, performs the PKCE authorization code flow,
/// exchanges the code for a token, and saves it.
pub fn handleLoginCommand(
    allocator: std.mem.Allocator,
    dd_domain: []const u8,
    client_id_arg: ?[]const u8,
) !void {
    // Start local callback server first so we have the redirect_uri for DCR.
    var callback_server = try oauth2.CallbackServer.init(allocator);
    defer callback_server.deinit();

    const redirect_uri = try callback_server.getRedirectUri(allocator);
    defer allocator.free(redirect_uri);

    // Resolve client_id and client_secret.
    //
    // When DCR is used, these slices are owned by us and must be freed after
    // buildDatadogConfig returns (the config only borrows the slices).
    var dcr_client_id: ?[]u8 = null;
    var dcr_client_secret: ?[]u8 = null;
    defer if (dcr_client_id) |id| allocator.free(id);
    defer if (dcr_client_secret) |cs| allocator.free(cs);

    const client_id: []const u8 = blk: {
        if (client_id_arg) |id| {
            // Explicit override — skip DCR entirely.
            break :blk id;
        }

        // Try stored DCR credentials.
        if (try loadClientCredentials(allocator, dd_domain)) |creds| {
            dcr_client_id = creds.client_id;
            dcr_client_secret = creds.client_secret;
            break :blk creds.client_id;
        }

        // No stored credentials — register a new client.
        std.debug.print("Registering new OAuth2 client...\n", .{});

        var reg_http_client = std.http.Client{ .allocator = allocator };
        defer reg_http_client.deinit();

        const response = try registerNewClient(allocator, &reg_http_client, dd_domain, redirect_uri);
        // Deinit is handled below after we've extracted and duped what we need.

        // Dupe the fields we need before freeing the response. response.client_id
        // and response.client_secret are owned by the response struct.
        const new_id = try allocator.dupe(u8, response.client_id);
        errdefer allocator.free(new_id);

        const new_secret: ?[]u8 = if (response.client_secret) |cs|
            try allocator.dupe(u8, cs)
        else
            null;
        errdefer if (new_secret) |cs| allocator.free(cs);

        response.deinit(allocator);

        try saveClientCredentials(allocator, dd_domain, new_id, new_secret);
        std.debug.print("Client registered and saved.\n", .{});

        dcr_client_id = new_id;
        dcr_client_secret = new_secret;
        break :blk new_id;
    };

    const client_secret: ?[]const u8 = if (client_id_arg != null)
        null // explicit --client-id override is always a public client
    else
        dcr_client_secret;

    // Generate PKCE material.
    const verifier = try oauth2.generateVerifier(allocator);
    defer allocator.free(verifier);

    const challenge = try oauth2.generateChallenge(allocator, verifier);
    defer allocator.free(challenge);

    const state = try oauth2.generateState(allocator);
    defer allocator.free(state);

    // Build the Datadog oauth2.Config (we own auth_url and token_url).
    const built = try buildDatadogConfig(dd_domain, client_id, redirect_uri, client_secret, allocator);
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
    const open_cmd = switch (@import("builtin").os.tag) {
        .macos => "open",
        else => "xdg-open",
    };
    var child = std.process.Child.init(&.{ open_cmd, auth_url }, allocator);
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
