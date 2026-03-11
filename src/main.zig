const std = @import("std");
const yazap = @import("yazap");

const App = yazap.App;
const Arg = yazap.Arg;

const common = @import("common.zig");
const list = @import("list.zig");
const aggregate = @import("aggregate.zig");
const get = @import("get.zig");
const validate = @import("validate.zig");
const raw = @import("raw.zig");
const auth_mod = @import("auth.zig");

// ============================================================================
// Main Entry Point
// ============================================================================

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const allocator = gpa.allocator();

    // Set up argument parser with subcommands
    var app = App.init(allocator, "dd-cli", "Query Datadog API with subcommands for common operations");
    defer app.deinit();

    var root = app.rootCommand();

    // Global flags
    try root.addArg(Arg.singleValueOption("domain", 'd', "Datadog domain (e.g., datadoghq.com, datadoghq.eu)"));
    try root.addArg(Arg.singleValueOption("from", null, "Start time: relative (e.g., 1d, 2hours) or ISO 8601 (e.g., 2024-01-15T10:00:00Z)"));
    try root.addArg(Arg.singleValueOption("to", null, "End time: relative (e.g., 1h) or ISO 8601 (defaults to current time if not specified)"));
    try root.addArg(Arg.booleanOption("verbose", 'v', "Print each request URL to stderr before executing"));

    // ========================================================================
    // Verb-First Command Structure
    // ========================================================================

    // list command - enumerate resources
    var list_cmd = app.createCommand("list", "List resources");

    // list logs [FILTER]
    var list_logs_cmd = app.createCommand("logs", "List log events");
    var logs_filter_arg = Arg.positional("FILTER", "Log filter query (default: *)", null);
    logs_filter_arg.setMinValues(0);
    try list_logs_cmd.addArg(logs_filter_arg);
    try list_logs_cmd.addArg(Arg.singleValueOption("indexes", 'i', "Comma-separated indexes (default: *)"));
    try list_logs_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max total logs (default: 1000 without --auto-paginate, unlimited with)"));
    try list_logs_cmd.addArg(Arg.singleValueOption("page-size", null, "Logs per API request (default: 1000, max: 1000)"));
    try list_logs_cmd.addArg(Arg.singleValueOption("sort", 's', "Sort order (default: -timestamp)"));
    try list_logs_cmd.addArg(Arg.booleanOption("auto-paginate", null, "Fetch multiple pages automatically"));
    try list_cmd.addSubcommand(list_logs_cmd);

    // list hosts [FILTER]
    var list_hosts_cmd = app.createCommand("hosts", "List hosts");
    var hosts_filter_arg = Arg.positional("FILTER", "Host filter query (optional)", null);
    hosts_filter_arg.setMinValues(0);
    try list_hosts_cmd.addArg(hosts_filter_arg);
    try list_cmd.addSubcommand(list_hosts_cmd);

    // list metrics [QUERY]
    var list_metrics_cmd = app.createCommand("metrics", "List/search metrics by name");
    var metrics_query_arg = Arg.positional("QUERY", "Metric search query (default: *)", null);
    metrics_query_arg.setMinValues(0);
    try list_metrics_cmd.addArg(metrics_query_arg);
    try list_cmd.addSubcommand(list_metrics_cmd);

    // list apis [QUERY]
    var list_apis_cmd = app.createCommand("apis", "List APIs from the API catalog");
    var apis_query_arg = Arg.positional("QUERY", "API search query (optional)", null);
    apis_query_arg.setMinValues(0);
    try list_apis_cmd.addArg(apis_query_arg);
    try list_apis_cmd.addArg(Arg.singleValueOption("limit", null, "Maximum number of APIs to return per page"));
    try list_apis_cmd.addArg(Arg.singleValueOption("offset", null, "Offset for pagination"));
    try list_cmd.addSubcommand(list_apis_cmd);

    // list services [FILTER]
    var list_services_cmd = app.createCommand("services", "List APM services");
    var services_filter_arg = Arg.positional("FILTER", "Service filter query (optional)", null);
    services_filter_arg.setMinValues(0);
    try list_services_cmd.addArg(services_filter_arg);
    try list_services_cmd.addArg(Arg.singleValueOption("env", null, "Filter by environment (e.g., prod, staging)"));
    try list_cmd.addSubcommand(list_services_cmd);

    // list spans [FILTER]
    var list_spans_cmd = app.createCommand("spans", "List span events");
    var spans_filter_arg = Arg.positional("FILTER", "Span filter query (default: *)", null);
    spans_filter_arg.setMinValues(0);
    try list_spans_cmd.addArg(spans_filter_arg);
    try list_spans_cmd.addArg(Arg.singleValueOption("service", null, "Filter by service name"));
    try list_spans_cmd.addArg(Arg.singleValueOption("operation", null, "Filter by operation name"));
    try list_spans_cmd.addArg(Arg.singleValueOption("resource", null, "Filter by resource name"));
    try list_spans_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max total spans (default: 1000 without --auto-paginate, unlimited with)"));
    try list_spans_cmd.addArg(Arg.singleValueOption("page-size", null, "Spans per API request (default: 1000, max: 1000)"));
    try list_spans_cmd.addArg(Arg.singleValueOption("sort", 's', "Sort order (default: -timestamp)"));
    try list_spans_cmd.addArg(Arg.booleanOption("auto-paginate", null, "Fetch multiple pages automatically"));
    try list_cmd.addSubcommand(list_spans_cmd);

    // list events [FILTER]
    var list_events_cmd = app.createCommand("events", "List events");
    var events_filter_arg = Arg.positional("FILTER", "Event filter query (default: *)", null);
    events_filter_arg.setMinValues(0);
    try list_events_cmd.addArg(events_filter_arg);
    try list_events_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max total events (default: 1000 without --auto-paginate, unlimited with)"));
    try list_events_cmd.addArg(Arg.singleValueOption("page-size", null, "Events per API request (default: 1000, max: 1000)"));
    try list_events_cmd.addArg(Arg.singleValueOption("sort", 's', "Sort order (default: -timestamp)"));
    try list_events_cmd.addArg(Arg.booleanOption("auto-paginate", null, "Fetch multiple pages automatically"));
    try list_cmd.addSubcommand(list_events_cmd);

    // list monitors [QUERY]
    var list_monitors_cmd = app.createCommand("monitors", "List monitors");
    var monitors_query_arg = Arg.positional("QUERY", "Monitor search query (optional)", null);
    monitors_query_arg.setMinValues(0);
    try list_monitors_cmd.addArg(monitors_query_arg);
    try list_monitors_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max monitors to return"));
    try list_cmd.addSubcommand(list_monitors_cmd);

    // list downtimes
    var list_downtimes_cmd = app.createCommand("downtimes", "List downtimes");
    try list_downtimes_cmd.addArg(Arg.booleanOption("active", null, "Show only currently active downtimes"));
    try list_downtimes_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max downtimes to return"));
    try list_cmd.addSubcommand(list_downtimes_cmd);

    // list containers
    var list_containers_cmd = app.createCommand("containers", "List containers");
    try list_containers_cmd.addArg(Arg.singleValueOption("tags", 't', "Filter by tags (comma-separated)"));
    try list_containers_cmd.addArg(Arg.singleValueOption("group-by", 'g', "Group by field"));
    try list_containers_cmd.addArg(Arg.singleValueOption("sort", 's', "Sort order"));
    try list_containers_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max containers to return"));
    try list_containers_cmd.addArg(Arg.singleValueOption("cursor", 'c', "Pagination cursor"));
    try list_cmd.addSubcommand(list_containers_cmd);

    // list processes
    var list_processes_cmd = app.createCommand("processes", "List processes");
    try list_processes_cmd.addArg(Arg.singleValueOption("search", 's', "Search process names"));
    try list_processes_cmd.addArg(Arg.singleValueOption("tags", 't', "Filter by tags (comma-separated)"));
    try list_processes_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max processes to return"));
    try list_processes_cmd.addArg(Arg.singleValueOption("cursor", 'c', "Pagination cursor"));
    try list_cmd.addSubcommand(list_processes_cmd);

    try root.addSubcommand(list_cmd);

    // aggregate command - compute statistics
    var aggregate_cmd = app.createCommand("aggregate", "Aggregate data across resources");

    // aggregate logs [FILTER]
    var aggregate_logs_cmd = app.createCommand("logs", "Aggregate log analytics");
    var agg_filter_arg = Arg.positional("FILTER", "Aggregation filter query (default: *)", null);
    agg_filter_arg.setMinValues(0);
    try aggregate_logs_cmd.addArg(agg_filter_arg);
    try aggregate_logs_cmd.addArg(Arg.singleValueOption("query", 'q', "Search query (fallback to --query for compatibility)"));
    try aggregate_logs_cmd.addArg(Arg.multiValuesOption("compute", 'c', "Compute metric (format: [name=]aggregation:field, e.g., count:*, total='count:*'). Repeatable.", 20));
    try aggregate_logs_cmd.addArg(Arg.multiValuesOption("group-by", 'g', "Group by facet (repeatable, e.g., -g host -g service)", 20));
    try aggregate_logs_cmd.addArg(Arg.singleValueOption("indexes", 'i', "Comma-separated indexes (default: *)"));
    try aggregate_logs_cmd.addArg(Arg.singleValueOption("limit", null, "Max buckets per group-by (default: 10)"));
    try aggregate_cmd.addSubcommand(aggregate_logs_cmd);

    // aggregate metrics
    var aggregate_metrics_cmd = app.createCommand("metrics", "Aggregate metrics with MQL queries and formulas (V2 API)");
    try aggregate_metrics_cmd.addArg(Arg.multiValuesOption("query", 'q', "Query with optional name (format: [name=]query, e.g., 'avg:cpu{*}' or cpu='avg:cpu{*}'). Repeatable.", 20));
    try aggregate_metrics_cmd.addArg(Arg.multiValuesOption("formula", 'f', "Formula combining queries (e.g., 'query1 + query2'). Repeatable. Results ordered by formula declaration.", 10));
    try aggregate_cmd.addSubcommand(aggregate_metrics_cmd);

    // aggregate spans [FILTER]
    var aggregate_spans_cmd = app.createCommand("spans", "Aggregate span analytics");
    var agg_spans_filter_arg = Arg.positional("FILTER", "Aggregation filter query (default: *)", null);
    agg_spans_filter_arg.setMinValues(0);
    try aggregate_spans_cmd.addArg(agg_spans_filter_arg);
    try aggregate_spans_cmd.addArg(Arg.multiValuesOption("compute", 'c', "Compute metric (format: [name=]aggregation:field, e.g., count:*, avg:@duration). Repeatable.", 20));
    try aggregate_spans_cmd.addArg(Arg.multiValuesOption("group-by", 'g', "Group by facet (repeatable, e.g., -g service -g operation)", 20));
    try aggregate_spans_cmd.addArg(Arg.singleValueOption("service", null, "Filter by service name"));
    try aggregate_spans_cmd.addArg(Arg.singleValueOption("operation", null, "Filter by operation name"));
    try aggregate_spans_cmd.addArg(Arg.singleValueOption("limit", null, "Max buckets per group-by (default: 10)"));
    try aggregate_cmd.addSubcommand(aggregate_spans_cmd);

    // aggregate connections
    var aggregate_connections_cmd = app.createCommand("connections", "Aggregate network connection data");
    try aggregate_connections_cmd.addArg(Arg.singleValueOption("tags", 't', "Filter by tags"));
    try aggregate_connections_cmd.addArg(Arg.singleValueOption("group-by", 'g', "Group by field"));
    try aggregate_cmd.addSubcommand(aggregate_connections_cmd);

    // aggregate dns
    var aggregate_dns_cmd = app.createCommand("dns", "Aggregate DNS traffic data");
    try aggregate_dns_cmd.addArg(Arg.singleValueOption("tags", 't', "Filter by tags"));
    try aggregate_dns_cmd.addArg(Arg.singleValueOption("group-by", 'g', "Group by field"));
    try aggregate_cmd.addSubcommand(aggregate_dns_cmd);

    try root.addSubcommand(aggregate_cmd);

    // get command - fetch by ID
    var get_cmd = app.createCommand("get", "Get specific resource by ID");

    // get log <ID> (not supported by API)
    var get_log_cmd = app.createCommand("log", "Get single log by ID (not supported by API)");
    try get_log_cmd.addArg(Arg.positional("LOG_ID", "Log identifier", null));
    try get_cmd.addSubcommand(get_log_cmd);

    // get host <HOST_NAME>
    var get_host_cmd = app.createCommand("host", "Get host by name");
    try get_host_cmd.addArg(Arg.positional("HOST_NAME", "Host name", null));
    try get_cmd.addSubcommand(get_host_cmd);

    // get metrics <METRIC_NAME>
    var get_metrics_cmd = app.createCommand("metrics", "Get metric metadata by name");
    try get_metrics_cmd.addArg(Arg.positional("METRIC_NAME", "Metric name (e.g., system.cpu.idle)", null));
    try get_cmd.addSubcommand(get_metrics_cmd);

    // get api <API_ID>
    var get_api_cmd = app.createCommand("api", "Get OpenAPI spec for an API from the catalog");
    try get_api_cmd.addArg(Arg.positional("API_ID", "API identifier", null));
    try get_cmd.addSubcommand(get_api_cmd);

    // get event <EVENT_ID>
    var get_event_cmd = app.createCommand("event", "Get a specific event by ID");
    try get_event_cmd.addArg(Arg.positional("EVENT_ID", "Event identifier", null));
    try get_cmd.addSubcommand(get_event_cmd);

    // get monitor <MONITOR_ID>
    var get_monitor_cmd = app.createCommand("monitor", "Get a specific monitor by ID");
    try get_monitor_cmd.addArg(Arg.positional("MONITOR_ID", "Monitor identifier", null));
    try get_cmd.addSubcommand(get_monitor_cmd);

    // get downtime <DOWNTIME_ID>
    var get_downtime_cmd = app.createCommand("downtime", "Get a specific downtime by ID");
    try get_downtime_cmd.addArg(Arg.positional("DOWNTIME_ID", "Downtime identifier", null));
    try get_cmd.addSubcommand(get_downtime_cmd);

    try root.addSubcommand(get_cmd);

    // validate command - credential validation (unchanged)
    const validate_cmd = app.createCommand("validate", "Validate API credentials");
    try root.addSubcommand(validate_cmd);

    // raw command - low-level API access (unchanged)
    var raw_cmd = app.createCommand("raw", "Low-level API access with full control");
    try raw_cmd.addArg(Arg.singleValueOption("path", 'p', "API path (e.g., /api/v1/hosts)"));
    try raw_cmd.addArg(Arg.singleValueOption("method", 'X', "HTTP method (default: GET)"));
    try raw_cmd.addArg(Arg.singleValueOption("query", 'q', "Pre-formatted query string"));
    try raw_cmd.addArg(Arg.multiValuesOption("header", 'H', "Custom header (Name:Value, repeatable)", 20));
    try raw_cmd.addArg(Arg.singleValueOption("data", null, "Request body"));
    try root.addSubcommand(raw_cmd);

    // auth command - OAuth2 login/logout
    var auth_cmd = app.createCommand("auth", "Manage OAuth2 authentication");
    var auth_login_cmd = app.createCommand("login", "Log in with OAuth2 (PKCE flow)");
    try auth_login_cmd.addArg(Arg.singleValueOption("client-id", null, "OAuth2 client ID override (auto-registered via DCR if omitted)"));
    try auth_cmd.addSubcommand(auth_login_cmd);
    const auth_logout_cmd = app.createCommand("logout", "Remove stored OAuth2 token");
    try auth_cmd.addSubcommand(auth_logout_cmd);
    try root.addSubcommand(auth_cmd);

    // Parse arguments
    const matches = try app.parseProcess();

    // Handle auth commands before building context (no API credentials needed)
    if (matches.subcommandMatches("auth")) |*auth_matches| {
        const domain_from_env = std.process.getEnvVarOwned(allocator, "DD_SITE") catch null;
        defer if (domain_from_env) |d| allocator.free(d);
        const domain = matches.getSingleValue("domain") orelse domain_from_env orelse "datadoghq.com";
        if (auth_matches.subcommandMatches("login")) |*login_matches| {
            try auth_mod.handleLoginCommand(allocator, domain, login_matches.getSingleValue("client-id"));
            return;
        } else if (auth_matches.subcommandMatches("logout")) |_| {
            try auth_mod.handleLogoutCommand(allocator);
            return;
        } else {
            std.debug.print("Error: Use 'auth login' or 'auth logout'\n", .{});
            return error.UnknownSubcommand;
        }
    }

    // Build shared context from global flags (created once, passed to all handlers)
    var ctx = try common.initConfig(
        allocator,
        matches.getSingleValue("domain"),
        matches.getSingleValue("from"),
        matches.getSingleValue("to"),
        matches.containsArg("verbose"),
    );
    defer ctx.deinit();

    // Dispatch to appropriate handler (verb-first)
    if (matches.subcommandMatches("list")) |*list_matches| {
        if (list_matches.subcommandMatches("logs")) |*logs_matches| {
            try list.handleLogsSearch(&ctx, logs_matches);
        } else if (list_matches.subcommandMatches("hosts")) |*hosts_matches| {
            try list.handleHostList(&ctx, hosts_matches);
        } else if (list_matches.subcommandMatches("metrics")) |*metrics_matches| {
            try list.handleMetricsList(&ctx, metrics_matches);
        } else if (list_matches.subcommandMatches("apis")) |*apis_matches| {
            try list.handleApisList(&ctx, apis_matches);
        } else if (list_matches.subcommandMatches("services")) |*services_matches| {
            try list.handleServicesList(&ctx, services_matches);
        } else if (list_matches.subcommandMatches("spans")) |*spans_matches| {
            try list.handleSpansSearch(&ctx, spans_matches);
        } else if (list_matches.subcommandMatches("events")) |*events_matches| {
            try list.handleEventsSearch(&ctx, events_matches);
        } else if (list_matches.subcommandMatches("monitors")) |*monitors_matches| {
            try list.handleMonitorsList(&ctx, monitors_matches);
        } else if (list_matches.subcommandMatches("downtimes")) |*downtimes_matches| {
            try list.handleDowntimesList(&ctx, downtimes_matches);
        } else if (list_matches.subcommandMatches("containers")) |*containers_matches| {
            try list.handleContainersList(&ctx, containers_matches);
        } else if (list_matches.subcommandMatches("processes")) |*processes_matches| {
            try list.handleProcessesList(&ctx, processes_matches);
        } else {
            std.debug.print("Error: Unknown list target. Use 'list logs', 'list hosts', 'list metrics', 'list apis', 'list services', 'list spans', 'list events', 'list monitors', 'list downtimes', 'list containers', or 'list processes'\n", .{});
            std.debug.print("\nExamples:\n", .{});
            std.debug.print("  dd-cli list logs \"error\" --from 1h\n", .{});
            std.debug.print("  dd-cli list hosts\n", .{});
            std.debug.print("  dd-cli list metrics\n", .{});
            std.debug.print("  dd-cli list metrics \"system.cpu\"\n", .{});
            std.debug.print("  dd-cli list apis\n", .{});
            std.debug.print("  dd-cli list services --from 1h\n", .{});
            std.debug.print("  dd-cli list spans --service web --from 1h\n", .{});
            std.debug.print("  dd-cli list events \"*\" --from 1h\n", .{});
            std.debug.print("  dd-cli list containers --tags \"env:prod\" --from 1h\n", .{});
            std.debug.print("  dd-cli list processes --search \"postgres\" --from 1h\n", .{});
            return error.UnknownSubcommand;
        }
    } else if (matches.subcommandMatches("aggregate")) |*agg_matches| {
        if (agg_matches.subcommandMatches("logs")) |*logs_matches| {
            try aggregate.handleLogsAggregate(&ctx, logs_matches);
        } else if (agg_matches.subcommandMatches("metrics")) |*metrics_matches| {
            try aggregate.handleMetricsAggregate(&ctx, metrics_matches);
        } else if (agg_matches.subcommandMatches("spans")) |*spans_matches| {
            try aggregate.handleSpansAggregate(&ctx, spans_matches);
        } else if (agg_matches.subcommandMatches("connections")) |*connections_matches| {
            try aggregate.handleNetworkConnectionsAggregate(&ctx, connections_matches);
        } else if (agg_matches.subcommandMatches("dns")) |*dns_matches| {
            try aggregate.handleNetworkDnsAggregate(&ctx, dns_matches);
        } else {
            std.debug.print("Error: Unknown aggregate target. Use 'aggregate logs', 'aggregate metrics', 'aggregate spans', 'aggregate connections', or 'aggregate dns'\n", .{});
            std.debug.print("\nExamples:\n", .{});
            std.debug.print("  dd-cli aggregate logs --compute count:* --from 1d\n", .{});
            std.debug.print("  dd-cli aggregate logs --compute avg:@duration --group-by service\n", .{});
            std.debug.print("  dd-cli aggregate metrics \"avg:system.cpu.idle{{*}}\" --from 1h\n", .{});
            std.debug.print("  dd-cli aggregate spans --compute count:* --group-by service --from 1h\n", .{});
            std.debug.print("  dd-cli aggregate spans --compute avg:@duration --group-by operation --from 1h\n", .{});
            std.debug.print("  dd-cli aggregate connections --group-by destination_ip --from 1h\n", .{});
            std.debug.print("  dd-cli aggregate dns --group-by query_name --from 30m\n", .{});
            return error.UnknownSubcommand;
        }
    } else if (matches.subcommandMatches("get")) |*get_matches| {
        if (get_matches.subcommandMatches("log")) |*log_matches| {
            try get.handleLogGet(&ctx, log_matches);
        } else if (get_matches.subcommandMatches("host")) |*host_matches| {
            try get.handleHostGet(&ctx, host_matches);
        } else if (get_matches.subcommandMatches("metrics")) |*metrics_matches| {
            try get.handleMetricsGet(&ctx, metrics_matches);
        } else if (get_matches.subcommandMatches("api")) |*api_matches| {
            try get.handleApiGet(&ctx, api_matches);
        } else if (get_matches.subcommandMatches("event")) |*event_matches| {
            try get.handleEventGet(&ctx, event_matches);
        } else if (get_matches.subcommandMatches("monitor")) |*monitor_matches| {
            try get.handleMonitorGet(&ctx, monitor_matches);
        } else if (get_matches.subcommandMatches("downtime")) |*downtime_matches| {
            try get.handleDowntimeGet(&ctx, downtime_matches);
        } else {
            std.debug.print("Error: Unknown get target. Use 'get log', 'get host', 'get metrics', 'get api', 'get event', 'get monitor', or 'get downtime'\n", .{});
            std.debug.print("\nExamples:\n", .{});
            std.debug.print("  dd-cli get host web-server-01\n", .{});
            std.debug.print("  dd-cli get metrics system.cpu.idle\n", .{});
            std.debug.print("  dd-cli get api <api-id>\n", .{});
            std.debug.print("  dd-cli get event <event-id>\n", .{});
            return error.UnknownSubcommand;
        }
    } else if (matches.subcommandMatches("validate")) |*val_matches| {
        try validate.handleValidateCommand(&ctx, val_matches);
    } else if (matches.subcommandMatches("raw")) |*raw_matches| {
        try raw.handleRawCommand(&ctx, raw_matches);
    } else {
        std.debug.print("Error: No subcommand specified.\n", .{});
        std.debug.print("\nAvailable commands:\n", .{});
        std.debug.print("  list      - List resources (logs, hosts, metrics, apis, services, spans, events, monitors, downtimes, containers, processes)\n", .{});
        std.debug.print("  aggregate - Aggregate data (logs, metrics, spans, connections, dns)\n", .{});
        std.debug.print("  get       - Get specific resource by ID (log, host, metrics, api, event, monitor, downtime)\n", .{});
        std.debug.print("  validate  - Validate API credentials\n", .{});
        std.debug.print("  raw       - Low-level API access\n", .{});
        std.debug.print("  auth      - Manage OAuth2 authentication (login/logout)\n", .{});
        std.debug.print("\nExamples:\n", .{});
        std.debug.print("  dd-cli list logs \"error\" --from 1h\n", .{});
        std.debug.print("  dd-cli list metrics\n", .{});
        std.debug.print("  dd-cli list apis\n", .{});
        std.debug.print("  dd-cli list services --from 1h\n", .{});
        std.debug.print("  dd-cli list spans --service web --from 1h\n", .{});
        std.debug.print("  dd-cli list containers --tags \"env:prod\" --from 1h\n", .{});
        std.debug.print("  dd-cli list processes --search \"postgres\" --from 1h\n", .{});
        std.debug.print("  dd-cli aggregate logs --compute count:* --group-by service\n", .{});
        std.debug.print("  dd-cli aggregate metrics \"avg:system.cpu.idle{{*}}\" --from 1h\n", .{});
        std.debug.print("  dd-cli aggregate spans --compute count:* --group-by service --from 1h\n", .{});
        std.debug.print("  dd-cli aggregate connections --from 1h\n", .{});
        std.debug.print("  dd-cli get metrics system.cpu.idle\n", .{});
        std.debug.print("  dd-cli get api <api-id>\n", .{});
        return error.NoSubcommand;
    }
}

// ============================================================================
// Tests
// ============================================================================

test {
    _ = @import("common.zig");
    _ = @import("list.zig");
    _ = @import("aggregate.zig");
    _ = @import("get.zig");
    _ = @import("validate.zig");
    _ = @import("raw.zig");
    _ = @import("auth.zig");
}
