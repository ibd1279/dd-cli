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

    // list incidents [FILTER]
    var list_incidents_cmd = app.createCommand("incidents", "List incidents");
    var incidents_filter_arg = Arg.positional("FILTER", "Incident filter query (optional)", null);
    incidents_filter_arg.setMinValues(0);
    try list_incidents_cmd.addArg(incidents_filter_arg);
    try list_incidents_cmd.addArg(Arg.singleValueOption("state", null, "Filter by state (active, stable, resolved)"));
    try list_incidents_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max incidents to return"));
    try list_cmd.addSubcommand(list_incidents_cmd);

    // list dashboards [FILTER]
    var list_dashboards_cmd = app.createCommand("dashboards", "List dashboards");
    var dashboards_filter_arg = Arg.positional("FILTER", "Filter by dashboard name (optional)", null);
    dashboards_filter_arg.setMinValues(0);
    try list_dashboards_cmd.addArg(dashboards_filter_arg);
    try list_dashboards_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max dashboards to return"));
    try list_cmd.addSubcommand(list_dashboards_cmd);

    // list notebooks [FILTER]
    var list_notebooks_cmd = app.createCommand("notebooks", "List notebooks");
    var notebooks_filter_arg = Arg.positional("FILTER", "Text search query (optional)", null);
    notebooks_filter_arg.setMinValues(0);
    try list_notebooks_cmd.addArg(notebooks_filter_arg);
    try list_notebooks_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max notebooks to return"));
    try list_cmd.addSubcommand(list_notebooks_cmd);

    // list rum [FILTER]
    var list_rum_cmd = app.createCommand("rum", "List RUM events");
    var rum_filter_arg = Arg.positional("FILTER", "RUM filter query (default: *)", null);
    rum_filter_arg.setMinValues(0);
    try list_rum_cmd.addArg(rum_filter_arg);
    try list_rum_cmd.addArg(Arg.singleValueOption("service", null, "Filter by service name"));
    try list_rum_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max total RUM events (default: 1000 without --auto-paginate, unlimited with)"));
    try list_rum_cmd.addArg(Arg.singleValueOption("page-size", null, "RUM events per API request (default: 1000, max: 1000)"));
    try list_rum_cmd.addArg(Arg.singleValueOption("sort", 's', "Sort order (default: -timestamp)"));
    try list_rum_cmd.addArg(Arg.booleanOption("auto-paginate", null, "Fetch multiple pages automatically"));
    try list_cmd.addSubcommand(list_rum_cmd);

    // list errors [FILTER]
    var list_errors_cmd = app.createCommand("errors", "List error tracking issues");
    var errors_filter_arg = Arg.positional("FILTER", "Error filter query (optional)", null);
    errors_filter_arg.setMinValues(0);
    try list_errors_cmd.addArg(errors_filter_arg);
    try list_errors_cmd.addArg(Arg.singleValueOption("service", null, "Filter by service name"));
    try list_errors_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max issues to return"));
    try list_cmd.addSubcommand(list_errors_cmd);

    // list signals [FILTER]
    var list_signals_cmd = app.createCommand("signals", "List security monitoring signals");
    var signals_filter_arg = Arg.positional("FILTER", "Signal filter query (default: *)", null);
    signals_filter_arg.setMinValues(0);
    try list_signals_cmd.addArg(signals_filter_arg);
    try list_signals_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max signals to return"));
    try list_cmd.addSubcommand(list_signals_cmd);

    // list findings [FILTER]
    var list_findings_cmd = app.createCommand("findings", "List security findings");
    var findings_filter_arg = Arg.positional("FILTER", "Filter by tags (optional)", null);
    findings_filter_arg.setMinValues(0);
    try list_findings_cmd.addArg(findings_filter_arg);
    try list_findings_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max findings to return"));
    try list_cmd.addSubcommand(list_findings_cmd);

    // list pipelines [FILTER]
    var list_pipelines_cmd = app.createCommand("pipelines", "List CI pipelines");
    var pipelines_filter_arg = Arg.positional("FILTER", "Search filter (optional)", null);
    pipelines_filter_arg.setMinValues(0);
    try list_pipelines_cmd.addArg(pipelines_filter_arg);
    try list_pipelines_cmd.addArg(Arg.singleValueOption("service", null, "Filter by CI service name"));
    try list_pipelines_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max pipelines to return"));
    try list_cmd.addSubcommand(list_pipelines_cmd);

    // list tests [FILTER]
    var list_tests_cmd = app.createCommand("tests", "List CI test runs");
    var tests_filter_arg = Arg.positional("FILTER", "Search filter (optional)", null);
    tests_filter_arg.setMinValues(0);
    try list_tests_cmd.addArg(tests_filter_arg);
    try list_tests_cmd.addArg(Arg.singleValueOption("service", null, "Filter by service name"));
    try list_tests_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max test runs to return"));
    try list_cmd.addSubcommand(list_tests_cmd);

    // list synthetics [FILTER]
    var list_synthetics_cmd = app.createCommand("synthetics", "List synthetic tests");
    var synthetics_filter_arg = Arg.positional("FILTER", "Filter by text (optional)", null);
    synthetics_filter_arg.setMinValues(0);
    try list_synthetics_cmd.addArg(synthetics_filter_arg);
    try list_synthetics_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max synthetic tests to return"));
    try list_cmd.addSubcommand(list_synthetics_cmd);

    // list devices [FILTER]
    var list_devices_cmd = app.createCommand("devices", "List NDM network devices");
    var devices_filter_arg = Arg.positional("FILTER", "Filter query (optional)", null);
    devices_filter_arg.setMinValues(0);
    try list_devices_cmd.addArg(devices_filter_arg);
    try list_devices_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max devices to return"));
    try list_cmd.addSubcommand(list_devices_cmd);

    // list cases [FILTER]
    var list_cases_cmd = app.createCommand("cases", "List cases");
    var cases_filter_arg = Arg.positional("FILTER", "Search filter (optional)", null);
    cases_filter_arg.setMinValues(0);
    try list_cases_cmd.addArg(cases_filter_arg);
    try list_cases_cmd.addArg(Arg.singleValueOption("state", null, "Filter by state (open, closed)"));
    try list_cases_cmd.addArg(Arg.singleValueOption("priority", null, "Filter by priority (P1..P5)"));
    try list_cases_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max cases to return"));
    try list_cmd.addSubcommand(list_cases_cmd);

    // list dependencies [SERVICE]
    var list_dependencies_cmd = app.createCommand("dependencies", "List service catalog dependencies");
    var dependencies_service_arg = Arg.positional("SERVICE", "Source service node (optional)", null);
    dependencies_service_arg.setMinValues(0);
    try list_dependencies_cmd.addArg(dependencies_service_arg);
    try list_dependencies_cmd.addArg(Arg.singleValueOption("limit", 'n', "Max dependencies to return"));
    try list_cmd.addSubcommand(list_dependencies_cmd);

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

    // get incident <INCIDENT_ID>
    var get_incident_cmd = app.createCommand("incident", "Get a specific incident by ID");
    try get_incident_cmd.addArg(Arg.positional("INCIDENT_ID", "Incident identifier", null));
    try get_cmd.addSubcommand(get_incident_cmd);

    // get notebook <NOTEBOOK_ID>
    var get_notebook_cmd = app.createCommand("notebook", "Get a specific notebook by ID");
    try get_notebook_cmd.addArg(Arg.positional("NOTEBOOK_ID", "Notebook identifier", null));
    try get_cmd.addSubcommand(get_notebook_cmd);

    // get error <ISSUE_ID>
    var get_error_cmd = app.createCommand("error", "Get a specific error tracking issue by ID");
    try get_error_cmd.addArg(Arg.positional("ISSUE_ID", "Error tracking issue identifier", null));
    try get_cmd.addSubcommand(get_error_cmd);

    // get device <DEVICE_ID>
    var get_device_cmd = app.createCommand("device", "Get a specific NDM device by ID");
    try get_device_cmd.addArg(Arg.positional("DEVICE_ID", "Device identifier", null));
    try get_cmd.addSubcommand(get_device_cmd);

    // get case <CASE_ID>
    var get_case_cmd = app.createCommand("case", "Get a specific case by ID");
    try get_case_cmd.addArg(Arg.positional("CASE_ID", "Case identifier", null));
    try get_cmd.addSubcommand(get_case_cmd);

    var get_dashboard_cmd = app.createCommand("dashboard", "Get a specific dashboard by ID");
    try get_dashboard_cmd.addArg(Arg.positional("DASHBOARD_ID", "Dashboard identifier", null));
    try get_cmd.addSubcommand(get_dashboard_cmd);

    var get_synthetic_cmd = app.createCommand("synthetic", "Get a specific synthetic test by public ID");
    try get_synthetic_cmd.addArg(Arg.positional("PUBLIC_ID", "Synthetic test public identifier", null));
    try get_cmd.addSubcommand(get_synthetic_cmd);

    var get_signal_cmd = app.createCommand("signal", "Get a specific security signal by ID");
    try get_signal_cmd.addArg(Arg.positional("SIGNAL_ID", "Security signal identifier", null));
    try get_cmd.addSubcommand(get_signal_cmd);

    var get_finding_cmd = app.createCommand("finding", "Get a specific security finding by ID");
    try get_finding_cmd.addArg(Arg.positional("FINDING_ID", "Security finding identifier", null));
    try get_cmd.addSubcommand(get_finding_cmd);

    var get_pipeline_event_cmd = app.createCommand("pipeline-event", "Get a specific CI pipeline event by ID");
    try get_pipeline_event_cmd.addArg(Arg.positional("EVENT_ID", "CI pipeline event identifier", null));
    try get_cmd.addSubcommand(get_pipeline_event_cmd);

    var get_test_event_cmd = app.createCommand("test-event", "Get a specific CI test event by ID");
    try get_test_event_cmd.addArg(Arg.positional("EVENT_ID", "CI test event identifier", null));
    try get_cmd.addSubcommand(get_test_event_cmd);

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
        } else if (list_matches.subcommandMatches("incidents")) |*incidents_matches| {
            try list.handleIncidentsList(&ctx, incidents_matches);
        } else if (list_matches.subcommandMatches("dashboards")) |*dashboards_matches| {
            try list.handleDashboardsList(&ctx, dashboards_matches);
        } else if (list_matches.subcommandMatches("notebooks")) |*notebooks_matches| {
            try list.handleNotebooksList(&ctx, notebooks_matches);
        } else if (list_matches.subcommandMatches("rum")) |*rum_matches| {
            try list.handleRumSearch(&ctx, rum_matches);
        } else if (list_matches.subcommandMatches("errors")) |*errors_matches| {
            try list.handleErrorsList(&ctx, errors_matches);
        } else if (list_matches.subcommandMatches("signals")) |*signals_matches| {
            try list.handleSignalsList(&ctx, signals_matches);
        } else if (list_matches.subcommandMatches("findings")) |*findings_matches| {
            try list.handleFindingsList(&ctx, findings_matches);
        } else if (list_matches.subcommandMatches("pipelines")) |*pipelines_matches| {
            try list.handlePipelinesList(&ctx, pipelines_matches);
        } else if (list_matches.subcommandMatches("tests")) |*tests_matches| {
            try list.handleTestsList(&ctx, tests_matches);
        } else if (list_matches.subcommandMatches("synthetics")) |*synthetics_matches| {
            try list.handleSyntheticsList(&ctx, synthetics_matches);
        } else if (list_matches.subcommandMatches("devices")) |*devices_matches| {
            try list.handleDevicesList(&ctx, devices_matches);
        } else if (list_matches.subcommandMatches("cases")) |*cases_matches| {
            try list.handleCasesList(&ctx, cases_matches);
        } else if (list_matches.subcommandMatches("dependencies")) |*dependencies_matches| {
            try list.handleDependenciesList(&ctx, dependencies_matches);
        } else {
            std.debug.print("Error: Unknown list target. Use 'list logs', 'list hosts', 'list metrics', 'list apis', 'list services', 'list spans', 'list events', 'list monitors', 'list downtimes', 'list containers', 'list processes', 'list incidents', 'list dashboards', 'list notebooks', 'list rum', 'list errors', 'list signals', 'list findings', 'list pipelines', 'list tests', 'list synthetics', 'list devices', 'list cases', or 'list dependencies'\n", .{});
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
            std.debug.print("  dd-cli list incidents --state active\n", .{});
            std.debug.print("  dd-cli list dashboards \"prod\"\n", .{});
            std.debug.print("  dd-cli list rum --service web --from 1h\n", .{});
            std.debug.print("  dd-cli list errors --service api --from 1d\n", .{});
            std.debug.print("  dd-cli list signals --from 1h\n", .{});
            std.debug.print("  dd-cli list pipelines --service my-service --from 1d\n", .{});
            std.debug.print("  dd-cli list cases --state open --priority P1\n", .{});
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
        } else if (get_matches.subcommandMatches("incident")) |*incident_matches| {
            try get.handleIncidentGet(&ctx, incident_matches);
        } else if (get_matches.subcommandMatches("notebook")) |*notebook_matches| {
            try get.handleNotebookGet(&ctx, notebook_matches);
        } else if (get_matches.subcommandMatches("error")) |*error_matches| {
            try get.handleErrorGet(&ctx, error_matches);
        } else if (get_matches.subcommandMatches("device")) |*device_matches| {
            try get.handleDeviceGet(&ctx, device_matches);
        } else if (get_matches.subcommandMatches("case")) |*case_matches| {
            try get.handleCaseGet(&ctx, case_matches);
        } else if (get_matches.subcommandMatches("dashboard")) |*dashboard_matches| {
            try get.handleDashboardGet(&ctx, dashboard_matches);
        } else if (get_matches.subcommandMatches("synthetic")) |*synthetic_matches| {
            try get.handleSyntheticGet(&ctx, synthetic_matches);
        } else if (get_matches.subcommandMatches("signal")) |*signal_matches| {
            try get.handleSignalGet(&ctx, signal_matches);
        } else if (get_matches.subcommandMatches("finding")) |*finding_matches| {
            try get.handleFindingGet(&ctx, finding_matches);
        } else if (get_matches.subcommandMatches("pipeline-event")) |*pipeline_event_matches| {
            try get.handlePipelineEventGet(&ctx, pipeline_event_matches);
        } else if (get_matches.subcommandMatches("test-event")) |*test_event_matches| {
            try get.handleTestEventGet(&ctx, test_event_matches);
        } else {
            std.debug.print("Error: Unknown get target. Use 'get log', 'get host', 'get metrics', 'get api', 'get event', 'get monitor', 'get downtime', 'get incident', 'get notebook', 'get error', 'get device', 'get case', 'get dashboard', 'get synthetic', 'get signal', 'get finding', 'get pipeline-event', or 'get test-event'\n", .{});
            std.debug.print("\nExamples:\n", .{});
            std.debug.print("  dd-cli get host web-server-01\n", .{});
            std.debug.print("  dd-cli get metrics system.cpu.idle\n", .{});
            std.debug.print("  dd-cli get api <api-id>\n", .{});
            std.debug.print("  dd-cli get event <event-id>\n", .{});
            std.debug.print("  dd-cli get incident <incident-id>\n", .{});
            std.debug.print("  dd-cli get notebook <notebook-id>\n", .{});
            std.debug.print("  dd-cli get error <issue-id>\n", .{});
            std.debug.print("  dd-cli get device <device-id>\n", .{});
            std.debug.print("  dd-cli get case <case-id>\n", .{});
            return error.UnknownSubcommand;
        }
    } else if (matches.subcommandMatches("validate")) |*val_matches| {
        try validate.handleValidateCommand(&ctx, val_matches);
    } else if (matches.subcommandMatches("raw")) |*raw_matches| {
        try raw.handleRawCommand(&ctx, raw_matches);
    } else {
        std.debug.print("Error: No subcommand specified.\n", .{});
        std.debug.print("\nAvailable commands:\n", .{});
        std.debug.print("  list      - List resources (logs, hosts, metrics, apis, services, spans, events, monitors, downtimes, containers, processes, incidents, dashboards, notebooks, rum, errors, signals, findings, pipelines, tests, synthetics, devices, cases, dependencies)\n", .{});
        std.debug.print("  aggregate - Aggregate data (logs, metrics, spans, connections, dns)\n", .{});
        std.debug.print("  get       - Get specific resource by ID (log, host, metrics, api, event, monitor, downtime, incident, notebook, error, device, case, dashboard, synthetic, signal, finding, pipeline-event, test-event)\n", .{});
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
