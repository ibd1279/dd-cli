const std = @import("std");
const api_v1 = @import("api/datadog_v1.zig");
const api_v2 = @import("api/datadog_v2.zig");
const auth = @import("auth.zig");

// ============================================================================
// Types
// ============================================================================

pub const AuthType = enum {
    api_key,
    bearer,
};

pub const Context = struct {
    allocator: std.mem.Allocator,
    dd_domain: []const u8,
    dd_domain_owned: ?[]const u8,
    auth_type: AuthType,
    /// Set when auth_type == .api_key
    api_key: []const u8,
    app_key: []const u8,
    /// Set when auth_type == .bearer
    access_token: ?[]const u8,
    from_timestamp: ?[]const u8,
    to_timestamp: ?[]const u8,
    verbose: bool,
    from_explicit: bool,
    to_explicit: bool,

    pub fn deinit(self: *Context) void {
        if (self.dd_domain_owned) |domain| self.allocator.free(domain);
        if (self.from_timestamp) |ts| self.allocator.free(ts);
        if (self.to_timestamp) |ts| self.allocator.free(ts);
        if (self.api_key.len > 0) self.allocator.free(self.api_key);
        if (self.app_key.len > 0) self.allocator.free(self.app_key);
        if (self.access_token) |t| self.allocator.free(t);
    }
};

pub const QueryParam = struct {
    key: []const u8,
    value: []const u8,
};

pub const CustomHeader = struct {
    name: []const u8,
    value: []const u8,
};

// Re-export API types for convenience
pub const LogsListRequest = api_v2.LogsListRequest;
pub const LogsListResponse = api_v2.LogsListResponse;
pub const LogsQueryFilter = api_v2.LogsQueryFilter;
pub const LogsListRequestPage = api_v2.LogsListRequestPage;
pub const HostListResponse = api_v1.HostListResponse;
pub const EventsListRequest = api_v2.EventsListRequest;
pub const EventsListResponse = api_v2.EventsListResponse;
pub const EventsQueryFilter = api_v2.EventsQueryFilter;
pub const EventsRequestPage = api_v2.EventsRequestPage;

// ============================================================================
// Query/Compute Types for Multiple Operations
// ============================================================================

/// Query with optional explicit name
pub const NamedQuery = struct {
    name: ?[]const u8, // null means auto-number
    query: []const u8,
};

/// Compute operation with optional explicit name
pub const NamedCompute = struct {
    name: ?[]const u8, // null means auto-number
    aggregation: []const u8,
    metric: ?[]const u8,
};

// ============================================================================
// Time Parsing Helpers
// ============================================================================

pub const TimeUnit = enum {
    minutes,
    hours,
    days,
    weeks,
    months,
};

pub const RelativeTime = struct {
    value: i64,
    unit: TimeUnit,
};

/// Parse a relative time string like "1d", "2hours", "3w" into value and unit
pub fn parseRelativeTime(input: []const u8) !RelativeTime {
    if (input.len == 0) return error.InvalidRelativeTime;

    // Find where the number ends and unit begins
    var num_end: usize = 0;
    while (num_end < input.len and std.ascii.isDigit(input[num_end])) {
        num_end += 1;
    }

    if (num_end == 0) return error.InvalidRelativeTime;

    const value = try std.fmt.parseInt(i64, input[0..num_end], 10);
    const unit_str = input[num_end..];

    if (unit_str.len == 0) return error.InvalidRelativeTime;

    // Parse unit (case-insensitive)
    const unit = blk: {
        // Minutes: m, min, mins, minute, minutes
        if (std.ascii.eqlIgnoreCase(unit_str, "m") or
            std.ascii.eqlIgnoreCase(unit_str, "min") or
            std.ascii.eqlIgnoreCase(unit_str, "mins") or
            std.ascii.eqlIgnoreCase(unit_str, "minute") or
            std.ascii.eqlIgnoreCase(unit_str, "minutes"))
        {
            break :blk TimeUnit.minutes;
        }
        // Hours: h, hr, hrs, hour, hours
        if (std.ascii.eqlIgnoreCase(unit_str, "h") or
            std.ascii.eqlIgnoreCase(unit_str, "hr") or
            std.ascii.eqlIgnoreCase(unit_str, "hrs") or
            std.ascii.eqlIgnoreCase(unit_str, "hour") or
            std.ascii.eqlIgnoreCase(unit_str, "hours"))
        {
            break :blk TimeUnit.hours;
        }
        // Days: d, day, days
        if (std.ascii.eqlIgnoreCase(unit_str, "d") or
            std.ascii.eqlIgnoreCase(unit_str, "day") or
            std.ascii.eqlIgnoreCase(unit_str, "days"))
        {
            break :blk TimeUnit.days;
        }
        // Weeks: w, week, weeks
        if (std.ascii.eqlIgnoreCase(unit_str, "w") or
            std.ascii.eqlIgnoreCase(unit_str, "week") or
            std.ascii.eqlIgnoreCase(unit_str, "weeks"))
        {
            break :blk TimeUnit.weeks;
        }
        // Months: mo, mos, mon, mons, month, months
        if (std.ascii.eqlIgnoreCase(unit_str, "mo") or
            std.ascii.eqlIgnoreCase(unit_str, "mos") or
            std.ascii.eqlIgnoreCase(unit_str, "mon") or
            std.ascii.eqlIgnoreCase(unit_str, "mons") or
            std.ascii.eqlIgnoreCase(unit_str, "month") or
            std.ascii.eqlIgnoreCase(unit_str, "months"))
        {
            break :blk TimeUnit.months;
        }
        return error.InvalidTimeUnit;
    };

    return RelativeTime{ .value = value, .unit = unit };
}

/// Convert relative time to seconds offset
pub fn relativeTimeToSeconds(rel_time: RelativeTime) i64 {
    return switch (rel_time.unit) {
        .minutes => rel_time.value * 60,
        .hours => rel_time.value * 3600,
        .days => rel_time.value * 86400,
        .weeks => rel_time.value * 604800,
        .months => rel_time.value * 2592000, // 30 days
    };
}

/// Format Unix timestamp to ISO 8601 string (UTC)
pub fn formatTimestamp(allocator: std.mem.Allocator, timestamp: i64) ![]const u8 {
    const epoch_seconds = std.time.epoch.EpochSeconds{ .secs = @intCast(timestamp) };
    const day_seconds = epoch_seconds.getDaySeconds();
    const epoch_day = epoch_seconds.getEpochDay();
    const year_day = epoch_day.calculateYearDay();
    const month_day = year_day.calculateMonthDay();

    return std.fmt.allocPrint(
        allocator,
        "{d:0>4}-{d:0>2}-{d:0>2}T{d:0>2}:{d:0>2}:{d:0>2}Z",
        .{
            year_day.year,
            month_day.month.numeric(),
            month_day.day_index + 1,
            day_seconds.getHoursIntoDay(),
            day_seconds.getMinutesIntoHour(),
            day_seconds.getSecondsIntoMinute(),
        },
    );
}

/// Parse time argument into ISO 8601 string
/// Accepts: "now" (current time), relative times ("1d", "2h"), or ISO 8601 timestamps
/// Returns owned string that caller must free
pub fn parseTimeArg(allocator: std.mem.Allocator, arg: ?[]const u8, current_time: i64, is_from: bool) !?[]const u8 {
    const input = arg orelse {
        // If no arg provided and this is 'to', default to current time
        if (!is_from) {
            return try formatTimestamp(allocator, current_time);
        }
        // If no arg provided and this is 'from', default to 15 minutes ago
        const default_offset = 15 * 60; // 15 minutes in seconds
        return try formatTimestamp(allocator, current_time - default_offset);
    };

    // Check for "now" keyword (case-insensitive)
    if (std.ascii.eqlIgnoreCase(input, "now")) {
        return try formatTimestamp(allocator, current_time);
    }

    // Check if it looks like a relative time (starts with digit)
    if (input.len > 0 and std.ascii.isDigit(input[0])) {
        const rel_time = parseRelativeTime(input) catch {
            // Not a relative time, treat as absolute timestamp
            return try allocator.dupe(u8, input);
        };

        // Convert to absolute timestamp (subtract from current time for 'from')
        const offset = relativeTimeToSeconds(rel_time);
        const timestamp = current_time - offset;
        return try formatTimestamp(allocator, timestamp);
    }

    // Not a relative time, treat as absolute timestamp
    return try allocator.dupe(u8, input);
}

// ============================================================================
// Configuration Helpers
// ============================================================================

/// Initialize context from environment and CLI args
pub fn initConfig(
    allocator: std.mem.Allocator,
    domain_arg: ?[]const u8,
    from_arg: ?[]const u8,
    to_arg: ?[]const u8,
    verbose: bool,
) !Context {
    var ctx: Context = undefined;
    ctx.allocator = allocator;
    ctx.dd_domain_owned = null;
    ctx.verbose = verbose;
    ctx.from_explicit = from_arg != null;
    ctx.to_explicit = to_arg != null;

    // Get current time for relative time calculations
    const current_time = std.time.timestamp();

    // Parse time arguments (handles both relative and absolute)
    const from_timestamp = try parseTimeArg(allocator, from_arg, current_time, true);
    errdefer if (from_timestamp) |ts| allocator.free(ts);

    const to_timestamp = try parseTimeArg(allocator, to_arg, current_time, false);
    errdefer if (to_timestamp) |ts| allocator.free(ts);

    ctx.from_timestamp = from_timestamp;
    ctx.to_timestamp = to_timestamp;

    // Priority: CLI arg > DD_SITE env > "datadoghq.com"
    ctx.dd_domain = blk: {
        if (domain_arg) |domain| {
            break :blk domain;
        }
        if (std.process.getEnvVarOwned(allocator, "DD_SITE")) |site| {
            ctx.dd_domain_owned = site;
            break :blk site;
        } else |_| {
            break :blk "datadoghq.com";
        }
    };
    errdefer if (ctx.dd_domain_owned) |d| allocator.free(d);

    // Validate domain
    if (!isValidDatadogDomain(ctx.dd_domain)) {
        if (ctx.dd_domain_owned) |domain| allocator.free(domain);
        if (ctx.from_timestamp) |ts| allocator.free(ts);
        if (ctx.to_timestamp) |ts| allocator.free(ts);
        std.debug.print("Error: Invalid Datadog domain: {s}\n", .{ctx.dd_domain});
        std.debug.print("Valid domains should end with 'datadoghq.com', 'datadoghq.eu', or similar\n", .{});
        return error.InvalidDomain;
    }

    // Auth priority: DD_ACCESS_TOKEN env > stored token file > DD_API_KEY + DD_APPLICATION_KEY

    // 1. Check DD_ACCESS_TOKEN env var
    if (std.process.getEnvVarOwned(allocator, "DD_ACCESS_TOKEN")) |token| {
        ctx.auth_type = .bearer;
        ctx.access_token = token;
        ctx.api_key = "";
        ctx.app_key = "";
        return ctx;
    } else |_| {}

    // 2. Try stored OAuth2 token from disk (with auto-refresh)
    if (try auth.loadStoredToken(allocator, ctx.dd_domain)) |token| {
        ctx.auth_type = .bearer;
        ctx.access_token = token;
        ctx.api_key = "";
        ctx.app_key = "";
        return ctx;
    }

    // 3. Fall back to API key + application key
    ctx.api_key = std.process.getEnvVarOwned(allocator, "DD_API_KEY") catch {
        std.debug.print("Error: No authentication available.\n", .{});
        std.debug.print("Options:\n", .{});
        std.debug.print("  - Run 'dd-cli auth login' to authenticate with OAuth2\n", .{});
        std.debug.print("  - Set DD_ACCESS_TOKEN environment variable\n", .{});
        std.debug.print("  - Set DD_API_KEY and DD_APPLICATION_KEY environment variables\n", .{});
        return error.EnvironmentVariableNotFound;
    };

    ctx.app_key = std.process.getEnvVarOwned(allocator, "DD_APPLICATION_KEY") catch |err| {
        allocator.free(ctx.api_key);
        std.debug.print("Error: DD_APPLICATION_KEY environment variable not set\n", .{});
        std.debug.print("Required when using API key authentication\n", .{});
        return err;
    };

    ctx.auth_type = .api_key;
    ctx.access_token = null;

    return ctx;
}

pub fn isValidDatadogDomain(domain: []const u8) bool {
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
pub fn urlEncode(allocator: std.mem.Allocator, input: []const u8) ![]const u8 {
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
pub fn buildUrl(
    allocator: std.mem.Allocator,
    domain: []const u8,
    path: []const u8,
    query_params: ?[]const QueryParam,
) ![]const u8 {
    // Add api. prefix if not present
    const api_domain_owned = !std.mem.startsWith(u8, domain, "api.");
    const api_domain = if (!api_domain_owned)
        domain
    else
        try std.fmt.allocPrint(allocator, "api.{s}", .{domain});
    defer if (api_domain_owned) allocator.free(api_domain);

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
pub fn buildRawUrl(
    allocator: std.mem.Allocator,
    domain: []const u8,
    path: []const u8,
    query_string: ?[]const u8,
) ![]const u8 {
    // Add api. prefix if not present
    const api_domain_owned = !std.mem.startsWith(u8, domain, "api.");
    const api_domain = if (!api_domain_owned)
        domain
    else
        try std.fmt.allocPrint(allocator, "api.{s}", .{domain});
    defer if (api_domain_owned) allocator.free(api_domain);

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
pub fn parseHeader(header_str: []const u8) !CustomHeader {
    const colon_pos = std.mem.indexOfScalar(u8, header_str, ':') orelse {
        return error.InvalidHeader;
    };

    return CustomHeader{
        .name = header_str[0..colon_pos],
        .value = header_str[colon_pos + 1 ..],
    };
}

/// Build header list from Context auth state + custom headers
pub fn buildHeaders(
    allocator: std.mem.Allocator,
    ctx: *const Context,
    custom_headers: []const CustomHeader,
) ![]std.http.Header {
    switch (ctx.auth_type) {
        .bearer => {
            const base_count = 2;
            const total_count = base_count + custom_headers.len;
            var headers = try allocator.alloc(std.http.Header, total_count);

            const bearer_value = try std.fmt.allocPrint(
                allocator,
                "Bearer {s}",
                .{ctx.access_token.?},
            );
            // Note: bearer_value is arena-allocated so lifetime matches headers slice

            headers[0] = .{ .name = "Authorization", .value = bearer_value };
            headers[1] = .{ .name = "Accept", .value = "application/json" };

            for (custom_headers, 0..) |custom, i| {
                headers[base_count + i] = .{ .name = custom.name, .value = custom.value };
            }

            return headers;
        },
        .api_key => {
            const base_count = 3;
            const total_count = base_count + custom_headers.len;
            var headers = try allocator.alloc(std.http.Header, total_count);

            headers[0] = .{ .name = "DD-API-KEY", .value = ctx.api_key };
            headers[1] = .{ .name = "DD-APPLICATION-KEY", .value = ctx.app_key };
            headers[2] = .{ .name = "Accept", .value = "application/json" };

            for (custom_headers, 0..) |custom, i| {
                headers[base_count + i] = .{ .name = custom.name, .value = custom.value };
            }

            return headers;
        },
    }
}

// ============================================================================
// HTTP Request Execution
// ============================================================================

/// Parse HTTP method string to enum
pub fn parseHttpMethod(method_str: []const u8) !std.http.Method {
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
pub fn executeRequest(
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

/// Parse ISO 8601 timestamp to Unix epoch seconds
/// Format: YYYY-MM-DDTHH:MM:SSZ
pub fn parseIso8601ToUnix(timestamp_str: []const u8) !i64 {
    if (timestamp_str.len < 19) return error.InvalidTimestamp;

    const year = try std.fmt.parseInt(i32, timestamp_str[0..4], 10);
    const month = try std.fmt.parseInt(u8, timestamp_str[5..7], 10);
    const day = try std.fmt.parseInt(u8, timestamp_str[8..10], 10);
    const hour = try std.fmt.parseInt(u8, timestamp_str[11..13], 10);
    const minute = try std.fmt.parseInt(u8, timestamp_str[14..16], 10);
    const second = try std.fmt.parseInt(u8, timestamp_str[17..19], 10);

    // Calculate days since Unix epoch (1970-01-01)
    // This is a simplified calculation that works for dates after 1970
    const days_per_month = [_]i32{ 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };

    var total_days: i64 = 0;

    // Years
    var y: i32 = 1970;
    while (y < year) : (y += 1) {
        if (@rem(y, 4) == 0 and (@rem(y, 100) != 0 or @rem(y, 400) == 0)) {
            total_days += 366; // Leap year
        } else {
            total_days += 365;
        }
    }

    // Months
    var m: usize = 1;
    while (m < month) : (m += 1) {
        total_days += days_per_month[m - 1];
        // Add leap day for February if this is a leap year
        if (m == 2 and @rem(year, 4) == 0 and (@rem(year, 100) != 0 or @rem(year, 400) == 0)) {
            total_days += 1;
        }
    }

    // Days
    total_days += day - 1;

    // Convert to seconds and add time
    return total_days * 86400 + @as(i64, hour) * 3600 + @as(i64, minute) * 60 + second;
}

/// Build query parameters including optional date range from context
pub fn buildQueryParams(
    allocator: std.mem.Allocator,
    config: *const Context,
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

/// Build query params with Unix millisecond timestamps for infrastructure/network APIs
pub fn buildQueryParamsWithUnixTimestamps(
    allocator: std.mem.Allocator,
    config: *const Context,
    extra_params: []const QueryParam,
) ![]QueryParam {
    var params: std.ArrayList(QueryParam) = .empty;
    errdefer params.deinit(allocator);

    // Add extra params first
    for (extra_params) |param| {
        try params.append(allocator, param);
    }

    // Add date range as Unix milliseconds if present
    if (config.from_timestamp) |from| {
        const unix_seconds = try parseIso8601ToUnix(from);
        const unix_millis_str = try std.fmt.allocPrint(allocator, "{d}", .{unix_seconds * 1000});
        errdefer allocator.free(unix_millis_str);
        try params.append(allocator, .{ .key = "from", .value = unix_millis_str });
    }
    if (config.to_timestamp) |to| {
        const unix_seconds = try parseIso8601ToUnix(to);
        const unix_millis_str = try std.fmt.allocPrint(allocator, "{d}", .{unix_seconds * 1000});
        errdefer allocator.free(unix_millis_str);
        try params.append(allocator, .{ .key = "to", .value = unix_millis_str });
    }

    return try params.toOwnedSlice(allocator);
}

// ============================================================================
// Output Helpers
// ============================================================================

/// Write response to stdout with newline
/// Uses unbuffered writes to avoid buffer size limitations
pub fn writeOutput(response: []const u8) !void {
    const stdout = std.fs.File.stdout();
    try stdout.writeAll(response);
    try stdout.writeAll("\n");
}

// Datadog Logs API constants
pub const DATADOG_MAX_PAGE_SIZE: usize = 1000;
pub const DATADOG_DEFAULT_PAGE_SIZE: usize = 1000;

/// Escape a string for JSON (handles all control characters)
pub fn jsonEscape(allocator: std.mem.Allocator, input: []const u8) ![]const u8 {
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    for (input) |c| {
        switch (c) {
            '"' => try result.appendSlice(allocator, "\\\""),
            '\\' => try result.appendSlice(allocator, "\\\\"),
            '\n' => try result.appendSlice(allocator, "\\n"),
            '\r' => try result.appendSlice(allocator, "\\r"),
            '\t' => try result.appendSlice(allocator, "\\t"),
            '\x08' => try result.appendSlice(allocator, "\\b"),
            '\x0C' => try result.appendSlice(allocator, "\\f"),
            0x00...0x07, 0x0B, 0x0E...0x1F => {
                try result.writer(allocator).print("\\u{x:0>4}", .{c});
            },
            else => try result.append(allocator, c),
        }
    }

    return result.toOwnedSlice(allocator);
}

/// Convert a std.json.Value to JSON string
pub fn valueToJson(allocator: std.mem.Allocator, value: std.json.Value) error{OutOfMemory}![]const u8 {
    var result: std.ArrayList(u8) = .empty;
    errdefer result.deinit(allocator);

    try valueToJsonWriter(allocator, value, &result);
    return result.toOwnedSlice(allocator);
}

fn valueToJsonWriter(allocator: std.mem.Allocator, value: std.json.Value, list: *std.ArrayList(u8)) error{OutOfMemory}!void {
    switch (value) {
        .null => try list.appendSlice(allocator, "null"),
        .bool => |b| try list.appendSlice(allocator, if (b) "true" else "false"),
        .integer => |i| {
            const str = try std.fmt.allocPrint(allocator, "{d}", .{i});
            defer allocator.free(str);
            try list.appendSlice(allocator, str);
        },
        .float => |f| {
            const str = try std.fmt.allocPrint(allocator, "{d}", .{f});
            defer allocator.free(str);
            try list.appendSlice(allocator, str);
        },
        .number_string => |ns| try list.appendSlice(allocator, ns),
        .string => |s| {
            try list.append(allocator, '"');
            const escaped = try jsonEscape(allocator, s);
            defer allocator.free(escaped);
            try list.appendSlice(allocator, escaped);
            try list.append(allocator, '"');
        },
        .array => |arr| {
            try list.append(allocator, '[');
            for (arr.items, 0..) |item, i| {
                if (i > 0) try list.append(allocator, ',');
                try valueToJsonWriter(allocator, item, list);
            }
            try list.append(allocator, ']');
        },
        .object => |obj| {
            try list.append(allocator, '{');
            var first = true;
            var iter = obj.iterator();
            while (iter.next()) |entry| {
                if (!first) try list.append(allocator, ',');
                first = false;
                try list.append(allocator, '"');
                const escaped_key = try jsonEscape(allocator, entry.key_ptr.*);
                defer allocator.free(escaped_key);
                try list.appendSlice(allocator, escaped_key);
                try list.appendSlice(allocator, "\":");
                try valueToJsonWriter(allocator, entry.value_ptr.*, list);
            }
            try list.append(allocator, '}');
        },
    }
}

/// Write a single log line as JSON to stdout with immediate flush
pub fn writeLogLine(allocator: std.mem.Allocator, log_value: std.json.Value) !void {
    const json_str = try valueToJson(allocator, log_value);
    defer allocator.free(json_str);

    const stdout_file = std.fs.File.stdout();
    try stdout_file.writeAll(json_str);
    try stdout_file.writeAll("\n");
}

// ============================================================================
// Shared Request Builders
// ============================================================================

/// Build JSON request body for events search API using generated types
fn buildEventsSearchRequest(
    from_timestamp: ?[]const u8,
    to_timestamp: ?[]const u8,
    query: ?[]const u8,
    cursor: ?[]const u8,
    limit: i64,
    sort: ?[]const u8,
) EventsListRequest {
    _ = sort; // sort parameter currently unused - EventsSort is an empty struct in API
    return EventsListRequest{
        .filter = EventsQueryFilter{
            .from = from_timestamp,
            .to = to_timestamp,
            .query = query,
        },
        .page = EventsRequestPage{
            .cursor = cursor,
            .limit = limit,
        },
        .sort = null, // EventsSort is an empty struct in API
        .options = null,
    };
}

/// Stream events with automatic pagination
pub fn streamEventsSearch(
    allocator: std.mem.Allocator,
    url_base: []const u8,
    headers: []const std.http.Header,
    from_timestamp: ?[]const u8,
    to_timestamp: ?[]const u8,
    query: ?[]const u8,
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

    var client: std.http.Client = .{ .allocator = allocator };
    defer client.deinit();

    while (true) {
        // Check if we've hit the limit
        if (limit) |max| {
            if (total_output >= max) break;
        }

        // Build request using generated types
        const request = buildEventsSearchRequest(
            from_timestamp,
            to_timestamp,
            query,
            cursor,
            page_limit,
            sort,
        );

        // Serialize to JSON using fmt
        const body = try std.fmt.allocPrint(arena.allocator(), "{f}", .{std.json.fmt(request, .{ .emit_null_optional_fields = false })});

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
            std.debug.print("Successfully retrieved {d} events before failure.\n", .{total_output});
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
                std.debug.print("Successfully retrieved {d} events before rate limit.\n", .{total_output});
                std.debug.print("Consider reducing --limit or narrowing --query to reduce data volume.\n", .{});
            } else if (page_num > 1) {
                std.debug.print("Successfully retrieved {d} events before failure.\n", .{total_output});
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
            std.debug.print("Successfully retrieved {d} events before failure.\n", .{total_output});
            return err;
        };

        // Extract data array
        const data_array = if (parsed.value.object.get("data")) |data|
            if (data == .array) data.array else return error.InvalidResponse
        else
            return error.InvalidResponse;

        // Stream each event
        for (data_array.items) |event| {
            // Check limit before output
            if (limit) |max| {
                if (total_output >= max) break;
            }

            try writeLogLine(allocator, event);
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

/// Build query string combining FILTER with service/operation/resource filters
pub fn buildSpansQuery(
    allocator: std.mem.Allocator,
    base_filter: ?[]const u8,
    service: ?[]const u8,
    operation: ?[]const u8,
    resource: ?[]const u8,
) ![]const u8 {
    var parts: std.ArrayList([]const u8) = .empty;
    defer parts.deinit(allocator);

    // Add base filter
    if (base_filter) |filter| {
        if (filter.len > 0 and !std.mem.eql(u8, filter, "*")) {
            try parts.append(allocator, filter);
        }
    }

    // Add service filter
    if (service) |svc| {
        const service_filter = try std.fmt.allocPrint(allocator, "service:{s}", .{svc});
        try parts.append(allocator, service_filter);
    }

    // Add operation filter
    if (operation) |op| {
        const operation_filter = try std.fmt.allocPrint(allocator, "operation:{s}", .{op});
        try parts.append(allocator, operation_filter);
    }

    // Add resource filter
    if (resource) |res| {
        const resource_filter = try std.fmt.allocPrint(allocator, "resource:{s}", .{res});
        try parts.append(allocator, resource_filter);
    }

    // Join with spaces
    if (parts.items.len == 0) {
        return try allocator.dupe(u8, "*");
    }

    var result: std.ArrayList(u8) = .empty;
    defer result.deinit(allocator);

    for (parts.items, 0..) |part, i| {
        if (i > 0) {
            try result.append(allocator, ' ');
        }
        try result.appendSlice(allocator, part);
    }

    return result.toOwnedSlice(allocator);
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
    const config = Context{
        .allocator = std.testing.allocator,
        .dd_domain = "datadoghq.com",
        .dd_domain_owned = null,
        .auth_type = .api_key,
        .api_key = "test_key",
        .app_key = "test_app_key",
        .access_token = null,
        .from_timestamp = "2024-01-15T00:00:00Z",
        .to_timestamp = "2024-01-15T23:59:59Z",
        .verbose = false,
        .from_explicit = true,
        .to_explicit = true,
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
    const config = Context{
        .allocator = std.testing.allocator,
        .dd_domain = "datadoghq.com",
        .dd_domain_owned = null,
        .auth_type = .api_key,
        .api_key = "test_key",
        .app_key = "test_app_key",
        .access_token = null,
        .from_timestamp = null,
        .to_timestamp = null,
        .verbose = false,
        .from_explicit = false,
        .to_explicit = false,
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

test "parseRelativeTime - minutes" {
    const t1 = try parseRelativeTime("5m");
    try std.testing.expectEqual(@as(i64, 5), t1.value);
    try std.testing.expectEqual(TimeUnit.minutes, t1.unit);

    const t2 = try parseRelativeTime("10mins");
    try std.testing.expectEqual(@as(i64, 10), t2.value);
    try std.testing.expectEqual(TimeUnit.minutes, t2.unit);

    const t3 = try parseRelativeTime("1minute");
    try std.testing.expectEqual(@as(i64, 1), t3.value);
    try std.testing.expectEqual(TimeUnit.minutes, t3.unit);
}

test "parseRelativeTime - hours" {
    const t1 = try parseRelativeTime("2h");
    try std.testing.expectEqual(@as(i64, 2), t1.value);
    try std.testing.expectEqual(TimeUnit.hours, t1.unit);

    const t2 = try parseRelativeTime("24hours");
    try std.testing.expectEqual(@as(i64, 24), t2.value);
    try std.testing.expectEqual(TimeUnit.hours, t2.unit);

    const t3 = try parseRelativeTime("1hr");
    try std.testing.expectEqual(@as(i64, 1), t3.value);
    try std.testing.expectEqual(TimeUnit.hours, t3.unit);
}

test "parseRelativeTime - days" {
    const t1 = try parseRelativeTime("1d");
    try std.testing.expectEqual(@as(i64, 1), t1.value);
    try std.testing.expectEqual(TimeUnit.days, t1.unit);

    const t2 = try parseRelativeTime("7days");
    try std.testing.expectEqual(@as(i64, 7), t2.value);
    try std.testing.expectEqual(TimeUnit.days, t2.unit);
}

test "parseRelativeTime - weeks" {
    const t1 = try parseRelativeTime("1w");
    try std.testing.expectEqual(@as(i64, 1), t1.value);
    try std.testing.expectEqual(TimeUnit.weeks, t1.unit);

    const t2 = try parseRelativeTime("2weeks");
    try std.testing.expectEqual(@as(i64, 2), t2.value);
    try std.testing.expectEqual(TimeUnit.weeks, t2.unit);
}

test "parseRelativeTime - months" {
    const t1 = try parseRelativeTime("1mo");
    try std.testing.expectEqual(@as(i64, 1), t1.value);
    try std.testing.expectEqual(TimeUnit.months, t1.unit);

    const t2 = try parseRelativeTime("3months");
    try std.testing.expectEqual(@as(i64, 3), t2.value);
    try std.testing.expectEqual(TimeUnit.months, t2.unit);

    const t3 = try parseRelativeTime("6mos");
    try std.testing.expectEqual(@as(i64, 6), t3.value);
    try std.testing.expectEqual(TimeUnit.months, t3.unit);
}

test "parseRelativeTime - invalid inputs" {
    try std.testing.expectError(error.InvalidRelativeTime, parseRelativeTime(""));
    try std.testing.expectError(error.InvalidRelativeTime, parseRelativeTime("d"));
    try std.testing.expectError(error.InvalidTimeUnit, parseRelativeTime("5x"));
    try std.testing.expectError(error.InvalidTimeUnit, parseRelativeTime("10years"));
}

test "relativeTimeToSeconds" {
    const minutes = RelativeTime{ .value = 5, .unit = .minutes };
    try std.testing.expectEqual(@as(i64, 300), relativeTimeToSeconds(minutes));

    const hours = RelativeTime{ .value = 2, .unit = .hours };
    try std.testing.expectEqual(@as(i64, 7200), relativeTimeToSeconds(hours));

    const days = RelativeTime{ .value = 1, .unit = .days };
    try std.testing.expectEqual(@as(i64, 86400), relativeTimeToSeconds(days));

    const weeks = RelativeTime{ .value = 1, .unit = .weeks };
    try std.testing.expectEqual(@as(i64, 604800), relativeTimeToSeconds(weeks));

    const months = RelativeTime{ .value = 1, .unit = .months };
    try std.testing.expectEqual(@as(i64, 2592000), relativeTimeToSeconds(months));
}

test "formatTimestamp" {
    // Test a known timestamp: 2024-01-01 00:00:00 UTC
    const timestamp: i64 = 1704067200;
    const formatted = try formatTimestamp(std.testing.allocator, timestamp);
    defer std.testing.allocator.free(formatted);
    try std.testing.expectEqualStrings("2024-01-01T00:00:00Z", formatted);
}

test "parseTimeArg - relative time from" {
    const current_time: i64 = 1704067200; // 2024-01-01 00:00:00 UTC
    const result = try parseTimeArg(std.testing.allocator, "1d", current_time, true);
    defer if (result) |r| std.testing.allocator.free(r);

    // Should be 24 hours earlier: 2023-12-31 00:00:00 UTC
    try std.testing.expect(result != null);
    try std.testing.expectEqualStrings("2023-12-31T00:00:00Z", result.?);
}

test "parseTimeArg - absolute time" {
    const current_time: i64 = 1704067200;
    const result = try parseTimeArg(std.testing.allocator, "2024-01-15T10:00:00Z", current_time, true);
    defer if (result) |r| std.testing.allocator.free(r);

    try std.testing.expect(result != null);
    try std.testing.expectEqualStrings("2024-01-15T10:00:00Z", result.?);
}

test "parseTimeArg - null from returns default 15 minutes ago" {
    const current_time: i64 = 1704067200; // 2024-01-01 00:00:00 UTC
    const result = try parseTimeArg(std.testing.allocator, null, current_time, true);
    defer if (result) |r| std.testing.allocator.free(r);

    try std.testing.expect(result != null);
    // Should be 15 minutes earlier: 2023-12-31 23:45:00 UTC
    try std.testing.expectEqualStrings("2023-12-31T23:45:00Z", result.?);
}

test "parseTimeArg - null to defaults to current time" {
    const current_time: i64 = 1704067200; // 2024-01-01 00:00:00 UTC
    const result = try parseTimeArg(std.testing.allocator, null, current_time, false);
    defer if (result) |r| std.testing.allocator.free(r);

    try std.testing.expect(result != null);
    try std.testing.expectEqualStrings("2024-01-01T00:00:00Z", result.?);
}

test "parseTimeArg - now keyword lowercase" {
    const current_time: i64 = 1704067200; // 2024-01-01 00:00:00 UTC
    const result = try parseTimeArg(std.testing.allocator, "now", current_time, true);
    defer if (result) |r| std.testing.allocator.free(r);

    try std.testing.expect(result != null);
    try std.testing.expectEqualStrings("2024-01-01T00:00:00Z", result.?);
}

test "parseTimeArg - now keyword uppercase" {
    const current_time: i64 = 1704067200; // 2024-01-01 00:00:00 UTC
    const result = try parseTimeArg(std.testing.allocator, "NOW", current_time, true);
    defer if (result) |r| std.testing.allocator.free(r);

    try std.testing.expect(result != null);
    try std.testing.expectEqualStrings("2024-01-01T00:00:00Z", result.?);
}

test "parseTimeArg - now keyword mixed case" {
    const current_time: i64 = 1704067200; // 2024-01-01 00:00:00 UTC
    const result = try parseTimeArg(std.testing.allocator, "NoW", current_time, true);
    defer if (result) |r| std.testing.allocator.free(r);

    try std.testing.expect(result != null);
    try std.testing.expectEqualStrings("2024-01-01T00:00:00Z", result.?);
}

test "parseTimeArg - now keyword for to parameter" {
    const current_time: i64 = 1704067200; // 2024-01-01 00:00:00 UTC
    const result = try parseTimeArg(std.testing.allocator, "now", current_time, false);
    defer if (result) |r| std.testing.allocator.free(r);

    try std.testing.expect(result != null);
    try std.testing.expectEqualStrings("2024-01-01T00:00:00Z", result.?);
}
