const std = @import("std");
const yazap = @import("yazap");

const App = yazap.App;
const Arg = yazap.Arg;

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Set up argument parser
    var app = App.init(allocator, "dd-cli", "Query Datadog API and output JSON results");
    defer app.deinit();

    var root = app.rootCommand();

    try root.addArg(Arg.singleValueOption("url", 'u', "Datadog domain URL (e.g., datadoghq.com)"));
    try root.addArg(Arg.singleValueOption("path", 'p', "API path to query (e.g., /api/v1/query)"));

    // Parse arguments
    const matches = try app.parseProcess();

    // Get configuration
    const dd_url = matches.getSingleValue("url") orelse "datadoghq.com";
    const api_path = matches.getSingleValue("path") orelse {
        std.debug.print("Error: --path (-p) is required\n", .{});
        return error.MissingPath;
    };

    // Get API key from environment
    const api_key = std.process.getEnvVarOwned(allocator, "DD_APP_API_KEY") catch |err| {
        std.debug.print("Error: DD_APP_API_KEY environment variable not set\n", .{});
        return err;
    };
    defer allocator.free(api_key);

    // Validate Datadog domain
    if (!isValidDatadogDomain(dd_url)) {
        std.debug.print("Error: Invalid Datadog domain: {s}\n", .{dd_url});
        std.debug.print("Valid domains should end with 'datadoghq.com', 'datadoghq.eu', or similar\n", .{});
        return error.InvalidDomain;
    }

    // Build full URL
    const full_url = try std.fmt.allocPrint(allocator, "https://{s}{s}", .{ dd_url, api_path });
    defer allocator.free(full_url);

    // Query Datadog API
    const response_body = try queryDatadog(allocator, full_url, api_key);
    defer allocator.free(response_body);

    // Output JSON to stdout
    var stdout_buf: [4096]u8 = undefined;
    var stdout_writer = std.fs.File.stdout().writer(&stdout_buf);
    defer stdout_writer.interface.flush() catch {};

    try stdout_writer.interface.writeAll(response_body);
    try stdout_writer.interface.writeByte('\n');
}

fn isValidDatadogDomain(domain: []const u8) bool {
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

fn queryDatadog(allocator: std.mem.Allocator, url: []const u8, api_key: []const u8) ![]const u8 {
    // Initialize HTTP client
    var client: std.http.Client = .{
        .allocator = allocator,
    };
    defer client.deinit();

    // Prepare response body accumulator
    var body_writer = std.Io.Writer.Allocating.init(allocator);
    defer body_writer.deinit();

    // Build headers
    var header_buf: [2]std.http.Header = undefined;
    header_buf[0] = .{ .name = "DD-API-KEY", .value = api_key };
    header_buf[1] = .{ .name = "Accept", .value = "application/json" };

    // Perform request
    const result = try client.fetch(.{
        .location = .{ .url = url },
        .method = .GET,
        .extra_headers = &header_buf,
        .response_writer = &body_writer.writer,
    });

    // Check response status
    if (result.status != .ok) {
        std.debug.print("Error: HTTP request failed with status: {}\n", .{result.status});
        return error.RequestFailed;
    }

    // Return accumulated response body
    return try allocator.dupe(u8, body_writer.written());
}

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
