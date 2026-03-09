const std = @import("std");

///////////////////////////////////////////
// Generated Zig structures from OpenAPI
///////////////////////////////////////////

pub const LogsDailyLimitReset = struct {
    reset_time: ?[]const u8 = null,
    reset_utc_offset: ?[]const u8 = null,
};

pub const MonitorOverallStates = struct {
};

pub const SearchServiceLevelObjective = struct {
    data: ?SearchServiceLevelObjectiveData = null,
};

pub const IPPrefixesAPM = struct {
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv6: ?[]const []const u8 = null,
};

pub const LogsArithmeticProcessorType = struct {
};

pub const MonitorSearchResponseCounts = struct {
    status: ?MonitorSearchCount = null,
    muted: ?MonitorSearchCount = null,
    tag: ?MonitorSearchCount = null,
    @"type": ?MonitorSearchCount = null,
};

pub const NumberFormatUnit = struct {
};

pub const HTTPLogError = struct {
    message: []const u8,
    code: i64,
};

pub const FormulaAndFunctionEventAggregation = struct {
};

pub const ResponseMetaAttributes = struct {
    page: ?Pagination = null,
};

pub const DistributionPointsContentEncoding = struct {
};

pub const LogsAttributeRemapper = struct {
    target_format: ?TargetFormatType = null,
    source_type: ?[]const u8 = null,
    target: []const u8,
    override_on_conflict: ?bool = null,
    is_enabled: ?bool = null,
    target_type: ?[]const u8 = null,
    name: ?[]const u8 = null,
    @"type": LogsAttributeRemapperType,
    preserve_source: ?bool = null,
    sources: []const []const u8,
};

pub const EventQueryDefinition = struct {
    search: []const u8,
    tags_execution: []const u8,
};

pub const MonitorFormulaAndFunctionDataQualityDataSource = struct {
};

pub const SplitGraphWidgetDefinition = struct {
    size: SplitGraphVizSize,
    source_widget_definition: SplitGraphSourceWidgetDefinition,
    has_uniform_y_axes: ?bool = null,
    time: ?WidgetTime = null,
    @"type": SplitGraphWidgetDefinitionType,
    split_config: SplitConfig,
    title: ?[]const u8 = null,
};

pub const UsageCWSHour = struct {
    cws_container_count: ?i64 = null,
    cws_host_count: ?i64 = null,
    hour: ?[]const u8 = null,
    org_name: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
};

pub const NotebookCellResponseAttributes = struct {
};

pub const SplitGraphWidgetDefinitionType = struct {
};

pub const NumberFormatUnitCustom = struct {
    label: ?[]const u8 = null,
    @"type": ?NumberFormatUnitCustomType = null,
};

pub const EventTimelineWidgetDefinition = struct {
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    time: ?WidgetTime = null,
    tags_execution: ?[]const u8 = null,
    query: []const u8,
    title: ?[]const u8 = null,
    @"type": EventTimelineWidgetDefinitionType,
};

pub const MonitorFormulaAndFunctionDataQualityMeasure = struct {
};

pub const SyntheticsAssertionTimingsScope = struct {
};

pub const AWSAccountCreateResponse = struct {
    external_id: ?[]const u8 = null,
};

pub const Event = struct {
    payload: ?[]const u8 = null,
    url: ?[]const u8 = null,
    id_str: ?[]const u8 = null,
    alert_type: ?EventAlertType = null,
    device_name: ?[]const u8 = null,
    id: ?i64 = null,
    tags: ?[]const []const u8 = null,
    host: ?[]const u8 = null,
    priority: ?EventPriority = null,
    source_type_name: ?[]const u8 = null,
    date_happened: ?i64 = null,
    text: ?[]const u8 = null,
    title: ?[]const u8 = null,
};

pub const LogQueryDefinitionSearch = struct {
    query: []const u8,
};

pub const LogsArrayProcessorOperationLengthType = struct {
};

pub const LogsSchemaCategoryMapperType = struct {
};

pub const SLOBulkDeleteResponse = struct {
    data: ?SLOBulkDeleteResponseData = null,
    errors: ?[]const std.json.Value = null,
};

pub const SLOCountDefinition = struct {
    total_events_formula: SLOFormula,
    good_events_formula: SLOFormula,
    queries: []const std.json.Value,
};

pub const SLOListWidgetDefinitionType = struct {
};

pub const NumberFormatUnitScaleType = struct {
};

pub const DashboardReflowType = struct {
};

pub const MonitorSearchResultNotification = struct {
    handle: ?[]const u8 = null,
    name: ?[]const u8 = null,
};

pub const ListStreamColumnWidth = struct {
};

pub const HostMapWidgetDefinitionType = struct {
};

pub const NotebooksResponseData = struct {
    id: i64,
    attributes: NotebooksResponseDataAttributes,
    @"type": NotebookResourceType,
};

pub const LogsFilter = struct {
    query: ?[]const u8 = null,
};

pub const LogsURLParser = struct {
    is_enabled: ?bool = null,
    normalize_ending_slashes: ?bool = null,
    name: ?[]const u8 = null,
    @"type": LogsURLParserType,
    target: []const u8,
    sources: []const []const u8,
};

pub const DashboardResourceType = struct {
};

pub const GCPAccountListResponse = struct {
};

pub const LogsMessageRemapper = struct {
    name: ?[]const u8 = null,
    @"type": LogsMessageRemapperType,
    is_enabled: ?bool = null,
    sources: []const []const u8,
};

pub const SyntheticsTestMonitorStatus = struct {
};

pub const NotebookStatus = struct {
};

pub const SLOType = struct {
};

pub const HostMeta = struct {
    macV: ?[]const []const u8 = null,
    cpuCores: ?i64 = null,
    gohai: ?[]const u8 = null,
    fbsdV: ?[]const []const u8 = null,
    pythonV: ?[]const u8 = null,
    nixV: ?[]const []const u8 = null,
    machine: ?[]const u8 = null,
    processor: ?[]const u8 = null,
    @"socket-fqdn": ?[]const u8 = null,
    @"socket-hostname": ?[]const u8 = null,
    agent_checks: ?[]const std.json.Value = null,
    agent_version: ?[]const u8 = null,
    winV: ?[]const []const u8 = null,
    install_method: ?HostMetaInstallMethod = null,
    platform: ?[]const u8 = null,
};

pub const SLOHistoryResponseData = struct {
    groups: ?[]const std.json.Value = null,
    from_ts: ?i64 = null,
    group_by: ?[]const []const u8 = null,
    series: ?SLOHistoryMetrics = null,
    monitors: ?[]const std.json.Value = null,
    overall: ?SLOHistorySLIData = null,
    thresholds: ?std.json.Value = null,
    type_id: ?SLOTypeNumeric = null,
    @"type": ?SLOType = null,
    to_ts: ?i64 = null,
};

pub const WidgetLiveSpan = struct {
};

pub const LogsGrokParserType = struct {
};

pub const WidgetTickEdge = struct {
};

pub const ImageWidgetDefinition = struct {
    margin: ?WidgetMargin = null,
    has_border: ?bool = null,
    url: []const u8,
    has_background: ?bool = null,
    horizontal_align: ?WidgetHorizontalAlign = null,
    url_dark_theme: ?[]const u8 = null,
    @"type": ImageWidgetDefinitionType,
    vertical_align: ?WidgetVerticalAlign = null,
    sizing: ?WidgetImageSizing = null,
};

pub const NotebookTimeseriesCellAttributes = struct {
    graph_size: ?NotebookGraphSize = null,
    split_by: ?NotebookSplitBy = null,
    time: ?NotebookCellTime = null,
    definition: TimeseriesWidgetDefinition,
};

pub const SyntheticsGlobalVariableParserType = struct {
};

pub const QuerySortOrder = struct {
};

pub const LogsByRetentionOrgUsage = struct {
    usage: ?[]const std.json.Value = null,
};

pub const MonitorFormulaAndFunctionEventQueryDefinitionCompute = struct {
    interval: ?i64 = null,
    aggregation: MonitorFormulaAndFunctionEventAggregation,
    metric: ?[]const u8 = null,
};

pub const NotebookGlobalTime = struct {
};

pub const SyntheticsDeletedTest = struct {
    deleted_at: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
};

pub const SyntheticsAssertionJSONSchemaOperator = struct {
};

pub const SyntheticsAssertionJSONPathOperator = struct {
};

pub const UsageRumUnitsResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const HeatMapWidgetDefinitionType = struct {
};

pub const SLOCorrectionListResponse = struct {
    data: ?[]const std.json.Value = null,
    meta: ?ResponseMetaAttributes = null,
};

pub const TreeMapSizeBy = struct {
};

pub const SyntheticsTestOptionsMonitorOptionsNotificationPresetName = struct {
};

pub const UsageSpecifiedCustomReportsAttributes = struct {
    size: ?i64 = null,
    end_date: ?[]const u8 = null,
    start_date: ?[]const u8 = null,
    location: ?[]const u8 = null,
    tags: ?[]const []const u8 = null,
    computed_on: ?[]const u8 = null,
};

pub const SyntheticsAssertion = struct {
};

pub const FunnelRequestType = struct {
};

pub const DashboardID = struct {
};

pub const LogsIndexesOrder = struct {
    index_names: []const []const u8,
};

pub const BarChartWidgetStackedType = struct {
};

pub const GraphSnapshot = struct {
    metric_query: ?[]const u8 = null,
    snapshot_url: ?[]const u8 = null,
    graph_def: ?[]const u8 = null,
};

pub const NotebookSplitBy = struct {
    keys: []const []const u8,
    tags: []const []const u8,
};

pub const FormulaAndFunctionApmResourceStatsQueryDefinition = struct {
    data_source: FormulaAndFunctionApmResourceStatsDataSource,
    cross_org_uuids: ?CrossOrgUuids = null,
    group_by: ?[]const []const u8 = null,
    operation_name: ?[]const u8 = null,
    primary_tag_value: ?[]const u8 = null,
    service: []const u8,
    stat: FormulaAndFunctionApmResourceStatName,
    resource_name: ?[]const u8 = null,
    name: []const u8,
    env: []const u8,
    primary_tag_name: ?[]const u8 = null,
};

pub const SyntheticsPlayingTab = struct {
};

pub const ToplistWidgetFlatType = struct {
};

pub const UsageAnalyzedLogsResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const LogsCategoryProcessorCategory = struct {
    name: ?[]const u8 = null,
    filter: ?LogsFilter = null,
};

pub const LogsDecoderProcessorBinaryToTextEncoding = struct {
};

pub const SplitVectorEntry = struct {
};

pub const WidgetConditionalFormat = struct {
    hide_value: ?bool = null,
    image_url: ?[]const u8 = null,
    custom_bg_color: ?[]const u8 = null,
    custom_fg_color: ?[]const u8 = null,
    palette: WidgetPalette,
    timeframe: ?[]const u8 = null,
    value: f64,
    comparator: WidgetComparator,
    metric: ?[]const u8 = null,
};

pub const WebhooksIntegration = struct {
    payload: ?[]const u8 = null,
    custom_headers: ?[]const u8 = null,
    url: []const u8,
    encode_as: ?WebhooksIntegrationEncoding = null,
    name: []const u8,
};

pub const SyntheticsMobileTestConfig = struct {
    initialApplicationArguments: ?SyntheticsMobileTestInitialApplicationArguments = null,
    variables: ?[]const std.json.Value = null,
};

pub const UsageLogsByIndexHour = struct {
    hour: ?[]const u8 = null,
    index_id: ?[]const u8 = null,
    index_name: ?[]const u8 = null,
    org_name: ?[]const u8 = null,
    retention: ?i64 = null,
    public_id: ?[]const u8 = null,
    event_count: ?i64 = null,
};

pub const TableWidgetTextFormatReplaceAllType = struct {
};

pub const WidgetHorizontalAlign = struct {
};

pub const SyntheticsTestRequestBodyFile = struct {
    size: ?i64 = null,
    content: ?[]const u8 = null,
    name: ?[]const u8 = null,
    @"type": ?[]const u8 = null,
    bucketKey: ?[]const u8 = null,
    originalFileName: ?[]const u8 = null,
};

pub const EventPriority = struct {
};

pub const SplitDimension = struct {
    one_graph_per: []const u8,
};

pub const LogsIndex = struct {
    daily_limit_warning_threshold_percentage: ?f64 = null,
    daily_limit_reset: ?LogsDailyLimitReset = null,
    is_rate_limited: ?bool = null,
    tags: ?[]const []const u8 = null,
    exclusion_filters: ?[]const std.json.Value = null,
    filter: LogsFilter,
    daily_limit: ?i64 = null,
    num_flex_logs_retention_days: ?i64 = null,
    name: []const u8,
    num_retention_days: ?i64 = null,
};

pub const SyntheticsMobileStepParamsPositions = struct {
};

pub const MetricsListResponse = struct {
    from: ?[]const u8 = null,
    metrics: ?[]const []const u8 = null,
};

pub const IPPrefixesRemoteConfiguration = struct {
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv6: ?[]const []const u8 = null,
};

pub const SyntheticsCITest = struct {
    followRedirects: ?bool = null,
    body: ?[]const u8 = null,
    version: ?i64 = null,
    locations: ?[]const []const u8 = null,
    variables: ?std.json.Value = null,
    cookies: ?[]const u8 = null,
    headers: ?SyntheticsTestHeaders = null,
    startUrl: ?[]const u8 = null,
    deviceIds: ?[]const std.json.Value = null,
    retry: ?SyntheticsTestOptionsRetry = null,
    metadata: ?SyntheticsCIBatchMetadata = null,
    public_id: []const u8,
    basicAuth: ?SyntheticsBasicAuth = null,
    allowInsecureCertificates: ?bool = null,
    bodyType: ?[]const u8 = null,
};

pub const HostMetrics = struct {
    cpu: ?f64 = null,
    load: ?f64 = null,
    iowait: ?f64 = null,
};

pub const SyntheticsCIBatchMetadataPipeline = struct {
    url: ?[]const u8 = null,
};

pub const SplitVectorEntryItem = struct {
    tag_values: []const []const u8,
    tag_key: []const u8,
};

pub const AzureAccount = struct {
    metrics_enabled: ?bool = null,
    tenant_name: ?[]const u8 = null,
    custom_metrics_enabled: ?bool = null,
    client_id: ?[]const u8 = null,
    errors: ?[]const []const u8 = null,
    new_tenant_name: ?[]const u8 = null,
    client_secret: ?[]const u8 = null,
    host_filters: ?[]const u8 = null,
    metrics_enabled_default: ?bool = null,
    app_service_plan_filters: ?[]const u8 = null,
    usage_metrics_enabled: ?bool = null,
    container_app_filters: ?[]const u8 = null,
    automute: ?bool = null,
    cspm_enabled: ?bool = null,
    new_client_id: ?[]const u8 = null,
    resource_collection_enabled: ?bool = null,
    resource_provider_configs: ?[]const std.json.Value = null,
};

pub const FunnelWidgetDefinition = struct {
    time: ?WidgetTime = null,
    title_align: ?WidgetTextAlign = null,
    requests: []const std.json.Value,
    @"type": FunnelWidgetDefinitionType,
    title_size: ?[]const u8 = null,
    title: ?[]const u8 = null,
};

pub const SyntheticsCIBatchMetadataCI = struct {
    pipeline: ?SyntheticsCIBatchMetadataPipeline = null,
    provider: ?SyntheticsCIBatchMetadataProvider = null,
};

pub const LogsURLParserType = struct {
};

pub const IdpResponse = struct {
    message: []const u8,
};

pub const LogsGeoIPParser = struct {
    sources: []const []const u8,
    name: ?[]const u8 = null,
    @"type": LogsGeoIPParserType,
    target: []const u8,
    is_enabled: ?bool = null,
};

pub const SyntheticsTestHeaders = struct {
};

pub const OrganizationListResponse = struct {
    orgs: ?[]const std.json.Value = null,
};

pub const FormulaAndFunctionEventQueryGroupBy = struct {
    limit: ?i64 = null,
    facet: []const u8,
    sort: ?FormulaAndFunctionEventQueryGroupBySort = null,
};

pub const ScatterplotDimension = struct {
};

pub const HostMapRequest = struct {
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?LogQueryDefinition = null,
    q: ?[]const u8 = null,
};

pub const SLOCorrectionCreateRequest = struct {
    data: ?SLOCorrectionCreateData = null,
};

pub const SyntheticsMobileStepParamsElementUserLocator = struct {
    values: ?[]const std.json.Value = null,
    failTestOnCannotLocate: ?bool = null,
};

pub const SyntheticsGlobalVariableRequest = struct {
    tags: []const []const u8,
    parse_test_options: ?SyntheticsGlobalVariableParseTestOptions = null,
    is_fido: ?bool = null,
    parse_test_public_id: ?[]const u8 = null,
    value: ?SyntheticsGlobalVariableValue = null,
    description: []const u8,
    is_totp: ?bool = null,
    id: ?[]const u8 = null,
    attributes: ?SyntheticsGlobalVariableAttributes = null,
    name: []const u8,
};

pub const ApiKeyListResponse = struct {
    api_keys: ?[]const std.json.Value = null,
};

pub const MonitorSearchResponse = struct {
    metadata: ?MonitorSearchResponseMetadata = null,
    counts: ?MonitorSearchResponseCounts = null,
    monitors: ?[]const std.json.Value = null,
};

pub const ReferenceTableLogsLookupProcessor = struct {
    source: []const u8,
    lookup_enrichment_table: []const u8,
    name: ?[]const u8 = null,
    target: []const u8,
    is_enabled: ?bool = null,
    @"type": LogsLookupProcessorType,
};

pub const SyntheticsAPITestResultFull = struct {
    result: ?SyntheticsAPITestResultData = null,
    check_version: ?i64 = null,
    status: ?SyntheticsTestMonitorStatus = null,
    check: ?SyntheticsAPITestResultFullCheck = null,
    result_id: ?[]const u8 = null,
    probe_dc: ?[]const u8 = null,
    check_time: ?f64 = null,
};

pub const MetricsQueryMetadata = struct {
    tag_set: ?[]const []const u8 = null,
    metric: ?[]const u8 = null,
    aggr: ?[]const u8 = null,
    display_name: ?[]const u8 = null,
    interval: ?i64 = null,
    start: ?i64 = null,
    expression: ?[]const u8 = null,
    end: ?i64 = null,
    unit: ?[]const std.json.Value = null,
    scope: ?[]const u8 = null,
    query_index: ?i64 = null,
    pointlist: ?[]const std.json.Value = null,
    length: ?i64 = null,
};

pub const NotebookResponseData = struct {
    id: i64,
    attributes: NotebookResponseDataAttributes,
    @"type": NotebookResourceType,
};

pub const LogsSchemaCategoryMapperFallback = struct {
    values: ?std.json.Value = null,
    sources: ?std.json.Value = null,
};

pub const SyntheticsMobileStepParamsValueString = struct {
};

pub const SyntheticsCITestBody = struct {
    tests: ?[]const std.json.Value = null,
};

pub const UsageSDSHour = struct {
    hour: ?[]const u8 = null,
    apm_scanned_bytes: ?i64 = null,
    events_scanned_bytes: ?i64 = null,
    org_name: ?[]const u8 = null,
    rum_scanned_bytes: ?i64 = null,
    logs_scanned_bytes: ?i64 = null,
    public_id: ?[]const u8 = null,
    total_scanned_bytes: ?i64 = null,
};

pub const UsageRumUnitsHour = struct {
    org_name: ?[]const u8 = null,
    mobile_rum_units: ?i64 = null,
    browser_rum_units: ?i64 = null,
    public_id: ?[]const u8 = null,
    rum_units: ?i64 = null,
};

pub const CancelDowntimesByScopeRequest = struct {
    scope: []const u8,
};

pub const SharedDashboard = struct {
    dashboard_type: DashboardType,
    token: ?[]const u8 = null,
    invitees: ?[]const std.json.Value = null,
    embeddable_domains: ?[]const []const u8 = null,
    global_time_selectable_enabled: ?bool = null,
    selectable_template_vars: ?[]const std.json.Value = null,
    share_type: ?DashboardShareType = null,
    status: ?SharedDashboardStatus = null,
    author: ?SharedDashboardAuthor = null,
    dashboard_id: []const u8,
    last_accessed: ?[]const u8 = null,
    viewing_preferences: ?ViewingPreferences = null,
    expiration: ?[]const u8 = null,
    global_time: ?DashboardGlobalTime = null,
    public_url: ?[]const u8 = null,
    share_list: ?[]const []const u8 = null,
    created: ?[]const u8 = null,
    title: ?[]const u8 = null,
};

pub const SyntheticsWarningType = struct {
};

pub const FormulaAndFunctionApmResourceStatsDataSource = struct {
};

pub const UserDisableResponse = struct {
    message: ?[]const u8 = null,
};

pub const MetricContentEncoding = struct {
};

pub const AWSLogsServicesRequest = struct {
    account_id: []const u8,
    services: []const []const u8,
};

pub const LogStreamWidgetDefinitionType = struct {
};

pub const LogsLookupProcessor = struct {
    target: []const u8,
    is_enabled: ?bool = null,
    default_lookup: ?[]const u8 = null,
    source: []const u8,
    name: ?[]const u8 = null,
    lookup_table: []const []const u8,
    @"type": LogsLookupProcessorType,
};

pub const LogsGrokParser = struct {
    source: []const u8,
    samples: ?[]const []const u8 = null,
    grok: LogsGrokParserRules,
    @"type": LogsGrokParserType,
    name: ?[]const u8 = null,
    is_enabled: ?bool = null,
};

pub const AWSEventBridgeDeleteStatus = struct {
};

pub const HourlyUsageAttributionUsageType = struct {
};

pub const MonitorOptionsCustomScheduleRecurrence = struct {
    rrule: ?[]const u8 = null,
    start: ?[]const u8 = null,
    timezone: ?[]const u8 = null,
};

pub const NotebookMarkdownCellDefinition = struct {
    text: []const u8,
    @"type": NotebookMarkdownCellDefinitionType,
};

pub const SyntheticsTestMetadata = struct {
};

pub const ToplistWidgetStackedType = struct {
};

pub const UsageSyntheticsBrowserResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const WidgetFormulaCellDisplayModeOptions = struct {
    y_scale: ?WidgetFormulaCellDisplayModeOptionsYScale = null,
    trend_type: ?WidgetFormulaCellDisplayModeOptionsTrendType = null,
};

pub const WidgetOrderBy = struct {
};

pub const LogQueryDefinitionGroupBySort = struct {
    order: WidgetSort,
    aggregation: []const u8,
    facet: ?[]const u8 = null,
};

pub const UsageIncidentManagementHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    monthly_active_users: ?i64 = null,
    public_id: ?[]const u8 = null,
};

pub const HTTPLogItem = struct {
    ddtags: ?[]const u8 = null,
    ddsource: ?[]const u8 = null,
    service: ?[]const u8 = null,
    message: []const u8,
    hostname: ?[]const u8 = null,
};

pub const NotifyEndTypes = struct {
};

pub const LogsRetentionAggSumUsage = struct {
    logs_indexed_logs_usage_agg_sum: ?i64 = null,
    retention: ?[]const u8 = null,
    logs_live_indexed_logs_usage_agg_sum: ?i64 = null,
    logs_rehydrated_indexed_logs_usage_agg_sum: ?i64 = null,
};

pub const DashboardTemplateVariablePresetValue = struct {
    value: ?[]const u8 = null,
    values: ?[]const []const u8 = null,
    name: ?[]const u8 = null,
};

pub const NotebookCreateData = struct {
    attributes: NotebookCreateDataAttributes,
    @"type": NotebookResourceType,
};

pub const SharedDashboardInvitesMetaPage = struct {
    total_count: ?i64 = null,
};

pub const WidgetChangeType = struct {
};

pub const DowntimeRecurrence = struct {
    week_days: ?[]const []const u8 = null,
    period: ?i64 = null,
    until_date: ?i64 = null,
    rrule: ?[]const u8 = null,
    @"type": ?[]const u8 = null,
    until_occurrences: ?i64 = null,
};

pub const SLOCreator = struct {
    id: ?i64 = null,
    email: ?[]const u8 = null,
    name: ?[]const u8 = null,
};

pub const SyntheticsApiTestResultFailure = struct {
    message: ?[]const u8 = null,
    code: ?SyntheticsApiTestFailureCode = null,
};

pub const ImageWidgetDefinitionType = struct {
};

pub const PagerDutyServiceName = struct {
    service_name: []const u8,
};

pub const SyntheticsBrowserVariableType = struct {
};

pub const SyntheticsTestDetails = struct {
    steps: ?[]const std.json.Value = null,
    monitor_id: ?i64 = null,
    locations: ?[]const []const u8 = null,
    status: ?SyntheticsTestPauseStatus = null,
    creator: ?Creator = null,
    config: ?SyntheticsTestConfig = null,
    subtype: ?SyntheticsTestDetailsSubType = null,
    options: ?SyntheticsTestOptions = null,
    tags: ?[]const []const u8 = null,
    public_id: ?[]const u8 = null,
    message: ?[]const u8 = null,
    name: ?[]const u8 = null,
    @"type": ?SyntheticsTestDetailsType = null,
};

pub const DashboardGlobalTimeLiveSpan = struct {
};

pub const WidgetFormulaCellDisplayModeOptionsTrendType = struct {
};

pub const SLOHistorySLIData = struct {
    error_budget_remaining: ?SLOErrorBudgetRemainingData = null,
    group: ?[]const u8 = null,
    monitor_type: ?[]const u8 = null,
    errors: ?[]const std.json.Value = null,
    precision: ?std.json.Value = null,
    sli_value: ?f64 = null,
    uptime: ?f64 = null,
    span_precision: ?f64 = null,
    preview: ?bool = null,
    history: ?[]const std.json.Value = null,
    name: ?[]const u8 = null,
    monitor_modified: ?i64 = null,
};

pub const SyntheticsDeviceID = struct {
};

pub const ScatterplotWidgetAggregator = struct {
};

pub const SharedDashboardAuthor = struct {
    handle: ?[]const u8 = null,
    name: ?[]const u8 = null,
};

pub const NotebookCellResponse = struct {
    id: []const u8,
    attributes: NotebookCellResponseAttributes,
    @"type": NotebookCellResourceType,
};

pub const DashboardInviteType = struct {
};

pub const SLOListWidgetRequestType = struct {
};

pub const TableWidgetTextFormatReplaceAll = struct {
    with: []const u8,
    @"type": TableWidgetTextFormatReplaceAllType,
};

pub const SyntheticsSSLCertificateSubject = struct {
    OU: ?[]const u8 = null,
    C: ?[]const u8 = null,
    L: ?[]const u8 = null,
    ST: ?[]const u8 = null,
    O: ?[]const u8 = null,
    CN: ?[]const u8 = null,
    altName: ?[]const u8 = null,
};

pub const SLOCorrection = struct {
    id: ?[]const u8 = null,
    attributes: ?SLOCorrectionResponseAttributes = null,
    @"type": ?SLOCorrectionType = null,
};

pub const FunnelWidgetDefinitionType = struct {
};

pub const GroupWidgetDefinition = struct {
    banner_img: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    background_color: ?[]const u8 = null,
    show_title: ?bool = null,
    layout_type: WidgetLayoutType,
    @"type": GroupWidgetDefinitionType,
    title: ?[]const u8 = null,
    widgets: []const std.json.Value,
};

pub const FormulaAndFunctionResponseFormat = struct {
};

pub const WidgetLayout = struct {
    width: i64,
    x: i64,
    height: i64,
    is_column_break: ?bool = null,
    y: i64,
};

pub const ServiceMapWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    service: []const u8,
    filters: []const []const u8,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    @"type": ServiceMapWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const MonitorFormulaAndFunctionEventsDataSource = struct {
};

pub const UsageSort = struct {
};

pub const UsageLogsResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const SyntheticsBasicAuth = struct {
};

pub const AWSTagFilterDeleteRequest = struct {
    account_id: ?[]const u8 = null,
    namespace: ?AWSNamespace = null,
};

pub const LogsAPIErrorResponse = struct {
    @"error": ?LogsAPIError = null,
};

pub const MetricMetadata = struct {
    statsd_interval: ?i64 = null,
    per_unit: ?[]const u8 = null,
    short_name: ?[]const u8 = null,
    description: ?[]const u8 = null,
    integration: ?[]const u8 = null,
    @"type": ?[]const u8 = null,
    unit: ?[]const u8 = null,
};

pub const DeletedMonitor = struct {
    deleted_monitor_id: ?i64 = null,
};

pub const WidgetNewFixedSpan = struct {
    hide_incomplete_cost_data: ?bool = null,
    from: i64,
    to: i64,
    @"type": WidgetNewFixedSpanType,
};

pub const SyntheticsTestRequestCertificate = struct {
    cert: ?SyntheticsTestRequestCertificateItem = null,
    key: ?SyntheticsTestRequestCertificateItem = null,
};

pub const SyntheticsCIBatchMetadata = struct {
    ci: ?SyntheticsCIBatchMetadataCI = null,
    git: ?SyntheticsCIBatchMetadataGit = null,
};

pub const SyntheticsAPISubtestStep = struct {
    subtype: SyntheticsAPISubtestStepSubtype,
    isCritical: ?bool = null,
    alwaysExecute: ?bool = null,
    allowFailure: ?bool = null,
    exitIfSucceed: ?bool = null,
    retry: ?SyntheticsTestOptionsRetry = null,
    id: ?[]const u8 = null,
    name: []const u8,
    subtestPublicId: []const u8,
    extractedValuesFromScript: ?[]const u8 = null,
};

pub const OrganizationCreateBody = struct {
    subscription: ?OrganizationSubscription = null,
    billing: ?OrganizationBilling = null,
    name: []const u8,
};

pub const QueryValueWidgetDefinitionType = struct {
};

pub const SLOCorrectionResponseAttributesModifier = struct {
    handle: ?[]const u8 = null,
    email: ?[]const u8 = null,
    name: ?[]const u8 = null,
};

pub const IFrameWidgetDefinition = struct {
    url: []const u8,
    @"type": IFrameWidgetDefinitionType,
};

pub const MonitorDraftStatus = struct {
};

pub const DashboardSummaryDefinition = struct {
    created_at: ?[]const u8 = null,
    url: ?[]const u8 = null,
    is_read_only: ?bool = null,
    author_handle: ?[]const u8 = null,
    description: ?[]const u8 = null,
    layout_type: ?DashboardLayoutType = null,
    id: ?[]const u8 = null,
    modified_at: ?[]const u8 = null,
    title: ?[]const u8 = null,
};

pub const OnMissingDataOption = struct {
};

pub const NotebookLogStreamCellAttributes = struct {
    graph_size: ?NotebookGraphSize = null,
    time: ?NotebookCellTime = null,
    definition: LogStreamWidgetDefinition,
};

pub const BarChartWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    requests: []const std.json.Value,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    time: ?WidgetTime = null,
    style: ?BarChartWidgetStyle = null,
    @"type": BarChartWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const MonitorOptionsNotificationPresets = struct {
};

pub const ListStreamResponseFormat = struct {
};

pub const Host = struct {
    sources: ?[]const []const u8 = null,
    host_name: ?[]const u8 = null,
    apps: ?[]const []const u8 = null,
    mute_timeout: ?i64 = null,
    aws_name: ?[]const u8 = null,
    id: ?i64 = null,
    metrics: ?HostMetrics = null,
    tags_by_source: ?std.json.Value = null,
    is_muted: ?bool = null,
    up: ?bool = null,
    aliases: ?[]const []const u8 = null,
    name: ?[]const u8 = null,
    meta: ?HostMeta = null,
    last_reported_time: ?i64 = null,
};

pub const SLOCountSpec = struct {
    count: SLOCountDefinition,
};

pub const SyntheticsAssertionJSONSchemaTargetTarget = struct {
    jsonSchema: ?[]const u8 = null,
    metaSchema: ?SyntheticsAssertionJSONSchemaMetaSchema = null,
};

pub const FormulaAndFunctionProcessQueryDefinition = struct {
    data_source: FormulaAndFunctionProcessQueryDataSource,
    aggregator: ?FormulaAndFunctionMetricAggregation = null,
    cross_org_uuids: ?CrossOrgUuids = null,
    tag_filters: ?[]const []const u8 = null,
    is_normalized_cpu: ?bool = null,
    metric: []const u8,
    limit: ?i64 = null,
    text_filter: ?[]const u8 = null,
    name: []const u8,
    sort: ?QuerySortOrder = null,
};

pub const NoteWidgetDefinition = struct {
    tick_edge: ?WidgetTickEdge = null,
    content: []const u8,
    has_padding: ?bool = null,
    background_color: ?[]const u8 = null,
    text_align: ?WidgetTextAlign = null,
    tick_pos: ?[]const u8 = null,
    font_size: ?[]const u8 = null,
    vertical_align: ?WidgetVerticalAlign = null,
    show_tick: ?bool = null,
    @"type": NoteWidgetDefinitionType,
};

pub const HostMuteSettings = struct {
    override: ?bool = null,
    message: ?[]const u8 = null,
    end: ?i64 = null,
};

pub const SyntheticsBasicAuthOauthROPType = struct {
};

pub const NotebookUpdateCell = struct {
};

pub const OrganizationSettings = struct {
    saml_idp_endpoint: ?[]const u8 = null,
    saml_idp_metadata_uploaded: ?bool = null,
    saml: ?OrganizationSettingsSaml = null,
    saml_can_be_enabled: ?bool = null,
    saml_autocreate_users_domains: ?OrganizationSettingsSamlAutocreateUsersDomains = null,
    saml_autocreate_access_role: ?AccessRole = null,
    private_widget_share: ?bool = null,
    saml_idp_initiated_login: ?OrganizationSettingsSamlIdpInitiatedLogin = null,
    saml_login_url: ?[]const u8 = null,
    saml_strict_mode: ?OrganizationSettingsSamlStrictMode = null,
};

pub const SLOCorrectionCreateRequestAttributes = struct {
    duration: ?i64 = null,
    rrule: ?[]const u8 = null,
    timezone: ?[]const u8 = null,
    description: ?[]const u8 = null,
    category: SLOCorrectionCategory,
    slo_id: []const u8,
    start: i64,
    end: ?i64 = null,
};

pub const SyntheticsBasicAuthSigv4Type = struct {
};

pub const MonitorThresholdWindowOptions = struct {
    trigger_window: ?[]const u8 = null,
    recovery_window: ?[]const u8 = null,
};

pub const TimeseriesWidgetExpressionAlias = struct {
    alias_name: ?[]const u8 = null,
    expression: []const u8,
};

pub const SyntheticsTestOptionsScheduling = struct {
    timezone: []const u8,
    timeframes: []const std.json.Value,
};

pub const DashboardLayoutType = struct {
};

pub const SunburstWidgetLegendInlineAutomatic = struct {
    hide_value: ?bool = null,
    @"type": SunburstWidgetLegendInlineAutomaticType,
    hide_percent: ?bool = null,
};

pub const ToplistWidgetStacked = struct {
    legend: ?ToplistWidgetLegend = null,
    @"type": ToplistWidgetStackedType,
};

pub const WebhooksIntegrationCustomVariableUpdateRequest = struct {
    is_secret: ?bool = null,
    value: ?[]const u8 = null,
    name: ?[]const u8 = null,
};

pub const EventListResponse = struct {
    status: ?[]const u8 = null,
    events: ?[]const std.json.Value = null,
};

pub const DashboardSummary = struct {
    dashboards: ?[]const std.json.Value = null,
};

pub const SyntheticsAssertionJavascript = struct {
    @"type": SyntheticsAssertionJavascriptType,
    code: []const u8,
};

pub const TableWidgetTextFormatMatchType = struct {
};

pub const AddSignalToIncidentRequest = struct {
    add_to_signal_timeline: ?bool = null,
    version: ?Version = null,
    incident_id: i64,
};

pub const MonitorFormulaAndFunctionEventQueryGroupBySort = struct {
    order: ?QuerySortOrder = null,
    aggregation: MonitorFormulaAndFunctionEventAggregation,
    metric: ?[]const u8 = null,
};

pub const SharedDashboardStatus = struct {
};

pub const UsageOnlineArchiveResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const NotebookHeatMapCellAttributes = struct {
    graph_size: ?NotebookGraphSize = null,
    split_by: ?NotebookSplitBy = null,
    time: ?NotebookCellTime = null,
    definition: HeatMapWidgetDefinition,
};

pub const SLOHistoryMetrics = struct {
    res_type: []const u8,
    times: []const f64,
    numerator: SLOHistoryMetricsSeries,
    interval: i64,
    denominator: SLOHistoryMetricsSeries,
    message: ?[]const u8 = null,
    query: []const u8,
    resp_version: i64,
};

pub const NotebookCellTime = struct {
};

pub const ApmStatsQueryDefinition = struct {
    columns: ?[]const std.json.Value = null,
    primary_tag: []const u8,
    service: []const u8,
    resource: ?[]const u8 = null,
    name: []const u8,
    env: []const u8,
    row_type: ApmStatsQueryRowType,
};

pub const LogsDecoderProcessor = struct {
    input_representation: LogsDecoderProcessorInputRepresentation,
    target: []const u8,
    is_enabled: ?bool = null,
    source: []const u8,
    binary_to_text_encoding: LogsDecoderProcessorBinaryToTextEncoding,
    name: ?[]const u8 = null,
    @"type": LogsDecoderProcessorType,
};

pub const SyntheticsStepDetailWarning = struct {
    message: []const u8,
    @"type": SyntheticsWarningType,
};

pub const MonitorAssetResourceType = struct {
};

pub const MonitorSearchResult = struct {
    last_triggered_ts: ?i64 = null,
    quality_issues: ?[]const []const u8 = null,
    scopes: ?[]const []const u8 = null,
    notifications: ?[]const std.json.Value = null,
    status: ?MonitorOverallStates = null,
    creator: ?Creator = null,
    id: ?i64 = null,
    metrics: ?[]const []const u8 = null,
    tags: ?[]const []const u8 = null,
    org_id: ?i64 = null,
    classification: ?[]const u8 = null,
    name: ?[]const u8 = null,
    query: ?[]const u8 = null,
    @"type": ?MonitorType = null,
};

pub const NumberFormatUnitCustomType = struct {
};

pub const FormulaAndFunctionEventQueryDefinition = struct {
    data_source: FormulaAndFunctionEventsDataSource,
    cross_org_uuids: ?CrossOrgUuids = null,
    group_by: ?[]const std.json.Value = null,
    search: ?FormulaAndFunctionEventQueryDefinitionSearch = null,
    storage: ?[]const u8 = null,
    name: []const u8,
    indexes: ?[]const []const u8 = null,
    compute: FormulaAndFunctionEventQueryDefinitionCompute,
};

pub const SyntheticsAssertionTargetValue = struct {
};

pub const ServiceCheck = struct {
    status: ServiceCheckStatus,
    tags: []const []const u8,
    check: []const u8,
    timestamp: ?i64 = null,
    host_name: []const u8,
    message: ?[]const u8 = null,
};

pub const SyntheticsTestConfig = struct {
    configVariables: ?[]const std.json.Value = null,
    variables: ?[]const std.json.Value = null,
    request: ?SyntheticsTestRequest = null,
    assertions: ?[]const std.json.Value = null,
};

pub const ListStreamComputeItems = struct {
    aggregation: ListStreamComputeAggregation,
    facet: ?[]const u8 = null,
};

pub const LogsArrayProcessorOperationAppend = struct {
    source: []const u8,
    target: []const u8,
    preserve_source: ?bool = null,
    @"type": LogsArrayProcessorOperationAppendType,
};

pub const HourlyUsageAttributionResponse = struct {
    usage: ?[]const std.json.Value = null,
    metadata: ?HourlyUsageAttributionMetadata = null,
};

pub const NumberFormatUnitScale = struct {
    unit_name: ?[]const u8 = null,
    @"type": ?NumberFormatUnitScaleType = null,
};

pub const SLOCorrectionResponse = struct {
    data: ?SLOCorrection = null,
};

pub const SyntheticsTestProcessStatus = struct {
};

pub const SyntheticsTestRequestNumericalPort = struct {
};

pub const SyntheticsMobileTestsMobileApplication = struct {
    referenceId: []const u8,
    applicationId: []const u8,
    referenceType: SyntheticsMobileTestsMobileApplicationReferenceType,
};

pub const ScatterPlotWidgetDefinitionRequests = struct {
    x: ?ScatterPlotRequest = null,
    table: ?ScatterplotTableRequest = null,
    y: ?ScatterPlotRequest = null,
};

pub const MonitorGroupSearchResult = struct {
    last_triggered_ts: ?i64 = null,
    group: ?[]const u8 = null,
    monitor_id: ?i64 = null,
    monitor_name: ?[]const u8 = null,
    group_tags: ?[]const []const u8 = null,
    status: ?MonitorOverallStates = null,
    last_nodata_ts: ?i64 = null,
};

pub const SearchServiceLevelObjectiveAttributes = struct {
    created_at: ?i64 = null,
    slo_type: ?SLOType = null,
    all_tags: ?[]const []const u8 = null,
    status: ?SLOStatus = null,
    creator: ?SLOCreator = null,
    overall_status: ?[]const std.json.Value = null,
    modified_at: ?i64 = null,
    service_tags: ?[]const []const u8 = null,
    groups: ?[]const []const u8 = null,
    env_tags: ?[]const []const u8 = null,
    thresholds: ?[]const std.json.Value = null,
    description: ?[]const u8 = null,
    monitor_ids: ?[]const i64 = null,
    name: ?[]const u8 = null,
    query: ?SearchSLOQuery = null,
    team_tags: ?[]const []const u8 = null,
};

pub const DashboardRestoreRequest = struct {
    data: DashboardBulkActionDataList,
};

pub const SyntheticsAPITestConfig = struct {
    configVariables: ?[]const std.json.Value = null,
    steps: ?[]const std.json.Value = null,
    variablesFromScript: ?[]const u8 = null,
    request: ?SyntheticsTestRequest = null,
    assertions: ?[]const std.json.Value = null,
};

pub const SyntheticsBasicAuthNTLMType = struct {
};

pub const UsageRumSessionsResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const SyntheticsCoreWebVitals = struct {
    lcp: ?f64 = null,
    url: ?[]const u8 = null,
    cls: ?f64 = null,
};

pub const WidgetGrouping = struct {
};

pub const NotebookCellResourceType = struct {
};

pub const FormulaAndFunctionMetricDataSource = struct {
};

pub const NotebookUpdateRequest = struct {
    data: NotebookUpdateData,
};

pub const FormulaAndFunctionSLOMeasure = struct {
};

pub const ToplistWidgetDisplay = struct {
};

pub const SyntheticsAssertionBodyHashOperator = struct {
};

pub const UsageNetworkFlowsResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const WebhooksIntegrationUpdateRequest = struct {
    payload: ?[]const u8 = null,
    custom_headers: ?[]const u8 = null,
    url: ?[]const u8 = null,
    encode_as: ?WebhooksIntegrationEncoding = null,
    name: ?[]const u8 = null,
};

pub const SyntheticsVariableParser = struct {
    value: ?[]const u8 = null,
    @"type": SyntheticsGlobalVariableParserType,
};

pub const SLOListWidgetQuery = struct {
    limit: ?i64 = null,
    query_string: []const u8,
    sort: ?[]const std.json.Value = null,
};

pub const User = struct {
    disabled: ?bool = null,
    icon: ?[]const u8 = null,
    handle: ?[]const u8 = null,
    email: ?[]const u8 = null,
    verified: ?bool = null,
    access_role: ?AccessRole = null,
    name: ?[]const u8 = null,
};

pub const WidgetNewFixedSpanType = struct {
};

pub const FunnelWidgetRequest = struct {
    query: FunnelQuery,
    request_type: FunnelRequestType,
};

pub const LogsListRequest = struct {
    limit: ?i64 = null,
    time: LogsListRequestTime,
    startAt: ?[]const u8 = null,
    index: ?[]const u8 = null,
    query: ?[]const u8 = null,
    sort: ?LogsSort = null,
};

pub const SyntheticsRestrictedRoles = struct {
};

pub const TimeseriesWidgetRequest = struct {
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    display_type: ?WidgetDisplayType = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?LogQueryDefinition = null,
    formulas: ?[]const std.json.Value = null,
    style: ?WidgetRequestStyle = null,
    q: ?[]const u8 = null,
    audit_query: ?LogQueryDefinition = null,
    queries: ?[]const std.json.Value = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
    metadata: ?[]const std.json.Value = null,
    on_right_yaxis: ?bool = null,
};

pub const WidgetColorPreference = struct {
};

pub const LogsMessageRemapperType = struct {
};

pub const LogsByRetentionMonthlyUsage = struct {
    date: ?[]const u8 = null,
    usage: ?[]const std.json.Value = null,
};

pub const ServiceSummaryWidgetDefinitionType = struct {
};

pub const SyntheticsDefaultLocations = struct {
};

pub const NotebookMetadataType = struct {
};

pub const SlackIntegrationChannels = struct {
};

pub const AWSEventBridgeAccountConfiguration = struct {
    accountId: ?[]const u8 = null,
    eventHubs: ?[]const std.json.Value = null,
    tags: ?[]const []const u8 = null,
};

pub const MatchingDowntime = struct {
    scope: ?[]const []const u8 = null,
    id: i64,
    start: ?i64 = null,
    end: ?i64 = null,
};

pub const SLOWidgetDefinition = struct {
    global_time_target: ?[]const u8 = null,
    additional_query_filters: ?[]const u8 = null,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    show_error_budget: ?bool = null,
    time_windows: ?[]const std.json.Value = null,
    view_mode: ?WidgetViewMode = null,
    slo_id: ?[]const u8 = null,
    @"type": SLOWidgetDefinitionType,
    title: ?[]const u8 = null,
    view_type: []const u8,
};

pub const SyntheticsTestRestrictionPolicyBindingRelation = struct {
};

pub const UsageLogsByIndexResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const BarChartWidgetScaling = struct {
};

pub const SLOCorrectionCreateData = struct {
    attributes: ?SLOCorrectionCreateRequestAttributes = null,
    @"type": SLOCorrectionType,
};

pub const WidgetLegacyLiveSpan = struct {
    hide_incomplete_cost_data: ?bool = null,
    live_span: ?WidgetLiveSpan = null,
};

pub const ApiKeyResponse = struct {
    api_key: ?ApiKey = null,
};

pub const WidgetSortBy = struct {
    order_by: ?[]const std.json.Value = null,
    count: ?i64 = null,
};

pub const DashboardBulkActionData = struct {
    id: DashboardID,
    @"type": DashboardResourceType,
};

pub const SLOHistoryMetricsSeriesMetadataUnit = struct {
    scale_factor: ?f64 = null,
    plural: ?[]const u8 = null,
    id: ?i64 = null,
    name: ?[]const u8 = null,
    family: ?[]const u8 = null,
    short_name: ?[]const u8 = null,
};

pub const SyntheticsMobileStepParamsPositionsItems = struct {
    x: ?f64 = null,
    y: ?f64 = null,
};

pub const SLOTimeSliceComparator = struct {
};

pub const ListStreamWidgetRequest = struct {
    columns: []const std.json.Value,
    response_format: ListStreamResponseFormat,
    query: ListStreamQuery,
};

pub const LogsIndexUpdateRequest = struct {
    daily_limit_warning_threshold_percentage: ?f64 = null,
    daily_limit_reset: ?LogsDailyLimitReset = null,
    tags: ?[]const []const u8 = null,
    filter: LogsFilter,
    exclusion_filters: ?[]const std.json.Value = null,
    daily_limit: ?i64 = null,
    disable_daily_limit: ?bool = null,
    num_flex_logs_retention_days: ?i64 = null,
    num_retention_days: ?i64 = null,
};

pub const SyntheticsStep = struct {
    isCritical: ?bool = null,
    alwaysExecute: ?bool = null,
    timeout: ?i64 = null,
    params: ?std.json.Value = null,
    allowFailure: ?bool = null,
    exitIfSucceed: ?bool = null,
    noScreenshot: ?bool = null,
    name: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    @"type": ?SyntheticsStepType = null,
};

pub const OrganizationSettingsSamlIdpInitiatedLogin = struct {
    enabled: ?bool = null,
};

pub const SyntheticsBrowserTestResultFailure = struct {
    message: ?[]const u8 = null,
    code: ?SyntheticsBrowserTestFailureCode = null,
};

pub const FormulaAndFunctionEventQueryGroupBySort = struct {
    order: ?QuerySortOrder = null,
    aggregation: FormulaAndFunctionEventAggregation,
    metric: ?[]const u8 = null,
};

pub const NotebooksResponse = struct {
    data: ?[]const std.json.Value = null,
    meta: ?NotebooksResponseMeta = null,
};

pub const LogsStatusRemapper = struct {
    name: ?[]const u8 = null,
    @"type": LogsStatusRemapperType,
    is_enabled: ?bool = null,
    sources: []const []const u8,
};

pub const SyntheticsAssertionJSONSchemaTarget = struct {
    target: ?SyntheticsAssertionJSONSchemaTargetTarget = null,
    operator: SyntheticsAssertionJSONSchemaOperator,
    @"type": SyntheticsAssertionType,
};

pub const SyntheticsPrivateLocationCreationResponseResultEncryption = struct {
    id: ?[]const u8 = null,
    key: ?[]const u8 = null,
};

pub const SLOTimeframe = struct {
};

pub const FormulaAndFunctionApmResourceStatName = struct {
};

pub const SyntheticsCIBatchMetadataProvider = struct {
    name: ?[]const u8 = null,
};

pub const UsageSyntheticsAPIHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    check_calls_count: ?i64 = null,
    public_id: ?[]const u8 = null,
};

pub const SLOStatus = struct {
    sli: ?f64 = null,
    error_budget_remaining: ?f64 = null,
    indexed_at: ?i64 = null,
    state: ?SLOState = null,
    span_precision: ?i64 = null,
    calculation_error: ?[]const u8 = null,
    raw_error_budget_remaining: ?SLORawErrorBudgetRemaining = null,
};

pub const LogsSchemaRemapper = struct {
    target_format: ?TargetFormatType = null,
    target: []const u8,
    override_on_conflict: ?bool = null,
    name: []const u8,
    @"type": LogsSchemaRemapperType,
    preserve_source: ?bool = null,
    sources: []const []const u8,
};

pub const SLOSliSpec = struct {
};

pub const UsageBillableSummaryResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const UsageSummaryDate = struct {
    on_call_seat_hwm: ?i64 = null,
    cloud_cost_management_gcp_host_count_avg: ?i64 = null,
    synthetics_browser_check_calls_count_sum: ?i64 = null,
    aws_lambda_invocations_sum: ?i64 = null,
    opentelemetry_host_top99p: ?i64 = null,
    cloud_siem_events_sum: ?i64 = null,
    incident_management_seats_hwm: ?i64 = null,
    mobile_rum_session_count_android_sum: ?i64 = null,
    flex_logs_starter_avg: ?i64 = null,
    event_management_correlation_correlated_events_sum: ?i64 = null,
    sca_fargate_count_avg: ?i64 = null,
    browser_rum_lite_session_count_sum: ?i64 = null,
    dbm_host_top99p: ?i64 = null,
    serverless_apps_excl_fargate_azure_function_app_instances_avg: ?i64 = null,
    error_tracking_rum_error_events_sum: ?i64 = null,
    azure_app_service_top99p: ?i64 = null,
    error_tracking_events_sum: ?i64 = null,
    sds_events_scanned_bytes_sum: ?i64 = null,
    flex_logs_starter_storage_retention_adjustment_avg: ?i64 = null,
    code_security_host_top99p: ?i64 = null,
    product_analytics_sum: ?i64 = null,
    ci_pipeline_indexed_spans_sum: ?i64 = null,
    rum_indexed_sessions_sum: ?i64 = null,
    csm_host_enterprise_gcp_host_count_top99p: ?i64 = null,
    sca_fargate_count_hwm: ?i64 = null,
    container_hwm: ?i64 = null,
    rum_mobile_legacy_session_count_roku_sum: ?i64 = null,
    rum_mobile_lite_session_count_android_sum: ?i64 = null,
    serverless_apps_apm_avg: ?i64 = null,
    rum_session_count_sum: ?i64 = null,
    eph_infra_host_opentelemetry_apm_sum: ?i64 = null,
    cspm_host_top99p: ?i64 = null,
    serverless_apps_azure_count_avg: ?i64 = null,
    flex_logs_compute_medium_avg: ?i64 = null,
    aws_lambda_func_count: ?i64 = null,
    ccm_spend_monitored_pro_last: ?i64 = null,
    serverless_apps_apm_apm_gcp_cloudfunction_instances_avg: ?i64 = null,
    serverless_apps_apm_apm_gcp_cloudrun_instances_avg: ?i64 = null,
    apm_enterprise_standalone_hosts_top99p: ?i64 = null,
    cloud_cost_management_aws_host_count_avg: ?i64 = null,
    rum_mobile_legacy_session_count_ios_sum: ?i64 = null,
    serverless_apps_apm_apm_fargate_ecs_tasks_avg: ?i64 = null,
    eph_infra_host_alibaba_sum: ?i64 = null,
    eph_infra_host_heroku_sum: ?i64 = null,
    rum_browser_lite_session_count_sum: ?i64 = null,
    profiling_aas_count_top99p: ?i64 = null,
    cspm_aws_host_top99p: ?i64 = null,
    cloud_cost_management_azure_host_count_avg: ?i64 = null,
    dbm_queries_count_avg: ?i64 = null,
    rum_lite_session_count_sum: ?i64 = null,
    cws_container_count_avg: ?i64 = null,
    ci_visibility_pipeline_committers_hwm: ?i64 = null,
    appsec_fargate_count_avg: ?i64 = null,
    fargate_tasks_count_avg: ?i64 = null,
    heroku_host_top99p: ?i64 = null,
    rum_mobile_lite_session_count_roku_sum: ?i64 = null,
    csm_host_enterprise_aws_host_count_top99p: ?i64 = null,
    mobile_rum_lite_session_count_sum: ?i64 = null,
    mobile_rum_session_count_ios_sum: ?i64 = null,
    siem_analyzed_logs_add_on_count_sum: ?i64 = null,
    indexed_events_count_sum: ?i64 = null,
    flex_logs_compute_xsmall_avg: ?i64 = null,
    csm_container_enterprise_cws_count_sum: ?i64 = null,
    serverless_apps_ecs_avg: ?i64 = null,
    avg_profiled_fargate_tasks: ?i64 = null,
    csm_host_enterprise_compliance_host_count_top99p: ?i64 = null,
    flex_logs_compute_xlarge_avg: ?i64 = null,
    gcp_host_top99p: ?i64 = null,
    rum_mobile_replay_session_count_android_sum: ?i64 = null,
    rum_browser_and_mobile_session_count: ?i64 = null,
    rum_mobile_lite_session_count_kotlinmultiplatform_sum: ?i64 = null,
    rum_mobile_legacy_session_count_flutter_sum: ?i64 = null,
    agent_host_top99p: ?i64 = null,
    llm_observability_min_spend_sum: ?i64 = null,
    audit_trail_enabled_hwm: ?i64 = null,
    eph_infra_host_azure_sum: ?i64 = null,
    rum_mobile_replay_session_count_ios_sum: ?i64 = null,
    synthetics_parallel_testing_max_slots_hwm: ?i64 = null,
    incident_management_monthly_active_users_hwm: ?i64 = null,
    iot_device_sum: ?i64 = null,
    serverless_apps_google_cloud_functions_instances_avg: ?i64 = null,
    apm_host_top99p: ?i64 = null,
    audit_logs_lines_indexed_sum: ?i64 = null,
    eph_infra_host_proxmox_sum: ?i64 = null,
    cws_fargate_task_avg: ?i64 = null,
    online_archive_events_count_sum: ?i64 = null,
    asm_serverless_sum: ?i64 = null,
    serverless_apps_excl_fargate_azure_container_app_instances_avg: ?i64 = null,
    opentelemetry_apm_host_top99p: ?i64 = null,
    eph_infra_host_opentelemetry_sum: ?i64 = null,
    observability_pipelines_bytes_processed_sum: ?i64 = null,
    rum_mobile_replay_session_count_kotlinmultiplatform_sum: ?i64 = null,
    serverless_apps_google_count_avg: ?i64 = null,
    oci_host_top99p: ?i64 = null,
    browser_rum_units_sum: ?i64 = null,
    rum_replay_session_count_sum: ?i64 = null,
    eph_infra_host_only_aas_sum: ?i64 = null,
    mobile_rum_units_sum: ?i64 = null,
    mobile_rum_session_count_sum: ?i64 = null,
    sds_apm_scanned_bytes_sum: ?i64 = null,
    sds_rum_scanned_bytes_sum: ?i64 = null,
    serverless_apps_excl_fargate_azure_web_app_instances_avg: ?i64 = null,
    universal_service_monitoring_host_top99p: ?i64 = null,
    aws_host_top99p: ?i64 = null,
    cspm_container_hwm: ?i64 = null,
    error_tracking_apm_error_events_sum: ?i64 = null,
    serverless_apps_apm_apm_azure_containerapp_instances_avg: ?i64 = null,
    csm_host_enterprise_cws_host_count_top99p: ?i64 = null,
    csm_host_enterprise_aas_host_count_top99p: ?i64 = null,
    proxmox_host_sum: ?i64 = null,
    ci_visibility_test_committers_hwm: ?i64 = null,
    serverless_apps_apm_apm_azure_azurefunction_instances_avg: ?i64 = null,
    fargate_container_profiler_profiling_fargate_avg: ?i64 = null,
    serverless_apps_total_count_avg: ?i64 = null,
    serverless_apps_azure_web_app_instances_avg: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_azure_azurefunction_instances_avg: ?i64 = null,
    fargate_tasks_count_hwm: ?i64 = null,
    workflow_executions_usage_sum: ?i64 = null,
    iot_device_top99p: ?i64 = null,
    rum_mobile_lite_session_count_ios_sum: ?i64 = null,
    network_device_wireless_top99p: ?i64 = null,
    apm_devsecops_host_top99p: ?i64 = null,
    twol_ingested_events_bytes_sum: ?i64 = null,
    error_tracking_error_events_sum: ?i64 = null,
    container_avg: ?i64 = null,
    rum_units_sum: ?i64 = null,
    serverless_apps_apm_apm_azure_appservice_instances_avg: ?i64 = null,
    serverless_apps_google_cloud_run_instances_avg: ?i64 = null,
    event_management_correlation_correlated_related_events_sum: ?i64 = null,
    ndm_netflow_events_sum: ?i64 = null,
    synthetics_check_calls_count_sum: ?i64 = null,
    code_analysis_sa_committers_hwm: ?i64 = null,
    ingested_events_bytes_sum: ?i64 = null,
    published_app_hwm: ?i64 = null,
    rum_browser_legacy_session_count_sum: ?i64 = null,
    browser_rum_replay_session_count_sum: ?i64 = null,
    cloud_cost_management_host_count_avg: ?i64 = null,
    serverless_apps_excl_fargate_google_cloud_functions_instances_avg: ?i64 = null,
    eph_infra_host_agent_sum: ?i64 = null,
    container_excl_agent_avg: ?i64 = null,
    cspm_container_avg: ?i64 = null,
    profiling_host_top99p: ?i64 = null,
    rum_mobile_lite_session_count_reactnative_sum: ?i64 = null,
    ci_test_indexed_spans_sum: ?i64 = null,
    npm_host_top99p: ?i64 = null,
    sds_logs_scanned_bytes_sum: ?i64 = null,
    rum_ingested_sessions_sum: ?i64 = null,
    cws_host_top99p: ?i64 = null,
    mobile_rum_session_count_flutter_sum: ?i64 = null,
    code_analysis_sca_committers_hwm: ?i64 = null,
    rum_mobile_legacy_session_count_android_sum: ?i64 = null,
    flex_logs_starter_storage_index_avg: ?i64 = null,
    infra_host_top99p: ?i64 = null,
    trace_search_indexed_events_count_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_gcp_cloudrun_instances_avg: ?i64 = null,
    cspm_azure_host_top99p: ?i64 = null,
    mobile_rum_session_count_roku_sum: ?i64 = null,
    cspm_aas_host_top99p: ?i64 = null,
    apm_fargate_count_avg: ?i64 = null,
    event_management_correlation_sum: ?i64 = null,
    rum_mobile_replay_session_count_reactnative_sum: ?i64 = null,
    date: ?[]const u8 = null,
    ci_visibility_itr_committers_hwm: ?i64 = null,
    orgs: ?[]const std.json.Value = null,
    oci_host_sum: ?i64 = null,
    sds_total_scanned_bytes_sum: ?i64 = null,
    apm_pro_standalone_hosts_top99p: ?i64 = null,
    csm_host_enterprise_total_host_count_top99p: ?i64 = null,
    vsphere_host_top99p: ?i64 = null,
    rum_session_replay_add_on_sum: ?i64 = null,
    rum_total_session_count_sum: ?i64 = null,
    proxmox_host_top99p: ?i64 = null,
    netflow_indexed_events_count_sum: ?i64 = null,
    serverless_apps_eks_avg: ?i64 = null,
    flex_stored_logs_avg: ?i64 = null,
    eph_infra_host_ent_sum: ?i64 = null,
    eph_infra_host_only_vsphere_sum: ?i64 = null,
    mobile_rum_session_count_reactnative_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_avg: ?i64 = null,
    synthetics_mobile_test_runs_sum: ?i64 = null,
    csm_container_enterprise_compliance_count_sum: ?i64 = null,
    rum_browser_replay_session_count_sum: ?i64 = null,
    data_jobs_monitoring_host_hr_sum: ?i64 = null,
    rum_mobile_legacy_session_count_reactnative_sum: ?i64 = null,
    eph_infra_host_gcp_sum: ?i64 = null,
    serverless_apps_azure_function_app_instances_avg: ?i64 = null,
    billable_ingested_bytes_sum: ?i64 = null,
    serverless_apps_excl_fargate_avg: ?i64 = null,
    csm_container_enterprise_total_count_sum: ?i64 = null,
    vuln_management_host_count_top99p: ?i64 = null,
    flex_logs_compute_large_avg: ?i64 = null,
    serverless_apps_azure_container_app_instances_avg: ?i64 = null,
    rum_mobile_lite_session_count_flutter_sum: ?i64 = null,
    eph_infra_host_pro_sum: ?i64 = null,
    forwarding_events_bytes_sum: ?i64 = null,
    eph_infra_host_aws_sum: ?i64 = null,
    serverless_apps_excl_fargate_google_cloud_run_instances_avg: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_gcp_cloudfunction_instances_avg: ?i64 = null,
    cloud_cost_management_oci_host_count_avg: ?i64 = null,
    csm_host_enterprise_azure_host_count_top99p: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_azure_containerapp_instances_avg: ?i64 = null,
    cspm_gcp_host_top99p: ?i64 = null,
    flex_logs_compute_small_avg: ?i64 = null,
    bits_ai_investigations_sum: ?i64 = null,
    llm_observability_sum: ?i64 = null,
    rum_mobile_lite_session_count_unity_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_azure_appservice_instances_avg: ?i64 = null,
    custom_ts_avg: ?i64 = null,
    apm_azure_app_service_host_top99p: ?i64 = null,
    eph_infra_host_proplus_sum: ?i64 = null,
    ccm_spend_monitored_ent_last: ?i64 = null,
    fargate_container_profiler_profiling_fargate_eks_avg: ?i64 = null,
};

pub const SyntheticsParsingOptions = struct {
    parser: ?SyntheticsVariableParser = null,
    field: ?[]const u8 = null,
    name: ?[]const u8 = null,
    secure: ?bool = null,
    @"type": ?SyntheticsLocalVariableParsingOptionsType = null,
};

pub const FunnelSource = struct {
};

pub const SyntheticsTestOptions = struct {
    ci: ?SyntheticsTestCiOptions = null,
    ignoreServerCertificateError: ?bool = null,
    httpVersion: ?SyntheticsTestOptionsHTTPVersion = null,
    monitor_options: ?SyntheticsTestOptionsMonitorOptions = null,
    monitor_name: ?[]const u8 = null,
    disableCors: ?bool = null,
    scheduling: ?SyntheticsTestOptionsScheduling = null,
    follow_redirects: ?bool = null,
    blockedRequestPatterns: ?[]const []const u8 = null,
    enableProfiling: ?bool = null,
    checkCertificateRevocation: ?bool = null,
    disableAiaIntermediateFetching: ?bool = null,
    rumSettings: ?SyntheticsBrowserTestRumSettings = null,
    disableCsp: ?bool = null,
    allow_insecure: ?bool = null,
    tick_every: ?i64 = null,
    device_ids: ?[]const std.json.Value = null,
    min_failure_duration: ?i64 = null,
    enableSecurityTesting: ?bool = null,
    monitor_priority: ?i64 = null,
    initialNavigationTimeout: ?i64 = null,
    min_location_failed: ?i64 = null,
    accept_self_signed: ?bool = null,
    restricted_roles: ?SyntheticsRestrictedRoles = null,
    noScreenshot: ?bool = null,
    retry: ?SyntheticsTestOptionsRetry = null,
};

pub const TimeseriesWidgetLegendLayout = struct {
};

pub const SyntheticsTestRequestVariableDNSServerPort = struct {
};

pub const SunburstWidgetDefinitionType = struct {
};

pub const SyntheticsGlobalVariableOptions = struct {
    totp_parameters: ?SyntheticsGlobalVariableTOTPParameters = null,
};

pub const SunburstWidgetLegendTableType = struct {
};

pub const MetricsQueryResponse = struct {
    @"error": ?[]const u8 = null,
    from_date: ?i64 = null,
    group_by: ?[]const []const u8 = null,
    res_type: ?[]const u8 = null,
    series: ?[]const std.json.Value = null,
    status: ?[]const u8 = null,
    message: ?[]const u8 = null,
    query: ?[]const u8 = null,
    to_date: ?i64 = null,
};

pub const UsageCustomReportsPage = struct {
    total_count: ?i64 = null,
};

pub const TimeseriesBackground = struct {
    yaxis: ?WidgetAxis = null,
    @"type": TimeseriesBackgroundType,
};

pub const DashboardTemplateVariable = struct {
    available_values: ?[]const []const u8 = null,
    default: ?[]const u8 = null,
    name: []const u8,
    defaults: ?[]const []const u8 = null,
    @"type": ?[]const u8 = null,
    prefix: ?[]const u8 = null,
};

pub const UsageSpecifiedCustomReportsPage = struct {
    total_count: ?i64 = null,
};

pub const AWSLogsAsyncResponse = struct {
    status: ?[]const u8 = null,
    errors: ?[]const std.json.Value = null,
};

pub const HTTPLog = struct {
};

pub const OrganizationSettingsSamlAutocreateUsersDomains = struct {
    domains: ?[]const []const u8 = null,
    enabled: ?bool = null,
};

pub const ScatterPlotWidgetDefinitionType = struct {
};

pub const SyntheticsTestDetailsWithoutSteps = struct {
    subtype: ?SyntheticsTestDetailsSubType = null,
    options: ?SyntheticsTestOptions = null,
    monitor_id: ?i64 = null,
    tags: ?[]const []const u8 = null,
    config: ?SyntheticsTestConfig = null,
    locations: ?[]const []const u8 = null,
    message: ?[]const u8 = null,
    status: ?SyntheticsTestPauseStatus = null,
    public_id: ?[]const u8 = null,
    @"type": ?SyntheticsTestDetailsType = null,
    name: ?[]const u8 = null,
    creator: ?Creator = null,
};

pub const TreeMapWidgetRequest = struct {
    formulas: ?[]const std.json.Value = null,
    q: ?[]const u8 = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    queries: ?[]const std.json.Value = null,
};

pub const TableWidgetHasSearchBar = struct {
};

pub const SyntheticsTestRequestNumericalDNSServerPort = struct {
};

pub const WidgetCompareTo = struct {
};

pub const MetricsPayload = struct {
    series: []const std.json.Value,
};

pub const MonitorDeviceID = struct {
};

pub const DashboardList = struct {
    author: ?Creator = null,
    modified: ?[]const u8 = null,
    name: []const u8,
    is_favorite: ?bool = null,
    id: ?i64 = null,
    @"type": ?[]const u8 = null,
    dashboard_count: ?i64 = null,
    created: ?[]const u8 = null,
};

pub const FormulaAndFunctionApmDependencyStatsQueryDefinition = struct {
    data_source: FormulaAndFunctionApmDependencyStatsDataSource,
    cross_org_uuids: ?CrossOrgUuids = null,
    operation_name: []const u8,
    primary_tag_value: ?[]const u8 = null,
    service: []const u8,
    stat: FormulaAndFunctionApmDependencyStatName,
    resource_name: []const u8,
    name: []const u8,
    env: []const u8,
    primary_tag_name: ?[]const u8 = null,
    is_upstream: ?bool = null,
};

pub const LogsArrayProcessor = struct {
    operation: LogsArrayProcessorOperation,
    name: ?[]const u8 = null,
    @"type": LogsArrayProcessorType,
    is_enabled: ?bool = null,
};

pub const SyntheticsAPITestStep = struct {
    subtype: SyntheticsAPITestStepSubtype,
    isCritical: ?bool = null,
    request: SyntheticsTestRequest,
    assertions: []const std.json.Value,
    extractedValues: ?[]const std.json.Value = null,
    allowFailure: ?bool = null,
    exitIfSucceed: ?bool = null,
    retry: ?SyntheticsTestOptionsRetry = null,
    id: ?[]const u8 = null,
    name: []const u8,
    extractedValuesFromScript: ?[]const u8 = null,
};

pub const MonthlyUsageAttributionSupportedMetrics = struct {
};

pub const TreeMapGroupBy = struct {
};

pub const WidgetVerticalAlign = struct {
};

pub const MonthlyUsageAttributionBody = struct {
    tags: ?UsageAttributionTagNames = null,
    tag_config_source: ?[]const u8 = null,
    region: ?[]const u8 = null,
    org_name: ?[]const u8 = null,
    month: ?[]const u8 = null,
    values: ?MonthlyUsageAttributionValues = null,
    public_id: ?[]const u8 = null,
    updated_at: ?[]const u8 = null,
};

pub const WidgetMarker = struct {
    time: ?[]const u8 = null,
    value: []const u8,
    label: ?[]const u8 = null,
    display_type: ?[]const u8 = null,
};

pub const UsageSummaryResponse = struct {
    online_archive_events_count_agg_sum: ?i64 = null,
    eph_infra_host_only_aas_agg_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_azure_containerapp_instances_avg_sum: ?i64 = null,
    rehydrated_indexed_events_agg_sum: ?i64 = null,
    apm_enterprise_standalone_hosts_top99p_sum: ?i64 = null,
    aws_lambda_invocations_sum: ?i64 = null,
    rum_ingested_sessions_agg_sum: ?i64 = null,
    serverless_apps_excl_fargate_google_cloud_functions_instances_avg_sum: ?i64 = null,
    rum_mobile_lite_session_count_android_agg_sum: ?i64 = null,
    rum_mobile_replay_session_count_android_agg_sum: ?i64 = null,
    mobile_rum_session_count_reactnative_agg_sum: ?i64 = null,
    synthetics_check_calls_count_agg_sum: ?i64 = null,
    fargate_tasks_count_avg_sum: ?i64 = null,
    rum_mobile_legacy_session_count_flutter_agg_sum: ?i64 = null,
    fargate_container_profiler_profiling_fargate_avg_sum: ?i64 = null,
    rum_mobile_lite_session_count_reactnative_agg_sum: ?i64 = null,
    serverless_apps_apm_apm_gcp_cloudrun_instances_avg_sum: ?i64 = null,
    cloud_cost_management_azure_host_count_avg_sum: ?i64 = null,
    flex_logs_compute_medium_avg_sum: ?i64 = null,
    avg_profiled_fargate_tasks_sum: ?i64 = null,
    cspm_gcp_host_top99p_sum: ?i64 = null,
    eph_infra_host_aws_agg_sum: ?i64 = null,
    flex_stored_logs_avg_sum: ?i64 = null,
    sds_events_scanned_bytes_sum: ?i64 = null,
    sca_fargate_count_hwm_sum: ?i64 = null,
    csm_host_enterprise_gcp_host_count_top99p_sum: ?i64 = null,
    eph_infra_host_ent_agg_sum: ?i64 = null,
    eph_infra_host_only_vsphere_agg_sum: ?i64 = null,
    serverless_apps_azure_web_app_instances_avg_sum: ?i64 = null,
    agent_host_top99p_sum: ?i64 = null,
    csm_host_enterprise_cws_host_count_top99p_sum: ?i64 = null,
    billable_ingested_bytes_agg_sum: ?i64 = null,
    mobile_rum_units_agg_sum: ?i64 = null,
    netflow_indexed_events_count_agg_sum: ?i64 = null,
    fargate_container_profiler_profiling_fargate_eks_avg_sum: ?i64 = null,
    rum_browser_legacy_session_count_agg_sum: ?i64 = null,
    serverless_apps_google_cloud_run_instances_avg_sum: ?i64 = null,
    eph_infra_host_opentelemetry_apm_agg_sum: ?i64 = null,
    apm_fargate_count_avg_sum: ?i64 = null,
    gcp_host_top99p_sum: ?i64 = null,
    serverless_apps_ecs_avg_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_azure_appservice_instances_avg_sum: ?i64 = null,
    logs_by_retention: ?LogsByRetention = null,
    serverless_apps_apm_excl_fargate_apm_azure_azurefunction_instances_avg_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_avg_sum: ?i64 = null,
    published_app_hwm_sum: ?i64 = null,
    rum_browser_replay_session_count_agg_sum: ?i64 = null,
    ccm_spend_monitored_ent_last_sum: ?i64 = null,
    aws_lambda_func_count: ?i64 = null,
    event_management_correlation_correlated_events_agg_sum: ?i64 = null,
    profiling_aas_count_top99p_sum: ?i64 = null,
    bits_ai_investigations_agg_sum: ?i64 = null,
    custom_historical_ts_sum: ?i64 = null,
    browser_rum_lite_session_count_agg_sum: ?i64 = null,
    vuln_management_host_count_top99p_sum: ?i64 = null,
    eph_infra_host_azure_agg_sum: ?i64 = null,
    opentelemetry_apm_host_top99p_sum: ?i64 = null,
    cloud_cost_management_oci_host_count_avg_sum: ?i64 = null,
    csm_host_enterprise_compliance_host_count_top99p_sum: ?i64 = null,
    serverless_apps_google_count_avg_sum: ?i64 = null,
    ndm_netflow_events_agg_sum: ?i64 = null,
    network_device_wireless_top99p_sum: ?i64 = null,
    observability_pipelines_bytes_processed_agg_sum: ?i64 = null,
    csm_container_enterprise_compliance_count_agg_sum: ?i64 = null,
    cspm_azure_host_top99p_sum: ?i64 = null,
    end_date: ?[]const u8 = null,
    incident_management_seats_hwm_sum: ?i64 = null,
    eph_infra_host_gcp_agg_sum: ?i64 = null,
    custom_live_ts_sum: ?i64 = null,
    eph_infra_host_agent_agg_sum: ?i64 = null,
    event_management_correlation_agg_sum: ?i64 = null,
    mobile_rum_session_count_android_agg_sum: ?i64 = null,
    eph_infra_host_alibaba_agg_sum: ?i64 = null,
    serverless_apps_apm_apm_azure_appservice_instances_avg_sum: ?i64 = null,
    sca_fargate_count_avg_sum: ?i64 = null,
    rum_mobile_lite_session_count_kotlinmultiplatform_agg_sum: ?i64 = null,
    forwarding_events_bytes_agg_sum: ?i64 = null,
    live_ingested_bytes_agg_sum: ?i64 = null,
    rum_units_agg_sum: ?i64 = null,
    serverless_apps_apm_apm_azure_containerapp_instances_avg_sum: ?i64 = null,
    serverless_apps_azure_container_app_instances_avg_sum: ?i64 = null,
    serverless_apps_azure_function_app_instances_avg_sum: ?i64 = null,
    asm_serverless_agg_sum: ?i64 = null,
    rum_browser_and_mobile_session_count: ?i64 = null,
    audit_trail_enabled_hwm_sum: ?i64 = null,
    dbm_queries_avg_sum: ?i64 = null,
    rum_session_replay_add_on_agg_sum: ?i64 = null,
    start_date: ?[]const u8 = null,
    error_tracking_error_events_agg_sum: ?i64 = null,
    appsec_fargate_count_avg_sum: ?i64 = null,
    csm_container_enterprise_total_count_agg_sum: ?i64 = null,
    mobile_rum_session_count_roku_agg_sum: ?i64 = null,
    opentelemetry_host_top99p_sum: ?i64 = null,
    code_analysis_sca_committers_hwm_sum: ?i64 = null,
    container_hwm_sum: ?i64 = null,
    flex_logs_starter_storage_index_avg_sum: ?i64 = null,
    heroku_host_top99p_sum: ?i64 = null,
    serverless_apps_excl_fargate_azure_function_app_instances_avg_sum: ?i64 = null,
    workflow_executions_usage_agg_sum: ?i64 = null,
    csm_host_enterprise_azure_host_count_top99p_sum: ?i64 = null,
    cws_container_avg_sum: ?i64 = null,
    on_call_seat_hwm_sum: ?i64 = null,
    ci_visibility_itr_committers_hwm_sum: ?i64 = null,
    usage: ?[]const std.json.Value = null,
    browser_rum_units_agg_sum: ?i64 = null,
    rum_mobile_lite_session_count_ios_agg_sum: ?i64 = null,
    flex_logs_compute_xsmall_avg_sum: ?i64 = null,
    iot_device_agg_sum: ?i64 = null,
    csm_host_enterprise_aas_host_count_top99p_sum: ?i64 = null,
    error_tracking_rum_error_events_agg_sum: ?i64 = null,
    ci_pipeline_indexed_spans_agg_sum: ?i64 = null,
    ingested_events_bytes_agg_sum: ?i64 = null,
    proxmox_host_top99p_sum: ?i64 = null,
    synthetics_parallel_testing_max_slots_hwm_sum: ?i64 = null,
    apm_azure_app_service_host_top99p_sum: ?i64 = null,
    error_tracking_events_agg_sum: ?i64 = null,
    rum_mobile_legacy_session_count_android_agg_sum: ?i64 = null,
    sds_apm_scanned_bytes_sum: ?i64 = null,
    sds_rum_scanned_bytes_sum: ?i64 = null,
    eph_infra_host_opentelemetry_agg_sum: ?i64 = null,
    iot_device_top99p_sum: ?i64 = null,
    rum_mobile_replay_session_count_reactnative_agg_sum: ?i64 = null,
    llm_observability_agg_sum: ?i64 = null,
    rum_total_session_count_agg_sum: ?i64 = null,
    rum_mobile_replay_session_count_kotlinmultiplatform_agg_sum: ?i64 = null,
    event_management_correlation_correlated_related_events_agg_sum: ?i64 = null,
    azure_app_service_top99p_sum: ?i64 = null,
    mobile_rum_session_count_flutter_agg_sum: ?i64 = null,
    mobile_rum_lite_session_count_agg_sum: ?i64 = null,
    browser_rum_replay_session_count_agg_sum: ?i64 = null,
    serverless_apps_total_count_avg_sum: ?i64 = null,
    eph_infra_host_pro_agg_sum: ?i64 = null,
    mobile_rum_session_count_ios_agg_sum: ?i64 = null,
    rum_mobile_legacy_session_count_roku_agg_sum: ?i64 = null,
    csm_host_enterprise_aws_host_count_top99p_sum: ?i64 = null,
    rum_session_count_agg_sum: ?i64 = null,
    rum_mobile_lite_session_count_unity_agg_sum: ?i64 = null,
    cws_fargate_task_avg_sum: ?i64 = null,
    product_analytics_agg_sum: ?i64 = null,
    serverless_apps_excl_fargate_avg_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_gcp_cloudfunction_instances_avg_sum: ?i64 = null,
    dbm_host_top99p_sum: ?i64 = null,
    cspm_aas_host_top99p_sum: ?i64 = null,
    twol_ingested_events_bytes_agg_sum: ?i64 = null,
    cloud_siem_events_agg_sum: ?i64 = null,
    rum_mobile_legacy_session_count_ios_agg_sum: ?i64 = null,
    data_jobs_monitoring_host_hr_agg_sum: ?i64 = null,
    proxmox_host_agg_sum: ?i64 = null,
    apm_host_top99p_sum: ?i64 = null,
    serverless_apps_excl_fargate_azure_container_app_instances_avg_sum: ?i64 = null,
    serverless_apps_eks_avg_sum: ?i64 = null,
    siem_analyzed_logs_add_on_count_agg_sum: ?i64 = null,
    flex_logs_starter_avg_sum: ?i64 = null,
    aws_host_top99p_sum: ?i64 = null,
    apm_pro_standalone_hosts_top99p_sum: ?i64 = null,
    serverless_apps_apm_apm_azure_azurefunction_instances_avg_sum: ?i64 = null,
    oci_host_top99p_sum: ?i64 = null,
    sds_logs_scanned_bytes_sum: ?i64 = null,
    audit_logs_lines_indexed_agg_sum: ?i64 = null,
    cws_host_top99p_sum: ?i64 = null,
    cloud_cost_management_aws_host_count_avg_sum: ?i64 = null,
    cloud_cost_management_host_count_avg_sum: ?i64 = null,
    flex_logs_starter_storage_retention_adjustment_avg_sum: ?i64 = null,
    rum_mobile_lite_session_count_flutter_agg_sum: ?i64 = null,
    cspm_host_top99p_sum: ?i64 = null,
    container_excl_agent_avg_sum: ?i64 = null,
    ccm_spend_monitored_pro_last_sum: ?i64 = null,
    custom_ts_sum: ?i64 = null,
    error_tracking_apm_error_events_agg_sum: ?i64 = null,
    llm_observability_min_spend_agg_sum: ?i64 = null,
    apm_devsecops_host_top99p_sum: ?i64 = null,
    live_indexed_events_agg_sum: ?i64 = null,
    serverless_apps_azure_count_avg_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_gcp_cloudrun_instances_avg_sum: ?i64 = null,
    fargate_tasks_count_hwm_sum: ?i64 = null,
    cspm_container_hwm_sum: ?i64 = null,
    container_avg_sum: ?i64 = null,
    flex_logs_compute_small_avg_sum: ?i64 = null,
    ci_visibility_pipeline_committers_hwm_sum: ?i64 = null,
    code_security_host_top99p_sum: ?i64 = null,
    npm_host_top99p_sum: ?i64 = null,
    cspm_container_avg_sum: ?i64 = null,
    vsphere_host_top99p_sum: ?i64 = null,
    cspm_aws_host_top99p_sum: ?i64 = null,
    csm_host_enterprise_total_host_count_top99p_sum: ?i64 = null,
    sds_total_scanned_bytes_sum: ?i64 = null,
    ci_visibility_test_committers_hwm_sum: ?i64 = null,
    flex_logs_compute_xlarge_avg_sum: ?i64 = null,
    oci_host_agg_sum: ?i64 = null,
    serverless_apps_apm_avg_sum: ?i64 = null,
    eph_infra_host_proplus_agg_sum: ?i64 = null,
    rehydrated_ingested_bytes_agg_sum: ?i64 = null,
    rum_lite_session_count_agg_sum: ?i64 = null,
    indexed_events_count_agg_sum: ?i64 = null,
    trace_search_indexed_events_count_agg_sum: ?i64 = null,
    synthetics_browser_check_calls_count_agg_sum: ?i64 = null,
    flex_logs_compute_large_avg_sum: ?i64 = null,
    rum_mobile_lite_session_count_roku_agg_sum: ?i64 = null,
    cloud_cost_management_gcp_host_count_avg_sum: ?i64 = null,
    profiling_host_count_top99p_sum: ?i64 = null,
    last_updated: ?[]const u8 = null,
    serverless_apps_excl_fargate_google_cloud_run_instances_avg_sum: ?i64 = null,
    serverless_apps_apm_apm_gcp_cloudfunction_instances_avg_sum: ?i64 = null,
    profiling_container_agent_count_avg: ?i64 = null,
    universal_service_monitoring_host_top99p_sum: ?i64 = null,
    ci_test_indexed_spans_agg_sum: ?i64 = null,
    rum_replay_session_count_agg_sum: ?i64 = null,
    code_analysis_sa_committers_hwm_sum: ?i64 = null,
    synthetics_mobile_test_runs_agg_sum: ?i64 = null,
    infra_host_top99p_sum: ?i64 = null,
    rum_browser_lite_session_count_agg_sum: ?i64 = null,
    serverless_apps_excl_fargate_azure_web_app_instances_avg_sum: ?i64 = null,
    serverless_apps_apm_apm_fargate_ecs_tasks_avg_sum: ?i64 = null,
    rum_mobile_replay_session_count_ios_agg_sum: ?i64 = null,
    eph_infra_host_heroku_agg_sum: ?i64 = null,
    incident_management_monthly_active_users_hwm_sum: ?i64 = null,
    rum_mobile_legacy_session_count_reactnative_agg_sum: ?i64 = null,
    serverless_apps_google_cloud_functions_instances_avg_sum: ?i64 = null,
    mobile_rum_session_count_agg_sum: ?i64 = null,
    rum_indexed_sessions_agg_sum: ?i64 = null,
    csm_container_enterprise_cws_count_agg_sum: ?i64 = null,
    azure_host_top99p_sum: ?i64 = null,
    eph_infra_host_proxmox_agg_sum: ?i64 = null,
};

pub const LogsPipelineProcessor = struct {
    filter: ?LogsFilter = null,
    name: ?[]const u8 = null,
    @"type": LogsPipelineProcessorType,
    is_enabled: ?bool = null,
    processors: ?[]const std.json.Value = null,
};

pub const NotebooksResponseDataAttributes = struct {
    author: ?NotebookAuthor = null,
    modified: ?[]const u8 = null,
    cells: ?[]const std.json.Value = null,
    status: ?NotebookStatus = null,
    time: ?NotebookGlobalTime = null,
    metadata: ?NotebookMetadata = null,
    name: []const u8,
    created: ?[]const u8 = null,
};

pub const SyntheticsBrowserErrorType = struct {
};

pub const EventStreamWidgetDefinition = struct {
    event_size: ?WidgetEventSize = null,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    time: ?WidgetTime = null,
    tags_execution: ?[]const u8 = null,
    query: []const u8,
    title: ?[]const u8 = null,
    @"type": EventStreamWidgetDefinitionType,
};

pub const ListStreamComputeAggregation = struct {
};

pub const HeatMapWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    markers: ?[]const std.json.Value = null,
    requests: []const std.json.Value,
    title_align: ?WidgetTextAlign = null,
    show_legend: ?bool = null,
    time: ?WidgetTime = null,
    events: ?[]const std.json.Value = null,
    yaxis: ?WidgetAxis = null,
    title_size: ?[]const u8 = null,
    legend_size: ?WidgetLegendSize = null,
    xaxis: ?HeatMapWidgetXAxis = null,
    @"type": HeatMapWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const SyntheticsBasicAuthSigv4 = struct {
    secretKey: []const u8,
    accessKey: []const u8,
    serviceName: ?[]const u8 = null,
    sessionToken: ?[]const u8 = null,
    region: ?[]const u8 = null,
    @"type": SyntheticsBasicAuthSigv4Type,
};

pub const DashboardGlobalTime = struct {
    live_span: ?DashboardGlobalTimeLiveSpan = null,
};

pub const EventStreamWidgetDefinitionType = struct {
};

pub const FormulaAndFunctionProcessQueryDataSource = struct {
};

pub const SunburstWidgetRequest = struct {
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?LogQueryDefinition = null,
    formulas: ?[]const std.json.Value = null,
    style: ?WidgetStyle = null,
    q: ?[]const u8 = null,
    audit_query: ?LogQueryDefinition = null,
    queries: ?[]const std.json.Value = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
};

pub const AWSEventBridgeCreateRequest = struct {
    account_id: ?[]const u8 = null,
    event_generator_name: ?[]const u8 = null,
    create_event_bus: ?bool = null,
    region: ?[]const u8 = null,
};

pub const UsageDBMHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    dbm_host_count: ?i64 = null,
    public_id: ?[]const u8 = null,
    dbm_queries_count: ?i64 = null,
};

pub const AWSTagFilterListResponse = struct {
    filters: ?[]const std.json.Value = null,
};

pub const SharedDashboardInviteesItems = struct {
    created_at: ?[]const u8 = null,
    access_expiration: ?[]const u8 = null,
    email: []const u8,
};

pub const SlackIntegrationChannel = struct {
    display: ?SlackIntegrationChannelDisplay = null,
    name: ?[]const u8 = null,
};

pub const WidgetRequestStyle = struct {
    palette: ?[]const u8 = null,
    line_width: ?WidgetLineWidth = null,
    order_by: ?WidgetStyleOrderBy = null,
    line_type: ?WidgetLineType = null,
};

pub const PowerpackWidgetDefinitionType = struct {
};

pub const WidgetNodeType = struct {
};

pub const WidgetViewMode = struct {
};

pub const SharedDashboardUpdateRequest = struct {
    status: ?SharedDashboardStatus = null,
    viewing_preferences: ?ViewingPreferences = null,
    invitees: ?[]const std.json.Value = null,
    expiration: ?[]const u8 = null,
    global_time_selectable_enabled: ?bool = null,
    global_time: ?SharedDashboardUpdateRequestGlobalTime = null,
    selectable_template_vars: ?[]const std.json.Value = null,
    embeddable_domains: ?[]const []const u8 = null,
    share_list: ?[]const []const u8 = null,
    title: ?[]const u8 = null,
    share_type: ?DashboardShareType = null,
};

pub const TableWidgetTextFormatRule = struct {
    palette: ?TableWidgetTextFormatPalette = null,
    custom_bg_color: ?[]const u8 = null,
    replace: ?TableWidgetTextFormatReplace = null,
    custom_fg_color: ?[]const u8 = null,
    match: TableWidgetTextFormatMatch,
};

pub const LogsDateRemapper = struct {
    name: ?[]const u8 = null,
    @"type": LogsDateRemapperType,
    is_enabled: ?bool = null,
    sources: []const []const u8,
};

pub const LogsCategoryProcessor = struct {
    target: []const u8,
    categories: []const std.json.Value,
    @"type": LogsCategoryProcessorType,
    name: ?[]const u8 = null,
    is_enabled: ?bool = null,
};

pub const SyntheticsAssertionJSONSchemaMetaSchema = struct {
};

pub const SelectableTemplateVariableItems = struct {
    visible_tags: ?[]const []const u8 = null,
    name: ?[]const u8 = null,
    @"type": ?[]const u8 = null,
    default_value: ?[]const u8 = null,
    prefix: ?[]const u8 = null,
};

pub const SyntheticsStepDetail = struct {
    subTestStepDetails: ?[]const std.json.Value = null,
    url: ?[]const u8 = null,
    failure: ?SyntheticsBrowserTestResultFailure = null,
    allowFailure: ?bool = null,
    value: ?[]const u8 = null,
    warnings: ?[]const std.json.Value = null,
    browserErrors: ?[]const std.json.Value = null,
    @"error": ?[]const u8 = null,
    screenshotBucketKey: ?bool = null,
    duration: ?f64 = null,
    stepId: ?i64 = null,
    skipped: ?bool = null,
    vitalsMetrics: ?[]const std.json.Value = null,
    playingTab: ?SyntheticsPlayingTab = null,
    checkType: ?SyntheticsCheckType = null,
    description: ?[]const u8 = null,
    snapshotBucketKey: ?bool = null,
    timeToInteractive: ?f64 = null,
    @"type": ?SyntheticsStepType = null,
};

pub const UsageFargateHour = struct {
    appsec_fargate_count: ?i64 = null,
    avg_profiled_fargate_tasks: ?i64 = null,
    hour: ?[]const u8 = null,
    tasks_count: ?i64 = null,
    org_name: ?[]const u8 = null,
    apm_fargate_count: ?i64 = null,
    public_id: ?[]const u8 = null,
};

pub const SyntheticsTriggerBody = struct {
    tests: []const std.json.Value,
};

pub const SearchSLOResponseLinks = struct {
    first: ?[]const u8 = null,
    prev: ?[]const u8 = null,
    self: ?[]const u8 = null,
    last: ?[]const u8 = null,
    next: ?[]const u8 = null,
};

pub const BarChartWidgetDisplay = struct {
};

pub const Monitor = struct {
    modified: ?[]const u8 = null,
    draft_status: ?MonitorDraftStatus = null,
    created: ?[]const u8 = null,
    state: ?MonitorState = null,
    assets: ?[]const std.json.Value = null,
    creator: ?Creator = null,
    id: ?i64 = null,
    options: ?MonitorOptions = null,
    tags: ?[]const []const u8 = null,
    matching_downtimes: ?[]const std.json.Value = null,
    overall_state: ?MonitorOverallStates = null,
    priority: ?i64 = null,
    deleted: ?[]const u8 = null,
    restricted_roles: ?[]const []const u8 = null,
    multi: ?bool = null,
    name: ?[]const u8 = null,
    query: []const u8,
    @"type": MonitorType,
    message: ?[]const u8 = null,
};

pub const SyntheticsAssertionBodyHashType = struct {
};

pub const SyntheticsTriggerCITestRunResult = struct {
    location: ?i64 = null,
    public_id: ?[]const u8 = null,
    result_id: ?[]const u8 = null,
    device: ?SyntheticsDeviceID = null,
};

pub const IFrameWidgetDefinitionType = struct {
};

pub const LogsLookupProcessorType = struct {
};

pub const GeomapWidgetDefinitionView = struct {
    focus: []const u8,
};

pub const NotebookCreateDataAttributes = struct {
    status: ?NotebookStatus = null,
    time: NotebookGlobalTime,
    metadata: ?NotebookMetadata = null,
    name: []const u8,
    cells: []const std.json.Value,
};

pub const SyntheticsGlobalVariableValue = struct {
    value: ?[]const u8 = null,
    options: ?SyntheticsGlobalVariableOptions = null,
    secure: ?bool = null,
};

pub const SplitSort = struct {
    order: WidgetSort,
    compute: ?SplitConfigSortCompute = null,
};

pub const LogsArrayProcessorType = struct {
};

pub const MonthlyUsageAttributionValues = struct {
    sds_scanned_bytes_usage: ?f64 = null,
    rum_browser_mobile_sessions_percentage: ?f64 = null,
    npm_host_percentage: ?f64 = null,
    appsec_fargate_percentage: ?f64 = null,
    cws_fargate_task_usage: ?f64 = null,
    published_app_percentage: ?f64 = null,
    cws_hosts_usage: ?f64 = null,
    cspm_hosts_percentage: ?f64 = null,
    universal_service_monitoring_percentage: ?f64 = null,
    container_percentage: ?f64 = null,
    obs_pipelines_vcpu_usage: ?f64 = null,
    apm_host_percentage: ?f64 = null,
    asm_serverless_traced_invocations_usage: ?f64 = null,
    container_excl_agent_percentage: ?f64 = null,
    fargate_usage: ?f64 = null,
    bits_ai_investigations_percentage: ?f64 = null,
    mobile_app_testing_percentage: ?f64 = null,
    sds_scanned_bytes_percentage: ?f64 = null,
    custom_timeseries_percentage: ?f64 = null,
    cspm_hosts_usage: ?f64 = null,
    flex_logs_starter_usage: ?f64 = null,
    container_excl_agent_usage: ?f64 = null,
    network_device_wireless_usage: ?f64 = null,
    rum_ingested_percentage: ?f64 = null,
    siem_analyzed_logs_add_on_usage: ?f64 = null,
    siem_ingested_bytes_usage: ?f64 = null,
    cspm_containers_percentage: ?f64 = null,
    lambda_traced_invocations_usage: ?f64 = null,
    dbm_queries_usage: ?f64 = null,
    apm_fargate_usage: ?f64 = null,
    lambda_traced_invocations_percentage: ?f64 = null,
    rum_ingested_usage: ?f64 = null,
    dbm_hosts_usage: ?f64 = null,
    infra_host_percentage: ?f64 = null,
    llm_observability_usage: ?f64 = null,
    estimated_indexed_spans_percentage: ?f64 = null,
    logs_indexed_15day_percentage: ?f64 = null,
    logs_indexed_1day_usage: ?f64 = null,
    incident_management_monthly_active_users_percentage: ?f64 = null,
    functions_usage: ?f64 = null,
    infra_host_usage: ?f64 = null,
    logs_indexed_15day_usage: ?f64 = null,
    invocations_usage: ?f64 = null,
    logs_indexed_180day_percentage: ?f64 = null,
    dbm_hosts_percentage: ?f64 = null,
    logs_indexed_360day_percentage: ?f64 = null,
    product_analytics_session_percentage: ?f64 = null,
    ingested_logs_bytes_percentage: ?f64 = null,
    network_device_wireless_percentage: ?f64 = null,
    code_security_host_percentage: ?f64 = null,
    serverless_apps_percentage: ?f64 = null,
    flex_logs_starter_percentage: ?f64 = null,
    logs_indexed_90day_percentage: ?f64 = null,
    vuln_management_hosts_percentage: ?f64 = null,
    data_jobs_monitoring_usage: ?f64 = null,
    ndm_netflow_usage: ?f64 = null,
    ci_pipeline_indexed_spans_percentage: ?f64 = null,
    ci_visibility_itr_usage: ?f64 = null,
    sca_fargate_percentage: ?f64 = null,
    data_stream_monitoring_usage: ?f64 = null,
    estimated_indexed_spans_usage: ?f64 = null,
    ci_test_indexed_spans_percentage: ?f64 = null,
    npm_host_usage: ?f64 = null,
    sca_fargate_usage: ?f64 = null,
    llm_spans_usage: ?f64 = null,
    siem_ingested_bytes_percentage: ?f64 = null,
    cws_fargate_task_percentage: ?f64 = null,
    ci_visibility_itr_percentage: ?f64 = null,
    appsec_percentage: ?f64 = null,
    llm_spans_percentage: ?f64 = null,
    error_tracking_percentage: ?f64 = null,
    rum_investigate_percentage: ?f64 = null,
    asm_serverless_traced_invocations_percentage: ?f64 = null,
    estimated_ingested_spans_percentage: ?f64 = null,
    ingested_spans_bytes_usage: ?f64 = null,
    serverless_apps_usage: ?f64 = null,
    browser_usage: ?f64 = null,
    ci_pipeline_indexed_spans_usage: ?f64 = null,
    estimated_ingested_spans_usage: ?f64 = null,
    snmp_percentage: ?f64 = null,
    logs_indexed_30day_usage: ?f64 = null,
    rum_replay_sessions_percentage: ?f64 = null,
    logs_indexed_3day_usage: ?f64 = null,
    obs_pipeline_bytes_percentage: ?f64 = null,
    logs_indexed_7day_usage: ?f64 = null,
    logs_indexed_360day_usage: ?f64 = null,
    logs_indexed_45day_percentage: ?f64 = null,
    logs_indexed_45day_usage: ?f64 = null,
    logs_indexed_custom_retention_usage: ?f64 = null,
    api_usage: ?f64 = null,
    browser_percentage: ?f64 = null,
    profiled_host_percentage: ?f64 = null,
    custom_event_percentage: ?f64 = null,
    product_analytics_session_usage: ?f64 = null,
    apm_usm_percentage: ?f64 = null,
    rum_session_replay_add_on_usage: ?f64 = null,
    logs_indexed_30day_percentage: ?f64 = null,
    cws_containers_usage: ?f64 = null,
    fargate_percentage: ?f64 = null,
    appsec_usage: ?f64 = null,
    apm_host_usage: ?f64 = null,
    custom_event_usage: ?f64 = null,
    mobile_app_testing_usage: ?f64 = null,
    api_percentage: ?f64 = null,
    invocations_percentage: ?f64 = null,
    container_usage: ?f64 = null,
    obs_pipeline_bytes_usage: ?f64 = null,
    cloud_siem_percentage: ?f64 = null,
    rum_browser_mobile_sessions_usage: ?f64 = null,
    workflow_executions_usage: ?f64 = null,
    logs_indexed_60day_percentage: ?f64 = null,
    snmp_usage: ?f64 = null,
    logs_indexed_180day_usage: ?f64 = null,
    profiled_host_usage: ?f64 = null,
    dbm_queries_percentage: ?f64 = null,
    llm_observability_percentage: ?f64 = null,
    cws_hosts_percentage: ?f64 = null,
    universal_service_monitoring_usage: ?f64 = null,
    ci_test_indexed_spans_usage: ?f64 = null,
    online_archive_usage: ?f64 = null,
    bits_ai_investigations_usage: ?f64 = null,
    cloud_siem_usage: ?f64 = null,
    logs_indexed_3day_percentage: ?f64 = null,
    workflow_executions_percentage: ?f64 = null,
    custom_timeseries_usage: ?f64 = null,
    functions_percentage: ?f64 = null,
    appsec_fargate_usage: ?f64 = null,
    flex_stored_logs_usage: ?f64 = null,
    indexed_spans_usage: ?f64 = null,
    profiled_fargate_usage: ?f64 = null,
    siem_analyzed_logs_add_on_percentage: ?f64 = null,
    logs_indexed_custom_retention_percentage: ?f64 = null,
    logs_indexed_7day_percentage: ?f64 = null,
    rum_session_replay_add_on_percentage: ?f64 = null,
    ingested_logs_bytes_usage: ?f64 = null,
    custom_ingested_timeseries_percentage: ?f64 = null,
    ndm_netflow_percentage: ?f64 = null,
    profiled_container_usage: ?f64 = null,
    ingested_spans_bytes_percentage: ?f64 = null,
    vuln_management_hosts_usage: ?f64 = null,
    incident_management_monthly_active_users_usage: ?f64 = null,
    logs_indexed_90day_usage: ?f64 = null,
    apm_fargate_percentage: ?f64 = null,
    cspm_containers_usage: ?f64 = null,
    custom_ingested_timeseries_usage: ?f64 = null,
    apm_usm_usage: ?f64 = null,
    error_tracking_usage: ?f64 = null,
    flex_stored_logs_percentage: ?f64 = null,
    logs_indexed_60day_usage: ?f64 = null,
    cws_containers_percentage: ?f64 = null,
    code_security_host_usage: ?f64 = null,
    rum_investigate_usage: ?f64 = null,
    indexed_spans_percentage: ?f64 = null,
    logs_indexed_1day_percentage: ?f64 = null,
    obs_pipelines_vcpu_percentage: ?f64 = null,
    profiled_fargate_percentage: ?f64 = null,
    rum_replay_sessions_usage: ?f64 = null,
    online_archive_percentage: ?f64 = null,
    profiled_container_percentage: ?f64 = null,
    published_app_usage: ?f64 = null,
};

pub const SyntheticsPrivateLocationSecrets = struct {
    config_decryption: ?SyntheticsPrivateLocationSecretsConfigDecryption = null,
    authentication: ?SyntheticsPrivateLocationSecretsAuthentication = null,
};

pub const FormulaAndFunctionMetricSemanticMode = struct {
};

pub const CrossOrgUuids = struct {
};

pub const AWSEventBridgeDeleteResponse = struct {
    status: ?AWSEventBridgeDeleteStatus = null,
};

pub const LogsArrayProcessorOperationLength = struct {
    source: []const u8,
    target: []const u8,
    @"type": LogsArrayProcessorOperationLengthType,
};

pub const NotebookAuthor = struct {
    created_at: ?[]const u8 = null,
    disabled: ?bool = null,
    icon: ?[]const u8 = null,
    handle: ?[]const u8 = null,
    email: ?[]const u8 = null,
    verified: ?bool = null,
    status: ?[]const u8 = null,
    name: ?[]const u8 = null,
    title: ?[]const u8 = null,
};

pub const SplitGraphSourceWidgetDefinition = struct {
};

pub const SyntheticsBrowserTestRumSettings = struct {
    clientTokenId: ?i64 = null,
    isEnabled: bool,
    applicationId: ?[]const u8 = null,
};

pub const SyntheticsTestRequestVariablePort = struct {
};

pub const FormulaAndFunctionEventQueryDefinitionSearch = struct {
    query: []const u8,
};

pub const SyntheticsBatchDetails = struct {
    data: ?SyntheticsBatchDetailsData = null,
};

pub const WidgetImageSizing = struct {
};

pub const MetricSearchResponseResults = struct {
    metrics: ?[]const []const u8 = null,
};

pub const OrganizationBilling = struct {
    @"type": ?[]const u8 = null,
};

pub const LogsGrokParserRules = struct {
    match_rules: []const u8,
    support_rules: ?[]const u8 = null,
};

pub const SyntheticsBrowserTestConfig = struct {
    configVariables: ?[]const std.json.Value = null,
    variables: ?[]const std.json.Value = null,
    request: SyntheticsTestRequest,
    assertions: []const std.json.Value,
    setCookie: ?[]const u8 = null,
};

pub const SyntheticsTestOptionsMonitorOptions = struct {
    renotify_interval: ?i64 = null,
    notification_preset_name: ?SyntheticsTestOptionsMonitorOptionsNotificationPresetName = null,
    escalation_message: ?[]const u8 = null,
    renotify_occurrences: ?i64 = null,
};

pub const LogsPipeline = struct {
    tags: ?[]const []const u8 = null,
    is_enabled: ?bool = null,
    processors: ?[]const std.json.Value = null,
    is_read_only: ?bool = null,
    description: ?[]const u8 = null,
    id: ?[]const u8 = null,
    name: []const u8,
    @"type": ?[]const u8 = null,
    filter: ?LogsFilter = null,
};

pub const LogsSchemaRemapperType = struct {
};

pub const LogsTraceRemapper = struct {
    name: ?[]const u8 = null,
    @"type": LogsTraceRemapperType,
    is_enabled: ?bool = null,
    sources: ?[]const []const u8 = null,
};

pub const SearchSLOResponseData = struct {
    attributes: ?SearchSLOResponseDataAttributes = null,
    @"type": ?[]const u8 = null,
};

pub const DashboardListDeleteResponse = struct {
    deleted_dashboard_list_id: ?i64 = null,
};

pub const AlertValueWidgetDefinitionType = struct {
};

pub const RunWorkflowWidgetInput = struct {
    value: []const u8,
    name: []const u8,
};

pub const SharedDashboardInvitesMeta = struct {
    page: ?SharedDashboardInvitesMetaPage = null,
};

pub const SLOResponse = struct {
    data: ?SLOResponseData = null,
    errors: ?[]const []const u8 = null,
};

pub const UsageLambdaHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    func_count: ?i64 = null,
    invocations_sum: ?i64 = null,
    public_id: ?[]const u8 = null,
};

pub const CheckCanDeleteMonitorResponse = struct {
    data: CheckCanDeleteMonitorResponseData,
    errors: ?std.json.Value = null,
};

pub const SyntheticsBrowserTestType = struct {
};

pub const WidgetMonitorSummarySort = struct {
};

pub const AWSAccountListResponse = struct {
    accounts: ?[]const std.json.Value = null,
};

pub const WidgetNewLiveSpanType = struct {
};

pub const SplitConfigSortCompute = struct {
    aggregation: []const u8,
    metric: []const u8,
};

pub const LogsSchemaCategoryMapper = struct {
    targets: LogsSchemaCategoryMapperTargets,
    categories: []const std.json.Value,
    name: []const u8,
    @"type": LogsSchemaCategoryMapperType,
    fallback: ?LogsSchemaCategoryMapperFallback = null,
};

pub const SyntheticsBrowserTestResultData = struct {
    @"error": ?[]const u8 = null,
    startUrl: ?[]const u8 = null,
    duration: ?f64 = null,
    thumbnailsBucketKey: ?bool = null,
    device: ?SyntheticsDevice = null,
    browserType: ?[]const u8 = null,
    failure: ?SyntheticsBrowserTestResultFailure = null,
    passed: ?bool = null,
    receivedEmailCount: ?i64 = null,
    stepDetails: ?[]const std.json.Value = null,
    browserVersion: ?[]const u8 = null,
    timeToInteractive: ?f64 = null,
};

pub const ListStreamGroupByItems = struct {
    facet: []const u8,
};

pub const LogsSchemaCategoryMapperCategory = struct {
    id: i64,
    name: []const u8,
    filter: LogsFilter,
};

pub const SyntheticsAPITest = struct {
    subtype: ?SyntheticsTestDetailsSubType = null,
    options: SyntheticsTestOptions,
    monitor_id: ?i64 = null,
    tags: ?[]const []const u8 = null,
    public_id: ?[]const u8 = null,
    locations: []const []const u8,
    status: ?SyntheticsTestPauseStatus = null,
    name: []const u8,
    @"type": SyntheticsAPITestType,
    config: SyntheticsAPITestConfig,
    message: []const u8,
};

pub const SyntheticsAssertionJavascriptType = struct {
};

pub const FormulaAndFunctionSLOQueryDefinition = struct {
    data_source: FormulaAndFunctionSLODataSource,
    additional_query_filters: ?[]const u8 = null,
    cross_org_uuids: ?CrossOrgUuids = null,
    slo_query_type: ?FormulaAndFunctionSLOQueryType = null,
    group_mode: ?FormulaAndFunctionSLOGroupMode = null,
    measure: FormulaAndFunctionSLOMeasure,
    name: ?[]const u8 = null,
    slo_id: []const u8,
};

pub const WidgetPalette = struct {
};

pub const TreeMapWidgetDefinitionType = struct {
};

pub const MonitorFormulaAndFunctionEventQueryDefinitionSearch = struct {
    query: []const u8,
};

pub const CheckCanDeleteSLOResponse = struct {
    data: ?CheckCanDeleteSLOResponseData = null,
    errors: ?std.json.Value = null,
};

pub const UsageTopAvgMetricsHour = struct {
    max_metric_hour: ?i64 = null,
    metric_category: ?UsageMetricCategory = null,
    metric_name: ?[]const u8 = null,
    avg_metric_hour: ?i64 = null,
};

pub const MonitorFormulaAndFunctionCostQueryDefinition = struct {
    data_source: MonitorFormulaAndFunctionCostDataSource,
    aggregator: ?MonitorFormulaAndFunctionCostAggregator = null,
    name: []const u8,
    query: []const u8,
};

pub const MonthlyUsageAttributionResponse = struct {
    usage: ?[]const std.json.Value = null,
    metadata: ?MonthlyUsageAttributionMetadata = null,
};

pub const SearchSLOResponseMetaPage = struct {
    next_number: ?i64 = null,
    size: ?i64 = null,
    number: ?i64 = null,
    last_number: ?i64 = null,
    total: ?i64 = null,
    prev_number: ?i64 = null,
    @"type": ?[]const u8 = null,
    first_number: ?i64 = null,
};

pub const SLOHistoryMonitor = struct {
    error_budget_remaining: ?SLOErrorBudgetRemainingData = null,
    group: ?[]const u8 = null,
    monitor_type: ?[]const u8 = null,
    errors: ?[]const std.json.Value = null,
    precision: ?f64 = null,
    sli_value: ?f64 = null,
    uptime: ?f64 = null,
    span_precision: ?f64 = null,
    preview: ?bool = null,
    history: ?[]const std.json.Value = null,
    name: ?[]const u8 = null,
    monitor_modified: ?i64 = null,
};

pub const SyntheticsUptime = struct {
    span_precision: ?f64 = null,
    group: ?[]const u8 = null,
    uptime: ?f64 = null,
    errors: ?[]const std.json.Value = null,
    history: ?[]const std.json.Value = null,
};

pub const SyntheticsTestRequestProxy = struct {
    url: []const u8,
    headers: ?SyntheticsTestHeaders = null,
};

pub const LogsByRetentionOrgs = struct {
    usage: ?[]const std.json.Value = null,
};

pub const HostMapWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    group: ?[]const []const u8 = null,
    requests: HostMapWidgetDefinitionRequests,
    title_align: ?WidgetTextAlign = null,
    style: ?HostMapWidgetDefinitionStyle = null,
    no_metric_hosts: ?bool = null,
    scope: ?[]const []const u8 = null,
    no_group_hosts: ?bool = null,
    title_size: ?[]const u8 = null,
    node_type: ?WidgetNodeType = null,
    notes: ?[]const u8 = null,
    @"type": HostMapWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const MonthlyUsageAttributionMetadata = struct {
    aggregates: ?UsageAttributionAggregates = null,
    pagination: ?MonthlyUsageAttributionPagination = null,
};

pub const AlertGraphWidgetDefinition = struct {
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    viz_type: WidgetVizType,
    time: ?WidgetTime = null,
    alert_id: []const u8,
    @"type": AlertGraphWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const SyntheticsAPIWaitStep = struct {
    subtype: SyntheticsAPIWaitStepSubtype,
    value: i64,
    id: ?[]const u8 = null,
    name: []const u8,
};

pub const SyntheticsMobileStepParamsElement = struct {
    context: ?[]const u8 = null,
    textContent: ?[]const u8 = null,
    multiLocator: ?std.json.Value = null,
    elementDescription: ?[]const u8 = null,
    userLocator: ?SyntheticsMobileStepParamsElementUserLocator = null,
    viewName: ?[]const u8 = null,
    relativePosition: ?SyntheticsMobileStepParamsElementRelativePosition = null,
    contextType: ?SyntheticsMobileStepParamsElementContextType = null,
};

pub const WidgetFormula = struct {
    conditional_formats: ?[]const std.json.Value = null,
    number_format: ?WidgetNumberFormat = null,
    formula: []const u8,
    limit: ?WidgetFormulaLimit = null,
    alias: ?[]const u8 = null,
    cell_display_mode_options: ?WidgetFormulaCellDisplayModeOptions = null,
    style: ?WidgetFormulaStyle = null,
    cell_display_mode: ?TableWidgetCellDisplayMode = null,
};

pub const MonitorState = struct {
    groups: ?std.json.Value = null,
};

pub const SyntheticsAssertionJSONPathTarget = struct {
    property: ?[]const u8 = null,
    target: ?SyntheticsAssertionJSONPathTargetTarget = null,
    operator: SyntheticsAssertionJSONPathOperator,
    @"type": SyntheticsAssertionType,
};

pub const AWSLogsListResponse = struct {
    account_id: ?[]const u8 = null,
    services: ?[]const []const u8 = null,
    lambdas: ?[]const std.json.Value = null,
};

pub const CanceledDowntimesIds = struct {
    cancelled_ids: ?[]const i64 = null,
};

pub const ListStreamWidgetDefinition = struct {
    requests: []const std.json.Value,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    legend_size: ?WidgetLegendSize = null,
    time: ?WidgetTime = null,
    show_legend: ?bool = null,
    @"type": ListStreamWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const SearchSLOTimeframe = struct {
};

pub const SyntheticsBatchResult = struct {
    execution_rule: ?SyntheticsTestExecutionRule = null,
    duration: ?f64 = null,
    location: ?[]const u8 = null,
    device: ?SyntheticsDeviceID = null,
    test_name: ?[]const u8 = null,
    status: ?SyntheticsBatchStatus = null,
    retries: ?f64 = null,
    test_type: ?SyntheticsTestDetailsType = null,
    result_id: ?[]const u8 = null,
    test_public_id: ?[]const u8 = null,
};

pub const UsageTopAvgMetricsPagination = struct {
    limit: ?i64 = null,
    next_record_id: ?[]const u8 = null,
    total_number_of_records: ?i64 = null,
};

pub const OrganizationResponse = struct {
    org: ?Organization = null,
};

pub const NotebookCellCreateRequest = struct {
    attributes: NotebookCellCreateRequestAttributes,
    @"type": NotebookCellResourceType,
};

pub const ApplicationKey = struct {
    hash: ?[]const u8 = null,
    name: ?[]const u8 = null,
    owner: ?[]const u8 = null,
};

pub const SearchSLOResponseDataAttributesFacets = struct {
    slo_type: ?[]const std.json.Value = null,
    all_tags: ?[]const std.json.Value = null,
    creator_name: ?[]const std.json.Value = null,
    target: ?[]const std.json.Value = null,
    timeframe: ?[]const std.json.Value = null,
    env_tags: ?[]const std.json.Value = null,
    service_tags: ?[]const std.json.Value = null,
    team_tags: ?[]const std.json.Value = null,
};

pub const MonitorOptionsSchedulingOptions = struct {
    evaluation_window: ?MonitorOptionsSchedulingOptionsEvaluationWindow = null,
    custom_schedule: ?MonitorOptionsCustomSchedule = null,
};

pub const ToplistWidgetRequest = struct {
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?LogQueryDefinition = null,
    formulas: ?[]const std.json.Value = null,
    style: ?WidgetRequestStyle = null,
    q: ?[]const u8 = null,
    audit_query: ?LogQueryDefinition = null,
    sort: ?WidgetSortBy = null,
    queries: ?[]const std.json.Value = null,
    conditional_formats: ?[]const std.json.Value = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
};

pub const WidgetLineType = struct {
};

pub const WidgetStyle = struct {
    palette: ?[]const u8 = null,
};

pub const SyntheticsPrivateLocationSecretsConfigDecryption = struct {
    key: ?[]const u8 = null,
};

pub const ViewingPreferences = struct {
    high_density: ?bool = null,
    theme: ?ViewingPreferencesTheme = null,
};

pub const WidgetEvent = struct {
    tags_execution: ?[]const u8 = null,
    q: []const u8,
};

pub const FormulaAndFunctionSLOGroupMode = struct {
};

pub const LogsDateRemapperType = struct {
};

pub const AccessRole = struct {
};

pub const ScatterplotTableRequest = struct {
    formulas: ?[]const std.json.Value = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    queries: ?[]const std.json.Value = null,
};

pub const LogContent = struct {
    timestamp: ?[]const u8 = null,
    tags: ?[]const []const u8 = null,
    host: ?[]const u8 = null,
    service: ?[]const u8 = null,
    attributes: ?std.json.Value = null,
    message: ?[]const u8 = null,
};

pub const SLOCorrectionUpdateRequestAttributes = struct {
    duration: ?i64 = null,
    rrule: ?[]const u8 = null,
    timezone: ?[]const u8 = null,
    description: ?[]const u8 = null,
    category: ?SLOCorrectionCategory = null,
    start: ?i64 = null,
    end: ?i64 = null,
};

pub const UsageSortDirection = struct {
};

pub const SyntheticsMobileStep = struct {
    isCritical: ?bool = null,
    hasNewStepElement: ?bool = null,
    timeout: ?i64 = null,
    params: SyntheticsMobileStepParams,
    allowFailure: ?bool = null,
    noScreenshot: ?bool = null,
    name: []const u8,
    publicId: ?[]const u8 = null,
    @"type": SyntheticsMobileStepType,
};

pub const TimeseriesWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    markers: ?[]const std.json.Value = null,
    requests: []const std.json.Value,
    title_align: ?WidgetTextAlign = null,
    show_legend: ?bool = null,
    time: ?WidgetTime = null,
    events: ?[]const std.json.Value = null,
    yaxis: ?WidgetAxis = null,
    legend_layout: ?TimeseriesWidgetLegendLayout = null,
    legend_columns: ?[]const std.json.Value = null,
    title_size: ?[]const u8 = null,
    legend_size: ?WidgetLegendSize = null,
    right_yaxis: ?WidgetAxis = null,
    title: ?[]const u8 = null,
    @"type": TimeseriesWidgetDefinitionType,
};

pub const AWSEventBridgeDeleteRequest = struct {
    account_id: ?[]const u8 = null,
    event_generator_name: ?[]const u8 = null,
    region: ?[]const u8 = null,
};

pub const HostMuteResponse = struct {
    action: ?[]const u8 = null,
    message: ?[]const u8 = null,
    end: ?i64 = null,
    hostname: ?[]const u8 = null,
};

pub const LogsAPILimitReachedResponse = struct {
    @"error": ?LogsAPIError = null,
};

pub const SyntheticsBasicAuthWeb = struct {
    password: ?[]const u8 = null,
    username: ?[]const u8 = null,
    @"type": ?SyntheticsBasicAuthWebType = null,
};

pub const LogsArrayProcessorOperationAppendType = struct {
};

pub const WidgetServiceSummaryDisplayFormat = struct {
};

pub const WebhooksIntegrationEncoding = struct {
};

pub const UsageSpecifiedCustomReportsResponse = struct {
    data: ?UsageSpecifiedCustomReportsData = null,
    meta: ?UsageSpecifiedCustomReportsMeta = null,
};

pub const CheckCanDeleteSLOResponseData = struct {
    ok: ?[]const []const u8 = null,
};

pub const ApiKey = struct {
    key: ?[]const u8 = null,
    created_by: ?[]const u8 = null,
    created: ?[]const u8 = null,
    name: ?[]const u8 = null,
};

pub const SyntheticsAssertionXPathTargetTarget = struct {
    xPath: ?[]const u8 = null,
    targetValue: ?SyntheticsAssertionTargetValue = null,
    operator: ?[]const u8 = null,
};

pub const FunnelStep = struct {
    value: []const u8,
    facet: []const u8,
};

pub const SyntheticsBrowserTestFailureCode = struct {
};

pub const LogsIndexListResponse = struct {
    indexes: ?[]const std.json.Value = null,
};

pub const SyntheticsTestOptionsHTTPVersion = struct {
};

pub const LogsListResponse = struct {
    status: ?[]const u8 = null,
    logs: ?[]const std.json.Value = null,
    nextLogId: ?[]const u8 = null,
};

pub const LogsArrayProcessorOperation = struct {
};

pub const SunburstWidgetLegendTable = struct {
    @"type": SunburstWidgetLegendTableType,
};

pub const HostTags = struct {
    tags: ?[]const []const u8 = null,
    host: ?[]const u8 = null,
};

pub const RunWorkflowWidgetDefinitionType = struct {
};

pub const UsageOnlineArchiveHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    online_archive_events_count: ?i64 = null,
};

pub const AWSAccountAndLambdaRequest = struct {
    lambda_arn: []const u8,
    account_id: []const u8,
};

pub const SyntheticsBasicAuthOauthROP = struct {
    password: []const u8,
    accessTokenUrl: []const u8,
    scope: ?[]const u8 = null,
    clientSecret: ?[]const u8 = null,
    username: []const u8,
    clientId: ?[]const u8 = null,
    tokenApiAuthentication: SyntheticsBasicAuthOauthTokenApiAuthentication,
    resource: ?[]const u8 = null,
    @"type": SyntheticsBasicAuthOauthROPType,
    audience: ?[]const u8 = null,
};

pub const OrganizationSettingsSaml = struct {
    enabled: ?bool = null,
};

pub const SearchSLOResponseDataAttributesFacetsObjectString = struct {
    name: ?[]const u8 = null,
    count: ?i64 = null,
};

pub const NotebookCellUpdateRequestAttributes = struct {
};

pub const SLODeleteResponse = struct {
    data: ?[]const []const u8 = null,
    errors: ?std.json.Value = null,
};

pub const SyntheticsTriggerTest = struct {
    metadata: ?SyntheticsCIBatchMetadata = null,
    public_id: []const u8,
};

pub const UsageIoTResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const BarChartWidgetFlat = struct {
    @"type": BarChartWidgetFlatType,
};

pub const AzureAccountListResponse = struct {
};

pub const HostTotals = struct {
    total_active: ?i64 = null,
    total_up: ?i64 = null,
};

pub const MonitorGroupSearchResponseCounts = struct {
    status: ?MonitorSearchCount = null,
    @"type": ?MonitorSearchCount = null,
};

pub const LogsByRetention = struct {
    usage: ?[]const std.json.Value = null,
    orgs: ?LogsByRetentionOrgs = null,
    usage_by_month: ?LogsByRetentionMonthlyUsage = null,
};

pub const SyntheticsBrowserError = struct {
    status: ?i64 = null,
    description: []const u8,
    name: []const u8,
    @"type": SyntheticsBrowserErrorType,
};

pub const SyntheticsMobileStepParamsDirection = struct {
};

pub const HeatMapWidgetRequest = struct {
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?EventQueryDefinition = null,
    formulas: ?[]const std.json.Value = null,
    request_type: ?WidgetHistogramRequestType = null,
    style: ?WidgetStyle = null,
    q: ?[]const u8 = null,
    queries: ?[]const std.json.Value = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
    query: ?FormulaAndFunctionMetricQueryDefinition = null,
};

pub const SyntheticsTestRequest = struct {
    servername: ?[]const u8 = null,
    url: ?[]const u8 = null,
    httpVersion: ?SyntheticsTestOptionsHTTPVersion = null,
    noSavingResponseBody: ?bool = null,
    dnsServerPort: ?SyntheticsTestRequestDNSServerPort = null,
    disableAiaIntermediateFetching: ?bool = null,
    follow_redirects: ?bool = null,
    dnsServer: ?[]const u8 = null,
    checkCertificateRevocation: ?bool = null,
    files: ?[]const std.json.Value = null,
    host: ?[]const u8 = null,
    persistCookies: ?bool = null,
    allow_insecure: ?bool = null,
    bodyType: ?SyntheticsTestRequestBodyType = null,
    metadata: ?SyntheticsTestMetadata = null,
    body: ?[]const u8 = null,
    basicAuth: ?SyntheticsBasicAuth = null,
    form: ?std.json.Value = null,
    isMessageBase64Encoded: ?bool = null,
    certificateDomains: ?[]const []const u8 = null,
    service: ?[]const u8 = null,
    port: ?SyntheticsTestRequestPort = null,
    timeout: ?f64 = null,
    certificate: ?SyntheticsTestRequestCertificate = null,
    compressedJsonDescriptor: ?[]const u8 = null,
    method: ?[]const u8 = null,
    headers: ?SyntheticsTestHeaders = null,
    proxy: ?SyntheticsTestRequestProxy = null,
    shouldTrackHops: ?bool = null,
    compressedProtoFile: ?[]const u8 = null,
    callType: ?SyntheticsTestCallType = null,
    message: ?[]const u8 = null,
    query: ?std.json.Value = null,
    numberOfPackets: ?i64 = null,
};

pub const HeatMapWidgetXAxis = struct {
    num_buckets: ?i64 = null,
};

pub const NotebookToplistCellAttributes = struct {
    graph_size: ?NotebookGraphSize = null,
    split_by: ?NotebookSplitBy = null,
    time: ?NotebookCellTime = null,
    definition: ToplistWidgetDefinition,
};

pub const UsageSyntheticsAPIResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const SLOResponseData = struct {
    created_at: ?i64 = null,
    configured_alert_ids: ?[]const i64 = null,
    warning_threshold: ?f64 = null,
    timeframe: ?SLOTimeframe = null,
    monitor_tags: ?[]const []const u8 = null,
    creator: ?Creator = null,
    id: ?[]const u8 = null,
    modified_at: ?i64 = null,
    target_threshold: ?f64 = null,
    groups: ?[]const []const u8 = null,
    tags: ?[]const []const u8 = null,
    thresholds: ?[]const std.json.Value = null,
    description: ?[]const u8 = null,
    monitor_ids: ?[]const i64 = null,
    name: ?[]const u8 = null,
    @"type": ?SLOType = null,
    query: ?ServiceLevelObjectiveQuery = null,
    sli_specification: ?SLOSliSpec = null,
};

pub const SLOHistoryMetricsSeries = struct {
    sum: f64,
    metadata: ?SLOHistoryMetricsSeriesMetadata = null,
    values: []const f64,
    count: i64,
};

pub const UsageSNMPResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const NotebookResponse = struct {
    data: ?NotebookResponseData = null,
};

pub const UsageIndexedSpansHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    indexed_events_count: ?i64 = null,
};

pub const SyntheticsMobileTestsMobileApplicationReferenceType = struct {
};

pub const NotebooksResponseMeta = struct {
    page: ?NotebooksResponsePage = null,
};

pub const SyntheticsDeleteTestsPayload = struct {
    public_ids: ?[]const []const u8 = null,
    force_delete_dependencies: ?bool = null,
};

pub const EventTimelineWidgetDefinitionType = struct {
};

pub const Creator = struct {
    handle: ?[]const u8 = null,
    email: ?[]const u8 = null,
    name: ?[]const u8 = null,
};

pub const DashboardType = struct {
};

pub const FormulaAndFunctionCloudCostQueryDefinition = struct {
    data_source: FormulaAndFunctionCloudCostDataSource,
    aggregator: ?WidgetAggregator = null,
    cross_org_uuids: ?CrossOrgUuids = null,
    name: []const u8,
    query: []const u8,
};

pub const MonitorSummaryWidgetDefinitionType = struct {
};

pub const SLOListResponse = struct {
    data: ?[]const std.json.Value = null,
    metadata: ?SLOListResponseMetadata = null,
    errors: ?[]const []const u8 = null,
};

pub const Pagination = struct {
    total_count: ?i64 = null,
    total_filtered_count: ?i64 = null,
};

pub const LogStreamWidgetDefinition = struct {
    query: ?[]const u8 = null,
    message_display: ?WidgetMessageDisplay = null,
    title_align: ?WidgetTextAlign = null,
    time: ?WidgetTime = null,
    show_message_column: ?bool = null,
    sort: ?WidgetFieldSort = null,
    columns: ?[]const []const u8 = null,
    logset: ?[]const u8 = null,
    title_size: ?[]const u8 = null,
    show_date_column: ?bool = null,
    @"type": LogStreamWidgetDefinitionType,
    title: ?[]const u8 = null,
    indexes: ?[]const []const u8 = null,
};

pub const DistributionPointsPayload = struct {
    series: []const std.json.Value,
};

pub const ToplistWidgetDefinitionType = struct {
};

pub const AWSLogsLambda = struct {
    arn: ?[]const u8 = null,
};

pub const SyntheticsMobileStepType = struct {
};

pub const TopologyRequest = struct {
    query: ?TopologyQuery = null,
    request_type: ?TopologyRequestType = null,
};

pub const UsageNetworkHostsHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    host_count: ?i64 = null,
};

pub const TableWidgetCellDisplayMode = struct {
};

pub const TimeseriesBackgroundType = struct {
};

pub const TableWidgetTextFormatMatch = struct {
    value: []const u8,
    @"type": TableWidgetTextFormatMatchType,
};

pub const SyntheticsAssertionOperator = struct {
};

pub const ListStreamSource = struct {
};

pub const UsageAuditLogsResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const ViewingPreferencesTheme = struct {
};

pub const MonitorOptionsSchedulingOptionsEvaluationWindow = struct {
    hour_starts: ?i64 = null,
    day_starts: ?[]const u8 = null,
    month_starts: ?i64 = null,
    timezone: ?[]const u8 = null,
};

pub const SLOListWidgetRequest = struct {
    query: SLOListWidgetQuery,
    request_type: SLOListWidgetRequestType,
};

pub const LogsArrayProcessorOperationSelect = struct {
    source: []const u8,
    filter: []const u8,
    target: []const u8,
    value_to_extract: []const u8,
    @"type": LogsArrayProcessorOperationSelectType,
};

pub const DistributionPointsSeries = struct {
    tags: ?[]const []const u8 = null,
    host: ?[]const u8 = null,
    @"type": ?DistributionPointsType = null,
    points: []const std.json.Value,
    metric: []const u8,
};

pub const SyntheticsSSLCertificateIssuer = struct {
    OU: ?[]const u8 = null,
    C: ?[]const u8 = null,
    L: ?[]const u8 = null,
    ST: ?[]const u8 = null,
    O: ?[]const u8 = null,
    CN: ?[]const u8 = null,
};

pub const SignalArchiveReason = struct {
};

pub const ScatterplotWidgetFormula = struct {
    alias: ?[]const u8 = null,
    formula: []const u8,
    dimension: ScatterplotDimension,
};

pub const WidgetMessageDisplay = struct {
};

pub const UsageCustomReportsAttributes = struct {
    size: ?i64 = null,
    end_date: ?[]const u8 = null,
    start_date: ?[]const u8 = null,
    tags: ?[]const []const u8 = null,
    computed_on: ?[]const u8 = null,
};

pub const MonitorFormulaAndFunctionCostDataSource = struct {
};

pub const SLOCorrectionResponseAttributes = struct {
    created_at: ?i64 = null,
    modified_at: ?i64 = null,
    duration: ?i64 = null,
    rrule: ?[]const u8 = null,
    modifier: ?SLOCorrectionResponseAttributesModifier = null,
    timezone: ?[]const u8 = null,
    description: ?[]const u8 = null,
    category: ?SLOCorrectionCategory = null,
    start: ?i64 = null,
    creator: ?Creator = null,
    slo_id: ?[]const u8 = null,
    end: ?i64 = null,
};

pub const UsageNetworkFlowsHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    indexed_events_count: ?i64 = null,
};

pub const UsageLogsHour = struct {
    billable_ingested_bytes: ?i64 = null,
    hour: ?[]const u8 = null,
    logs_rehydrated_ingested_bytes: ?i64 = null,
    ingested_events_bytes: ?i64 = null,
    indexed_events_count: ?i64 = null,
    org_name: ?[]const u8 = null,
    logs_live_indexed_count: ?i64 = null,
    logs_live_ingested_bytes: ?i64 = null,
    logs_forwarding_events_bytes: ?i64 = null,
    public_id: ?[]const u8 = null,
    logs_rehydrated_indexed_count: ?i64 = null,
};

pub const WidgetFormulaCellDisplayModeOptionsYScale = struct {
};

pub const SyntheticsGlobalVariable = struct {
    tags: []const []const u8,
    parse_test_options: ?SyntheticsGlobalVariableParseTestOptions = null,
    is_fido: ?bool = null,
    parse_test_public_id: ?[]const u8 = null,
    value: SyntheticsGlobalVariableValue,
    description: []const u8,
    is_totp: ?bool = null,
    id: ?[]const u8 = null,
    attributes: ?SyntheticsGlobalVariableAttributes = null,
    name: []const u8,
};

pub const SyntheticsTestOptionsRetry = struct {
    interval: ?f64 = null,
    count: ?i64 = null,
};

pub const LogsPipelineProcessorType = struct {
};

pub const SLORawErrorBudgetRemaining = struct {
    value: ?f64 = null,
    unit: ?[]const u8 = null,
};

pub const SignalAssigneeUpdateRequest = struct {
    assignee: []const u8,
    version: ?Version = null,
};

pub const SyntheticsAssertionJSONPathTargetTarget = struct {
    elementsOperator: ?[]const u8 = null,
    jsonPath: ?[]const u8 = null,
    operator: ?[]const u8 = null,
    targetValue: ?SyntheticsAssertionTargetValue = null,
};

pub const TableWidgetDefinitionType = struct {
};

pub const DashboardBulkDeleteRequest = struct {
    data: DashboardBulkActionDataList,
};

pub const LogsPipelinesOrder = struct {
    pipeline_ids: []const []const u8,
};

pub const HostListResponse = struct {
    total_returned: ?i64 = null,
    total_matching: ?i64 = null,
    host_list: ?[]const std.json.Value = null,
};

pub const SyntheticsListGlobalVariablesResponse = struct {
    variables: ?[]const std.json.Value = null,
};

pub const DistributionWidgetHistogramRequestQuery = struct {
};

pub const MonitorAssetCategory = struct {
};

pub const SyntheticsMobileTestOptions = struct {
    ci: ?SyntheticsTestCiOptions = null,
    allowApplicationCrash: ?bool = null,
    bindings: ?[]const std.json.Value = null,
    monitor_options: ?SyntheticsTestOptionsMonitorOptions = null,
    monitor_name: ?[]const u8 = null,
    disableAutoAcceptAlert: ?bool = null,
    scheduling: ?SyntheticsTestOptionsScheduling = null,
    monitor_priority: ?i64 = null,
    defaultStepTimeout: ?i64 = null,
    verbosity: ?i64 = null,
    tick_every: i64,
    retry: ?SyntheticsTestOptionsRetry = null,
    restricted_roles: ?SyntheticsRestrictedRoles = null,
    noScreenshot: ?bool = null,
    device_ids: []const std.json.Value,
    min_failure_duration: ?i64 = null,
    mobileApplication: SyntheticsMobileTestsMobileApplication,
};

pub const DistributionWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    markers: ?[]const std.json.Value = null,
    requests: []const std.json.Value,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    show_legend: ?bool = null,
    time: ?WidgetTime = null,
    legend_size: ?[]const u8 = null,
    xaxis: ?DistributionWidgetXAxis = null,
    yaxis: ?DistributionWidgetYAxis = null,
    @"type": DistributionWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const SignalStateUpdateRequest = struct {
    archiveReason: ?SignalArchiveReason = null,
    archiveComment: ?[]const u8 = null,
    state: SignalTriageState,
    version: ?Version = null,
};

pub const MonitorAsset = struct {
    category: MonitorAssetCategory,
    resource_key: ?[]const u8 = null,
    name: []const u8,
    resource_type: ?MonitorAssetResourceType = null,
    url: []const u8,
};

pub const SyntheticsBasicAuthWebType = struct {
};

pub const WidgetHistogramRequestType = struct {
};

pub const SyntheticsSSLCertificate = struct {
    modulus: ?[]const u8 = null,
    validFrom: ?[]const u8 = null,
    extKeyUsage: ?[]const []const u8 = null,
    fingerprint256: ?[]const u8 = null,
    exponent: ?f64 = null,
    cipher: ?[]const u8 = null,
    fingerprint: ?[]const u8 = null,
    issuer: ?SyntheticsSSLCertificateIssuer = null,
    protocol: ?[]const u8 = null,
    validTo: ?[]const u8 = null,
    subject: ?SyntheticsSSLCertificateSubject = null,
    serialNumber: ?[]const u8 = null,
};

pub const UsageAnalyzedLogsHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    analyzed_logs: ?i64 = null,
};

pub const SearchSLOResponseDataAttributes = struct {
    slos: ?[]const std.json.Value = null,
    facets: ?SearchSLOResponseDataAttributesFacets = null,
};

pub const WidgetNewLiveSpan = struct {
    hide_incomplete_cost_data: ?bool = null,
    value: i64,
    @"type": WidgetNewLiveSpanType,
    unit: WidgetLiveSpanUnit,
};

pub const AuthenticationValidationResponse = struct {
    valid: ?bool = null,
};

pub const SyntheticsLocation = struct {
    id: ?[]const u8 = null,
    name: ?[]const u8 = null,
};

pub const IPRanges = struct {
    modified: ?[]const u8 = null,
    version: ?i64 = null,
    global: ?IPPrefixesGlobal = null,
    @"synthetics-private-locations": ?IPPrefixesSyntheticsPrivateLocations = null,
    logs: ?IPPrefixesLogs = null,
    process: ?IPPrefixesProcess = null,
    apm: ?IPPrefixesAPM = null,
    api: ?IPPrefixesAPI = null,
    agents: ?IPPrefixesAgents = null,
    @"remote-configuration": ?IPPrefixesRemoteConfiguration = null,
    synthetics: ?IPPrefixesSynthetics = null,
    orchestrator: ?IPPrefixesOrchestrator = null,
    webhooks: ?IPPrefixesWebhooks = null,
};

pub const MonthlyUsageAttributionPagination = struct {
    next_record_id: ?[]const u8 = null,
};

pub const TargetFormatType = struct {
};

pub const ServiceChecks = struct {
};

pub const SharedDashboardUpdateRequestGlobalTime = struct {
    live_span: ?DashboardGlobalTimeLiveSpan = null,
};

pub const LogsSpanRemapperType = struct {
};

pub const SyntheticsPatchTestOperation = struct {
    value: ?[]const u8 = null,
    op: ?SyntheticsPatchTestOperationName = null,
    path: ?[]const u8 = null,
};

pub const SyntheticsPrivateLocation = struct {
    description: []const u8,
    tags: []const []const u8,
    metadata: ?SyntheticsPrivateLocationMetadata = null,
    id: ?[]const u8 = null,
    name: []const u8,
    secrets: ?SyntheticsPrivateLocationSecrets = null,
};

pub const UsageCloudSecurityPostureManagementHour = struct {
    aas_host_count: ?f64 = null,
    gcp_host_count: ?f64 = null,
    hour: ?[]const u8 = null,
    azure_host_count: ?f64 = null,
    container_count: ?f64 = null,
    host_count: ?f64 = null,
    org_name: ?[]const u8 = null,
    compliance_host_count: ?f64 = null,
    public_id: ?[]const u8 = null,
    aws_host_count: ?f64 = null,
};

pub const UsageIoTHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    iot_device_count: ?i64 = null,
};

pub const LogsSchemaProcessorType = struct {
};

pub const DistributionPointsType = struct {
};

pub const UsageBillableSummaryHour = struct {
    num_orgs: ?i64 = null,
    end_date: ?[]const u8 = null,
    ratio_in_month: ?f64 = null,
    region: ?[]const u8 = null,
    account_name: ?[]const u8 = null,
    org_name: ?[]const u8 = null,
    start_date: ?[]const u8 = null,
    account_public_id: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    usage: ?UsageBillableSummaryKeys = null,
    billing_plan: ?[]const u8 = null,
};

pub const ApplicationKeyResponse = struct {
    application_key: ?ApplicationKey = null,
};

pub const UsageSDSResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const BarChartWidgetFlatType = struct {
};

pub const HostMapWidgetDefinitionRequests = struct {
    size: ?HostMapRequest = null,
    fill: ?HostMapRequest = null,
};

pub const UsageTopAvgMetricsMetadata = struct {
    day: ?[]const u8 = null,
    month: ?[]const u8 = null,
    pagination: ?UsageTopAvgMetricsPagination = null,
};

pub const GroupType = struct {
};

pub const UsageCustomReportsMeta = struct {
    page: ?UsageCustomReportsPage = null,
};

pub const UsageLambdaResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const DashboardTemplateVariablePreset = struct {
    name: ?[]const u8 = null,
    template_variables: ?[]const std.json.Value = null,
};

pub const SLOErrorTimeframe = struct {
};

pub const ServiceLevelObjectiveQuery = struct {
    numerator: []const u8,
    denominator: []const u8,
};

pub const WidgetDefinition = struct {
};

pub const SLOHistoryMetricsSeriesMetadata = struct {
    scope: ?[]const u8 = null,
    aggr: ?[]const u8 = null,
    query_index: ?i64 = null,
    expression: ?[]const u8 = null,
    unit: ?[]const std.json.Value = null,
    metric: ?[]const u8 = null,
};

pub const WidgetLineWidth = struct {
};

pub const SearchSLOResponseDataAttributesFacetsObjectInt = struct {
    name: ?f64 = null,
    count: ?i64 = null,
};

pub const SyntheticsPatchTestBody = struct {
    data: ?[]const std.json.Value = null,
};

pub const SplitConfig = struct {
    limit: i64,
    split_dimensions: []const std.json.Value,
    static_splits: ?[]const std.json.Value = null,
    sort: SplitSort,
};

pub const LogsArrayProcessorOperationSelectType = struct {
};

pub const SyntheticsAssertionBodyHashTarget = struct {
    target: SyntheticsAssertionTargetValue,
    operator: SyntheticsAssertionBodyHashOperator,
    @"type": SyntheticsAssertionBodyHashType,
};

pub const SyntheticsStepType = struct {
};

pub const SyntheticsGlobalVariableTOTPParameters = struct {
    digits: ?i64 = null,
    refresh_interval: ?i64 = null,
};

pub const SyntheticsBasicAuthOauthTokenApiAuthentication = struct {
};

pub const CheckCanDeleteMonitorResponseData = struct {
    ok: ?[]const i64 = null,
};

pub const LogsProcessor = struct {
};

pub const QueryValueWidgetRequest = struct {
    aggregator: ?WidgetAggregator = null,
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?LogQueryDefinition = null,
    formulas: ?[]const std.json.Value = null,
    q: ?[]const u8 = null,
    audit_query: ?LogQueryDefinition = null,
    queries: ?[]const std.json.Value = null,
    conditional_formats: ?[]const std.json.Value = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
};

pub const GeomapWidgetRequestStyle = struct {
    color_by: ?[]const u8 = null,
};

pub const DistributionPoint = struct {
};

pub const SLOTypeNumeric = struct {
};

pub const DashboardShareType = struct {
};

pub const TableWidgetRequest = struct {
    aggregator: ?WidgetAggregator = null,
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?LogQueryDefinition = null,
    formulas: ?[]const std.json.Value = null,
    text_formats: ?[]const std.json.Value = null,
    cell_display_mode: ?[]const std.json.Value = null,
    q: ?[]const u8 = null,
    sort: ?WidgetSortBy = null,
    queries: ?[]const std.json.Value = null,
    apm_stats_query: ?ApmStatsQueryDefinition = null,
    conditional_formats: ?[]const std.json.Value = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
    limit: ?i64 = null,
    alias: ?[]const u8 = null,
    order: ?WidgetSort = null,
};

pub const SyntheticsAPITestType = struct {
};

pub const WidgetComparator = struct {
};

pub const WidgetGroupSort = struct {
    order: WidgetSort,
    name: []const u8,
    @"type": GroupType,
};

pub const DeleteSharedDashboardResponse = struct {
    deleted_public_dashboard_token: ?[]const u8 = null,
};

pub const UsageAttributionAggregates = struct {
};

pub const ChangeWidgetDefinitionType = struct {
};

pub const LogQueryDefinitionGroupBy = struct {
    limit: ?i64 = null,
    facet: []const u8,
    sort: ?LogQueryDefinitionGroupBySort = null,
};

pub const FreeTextWidgetDefinitionType = struct {
};

pub const SLOOverallStatuses = struct {
    @"error": ?[]const u8 = null,
    error_budget_remaining: ?f64 = null,
    indexed_at: ?i64 = null,
    state: ?SLOState = null,
    target: ?f64 = null,
    span_precision: ?i64 = null,
    status: ?f64 = null,
    timeframe: ?SLOTimeframe = null,
    raw_error_budget_remaining: ?SLORawErrorBudgetRemaining = null,
};

pub const SyntheticsLocalVariableParsingOptionsType = struct {
};

pub const SyntheticsBatchDetailsData = struct {
    status: ?SyntheticsBatchStatus = null,
    results: ?[]const std.json.Value = null,
    metadata: ?SyntheticsCIBatchMetadata = null,
};

pub const ToplistWidgetFlat = struct {
    @"type": ToplistWidgetFlatType,
};

pub const WidgetAxis = struct {
    include_zero: ?bool = null,
    label: ?[]const u8 = null,
    max: ?[]const u8 = null,
    scale: ?[]const u8 = null,
    min: ?[]const u8 = null,
};

pub const TopologyQueryDataSource = struct {
};

pub const SLOErrorBudgetRemainingData = struct {
};

pub const UsageHostsResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const MetricsQueryUnit = struct {
    scale_factor: ?f64 = null,
    plural: ?[]const u8 = null,
    name: ?[]const u8 = null,
    short_name: ?[]const u8 = null,
    family: ?[]const u8 = null,
};

pub const BarChartWidgetRequest = struct {
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?LogQueryDefinition = null,
    formulas: ?[]const std.json.Value = null,
    style: ?WidgetRequestStyle = null,
    q: ?[]const u8 = null,
    audit_query: ?LogQueryDefinition = null,
    sort: ?WidgetSortBy = null,
    queries: ?[]const std.json.Value = null,
    conditional_formats: ?[]const std.json.Value = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
};

pub const WidgetTimeWindows = struct {
};

pub const SyntheticsTestRequestPort = struct {
};

pub const MonitorSummaryWidgetDefinition = struct {
    title_align: ?WidgetTextAlign = null,
    count: ?i64 = null,
    start: ?i64 = null,
    sort: ?WidgetMonitorSummarySort = null,
    color_preference: ?WidgetColorPreference = null,
    show_priority: ?bool = null,
    title_size: ?[]const u8 = null,
    display_format: ?WidgetMonitorSummaryDisplayFormat = null,
    summary_type: ?WidgetSummaryType = null,
    show_last_triggered: ?bool = null,
    hide_zero_counts: ?bool = null,
    query: []const u8,
    title: ?[]const u8 = null,
    @"type": MonitorSummaryWidgetDefinitionType,
};

pub const SyntheticsAPIStep = struct {
};

pub const DistributionWidgetXAxis = struct {
    min: ?[]const u8 = null,
    include_zero: ?bool = null,
    max: ?[]const u8 = null,
    scale: ?[]const u8 = null,
    num_buckets: ?i64 = null,
};

pub const WidgetFormulaLimit = struct {
    order: ?QuerySortOrder = null,
    count: ?i64 = null,
};

pub const NotebookMetadata = struct {
    take_snapshots: ?bool = null,
    is_template: ?bool = null,
    @"type": ?NotebookMetadataType = null,
};

pub const LogsAPIError = struct {
    details: ?[]const std.json.Value = null,
    message: ?[]const u8 = null,
    code: ?[]const u8 = null,
};

pub const WidgetLegendSize = struct {
};

pub const SyntheticsCheckType = struct {
};

pub const EventResponse = struct {
    status: ?[]const u8 = null,
    event: ?Event = null,
};

pub const AWSNamespace = struct {
};

pub const IPPrefixesAPI = struct {
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv6: ?[]const []const u8 = null,
};

pub const NotebookCellCreateRequestAttributes = struct {
};

pub const SyntheticsAPITestResultShortResult = struct {
    passed: ?bool = null,
    timings: ?SyntheticsTiming = null,
};

pub const SplitGraphVizSize = struct {
};

pub const UsageCIVisibilityResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const NotebookMarkdownCellDefinitionType = struct {
};

pub const TableWidgetTextFormat = struct {
};

pub const SyntheticsApiTestFailureCode = struct {
};

pub const FunnelQuery = struct {
    data_source: FunnelSource,
    query_string: []const u8,
    steps: []const std.json.Value,
};

pub const MonitorFormulaAndFunctionCostAggregator = struct {
};

pub const SLOBulkDelete = struct {
};

pub const OrgDowngradedResponse = struct {
    message: ?[]const u8 = null,
};

pub const IPPrefixesProcess = struct {
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv6: ?[]const []const u8 = null,
};

pub const SharedDashboardInvitesDataList = struct {
};

pub const LogsArithmeticProcessor = struct {
    is_enabled: ?bool = null,
    is_replace_missing: ?bool = null,
    name: ?[]const u8 = null,
    target: []const u8,
    @"type": LogsArithmeticProcessorType,
    expression: []const u8,
};

pub const Dashboard = struct {
    created_at: ?[]const u8 = null,
    author_name: ?[]const u8 = null,
    url: ?[]const u8 = null,
    notify_list: ?[]const []const u8 = null,
    template_variables: ?[]const std.json.Value = null,
    id: ?[]const u8 = null,
    template_variable_presets: ?[]const std.json.Value = null,
    modified_at: ?[]const u8 = null,
    tags: ?[]const []const u8 = null,
    is_read_only: ?bool = null,
    author_handle: ?[]const u8 = null,
    description: ?[]const u8 = null,
    layout_type: DashboardLayoutType,
    restricted_roles: ?[]const []const u8 = null,
    reflow_type: ?DashboardReflowType = null,
    title: []const u8,
    widgets: []const std.json.Value,
};

pub const HostMapWidgetDefinitionStyle = struct {
    palette: ?[]const u8 = null,
    fill_max: ?[]const u8 = null,
    palette_flip: ?bool = null,
    fill_min: ?[]const u8 = null,
};

pub const OrganizationCreateResponse = struct {
    application_key: ?ApplicationKey = null,
    org: ?Organization = null,
    api_key: ?ApiKey = null,
    user: ?User = null,
};

pub const LogsServiceRemapper = struct {
    name: ?[]const u8 = null,
    @"type": LogsServiceRemapperType,
    is_enabled: ?bool = null,
    sources: []const []const u8,
};

pub const MonitorSearchResponseMetadata = struct {
    page_count: ?i64 = null,
    page: ?i64 = null,
    per_page: ?i64 = null,
    total_count: ?i64 = null,
};

pub const PowerpackWidgetDefinition = struct {
    banner_img: ?[]const u8 = null,
    powerpack_id: []const u8,
    template_variables: ?PowerpackTemplateVariables = null,
    background_color: ?[]const u8 = null,
    show_title: ?bool = null,
    @"type": PowerpackWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const UserResponse = struct {
    user: ?User = null,
};

pub const LogsSchemaMapper = struct {
};

pub const MonitorOptionsAggregation = struct {
    group_by: ?[]const u8 = null,
    @"type": ?[]const u8 = null,
    metric: ?[]const u8 = null,
};

pub const NotebookUpdateData = struct {
    attributes: NotebookUpdateDataAttributes,
    @"type": NotebookResourceType,
};

pub const ListStreamWidgetDefinitionType = struct {
};

pub const TopologyQuery = struct {
    data_source: ?TopologyQueryDataSource = null,
    service: ?[]const u8 = null,
    filters: ?[]const []const u8 = null,
};

pub const SyntheticsBrowserTestResultFullCheck = struct {
    config: SyntheticsTestConfig,
};

pub const SignalTriageState = struct {
};

pub const SearchSLOResponse = struct {
    data: ?SearchSLOResponseData = null,
    links: ?SearchSLOResponseLinks = null,
    meta: ?SearchSLOResponseMeta = null,
};

pub const SyntheticsAssertionXPathTarget = struct {
    property: ?[]const u8 = null,
    target: ?SyntheticsAssertionXPathTargetTarget = null,
    operator: SyntheticsAssertionXPathOperator,
    @"type": SyntheticsAssertionType,
};

pub const UsageSNMPHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    snmp_devices: ?i64 = null,
    public_id: ?[]const u8 = null,
};

pub const EventCreateResponse = struct {
    status: ?[]const u8 = null,
    event: ?Event = null,
};

pub const FormulaAndFunctionApmDependencyStatName = struct {
};

pub const GCPMonitoredResourceConfigType = struct {
};

pub const MonitorFormulaAndFunctionQueryDefinition = struct {
};

pub const NotebookAbsoluteTime = struct {
    live: ?bool = null,
    start: []const u8,
    end: []const u8,
};

pub const AWSTagFilter = struct {
    tag_filter_str: ?[]const u8 = null,
    namespace: ?AWSNamespace = null,
};

pub const SyntheticsFetchUptimesPayload = struct {
    public_ids: []const []const u8,
    from_ts: i64,
    to_ts: i64,
};

pub const SunburstWidgetLegendInlineAutomaticType = struct {
};

pub const SyntheticsMobileStepParamsElementUserLocatorValuesItemsType = struct {
};

pub const SyntheticsPrivateLocationSecretsAuthentication = struct {
    id: ?[]const u8 = null,
    key: ?[]const u8 = null,
};

pub const SyntheticsUpdateTestPauseStatusPayload = struct {
    new_status: ?SyntheticsTestPauseStatus = null,
};

pub const UsageFargateResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const NotebookUpdateDataAttributes = struct {
    status: ?NotebookStatus = null,
    time: NotebookGlobalTime,
    metadata: ?NotebookMetadata = null,
    name: []const u8,
    cells: []const std.json.Value,
};

pub const SearchSLOQuery = struct {
    numerator: ?[]const u8 = null,
    denominator: ?[]const u8 = null,
    metrics: ?[]const []const u8 = null,
};

pub const TreeMapWidgetDefinition = struct {
    color_by: ?TreeMapColorBy = null,
    custom_links: ?[]const std.json.Value = null,
    group_by: ?TreeMapGroupBy = null,
    requests: []const std.json.Value,
    time: ?WidgetTime = null,
    size_by: ?TreeMapSizeBy = null,
    title: ?[]const u8 = null,
    @"type": TreeMapWidgetDefinitionType,
};

pub const TableWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    requests: []const std.json.Value,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    has_search_bar: ?TableWidgetHasSearchBar = null,
    time: ?WidgetTime = null,
    @"type": TableWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const SyntheticsTriggerCITestLocation = struct {
    id: ?i64 = null,
    name: ?[]const u8 = null,
};

pub const ServiceLevelObjectiveRequest = struct {
    groups: ?[]const []const u8 = null,
    tags: ?[]const []const u8 = null,
    warning_threshold: ?f64 = null,
    target_threshold: ?f64 = null,
    thresholds: []const std.json.Value,
    description: ?[]const u8 = null,
    monitor_ids: ?[]const i64 = null,
    timeframe: ?SLOTimeframe = null,
    name: []const u8,
    @"type": SLOType,
    query: ?ServiceLevelObjectiveQuery = null,
    sli_specification: ?SLOSliSpec = null,
};

pub const LogsSchemaProcessor = struct {
    mappers: []const std.json.Value,
    name: []const u8,
    schema: LogsSchemaData,
    is_enabled: ?bool = null,
    @"type": LogsSchemaProcessorType,
};

pub const GCPAccount = struct {
    project_id: ?[]const u8 = null,
    errors: ?[]const []const u8 = null,
    client_id: ?[]const u8 = null,
    cloud_run_revision_filters: ?[]const []const u8 = null,
    auth_uri: ?[]const u8 = null,
    host_filters: ?[]const u8 = null,
    is_resource_change_collection_enabled: ?bool = null,
    private_key: ?[]const u8 = null,
    private_key_id: ?[]const u8 = null,
    client_email: ?[]const u8 = null,
    monitored_resource_configs: ?[]const std.json.Value = null,
    client_x509_cert_url: ?[]const u8 = null,
    automute: ?bool = null,
    auth_provider_x509_cert_url: ?[]const u8 = null,
    is_security_command_center_enabled: ?bool = null,
    token_uri: ?[]const u8 = null,
    @"type": ?[]const u8 = null,
    is_cspm_enabled: ?bool = null,
    resource_collection_enabled: ?bool = null,
};

pub const PowerpackTemplateVariables = struct {
    controlled_externally: ?[]const std.json.Value = null,
    controlled_by_powerpack: ?[]const std.json.Value = null,
};

pub const SyntheticsTestRestrictionPolicyBindingPrincipals = struct {
};

pub const DistributionWidgetDefinitionType = struct {
};

pub const FormulaAndFunctionSLODataSource = struct {
};

pub const AgentCheck = struct {
};

pub const LogsQueryCompute = struct {
    interval: ?i64 = null,
    aggregation: []const u8,
    facet: ?[]const u8 = null,
};

pub const NotebookMarkdownCellAttributes = struct {
    definition: NotebookMarkdownCellDefinition,
};

pub const WidgetMonitorSummaryDisplayFormat = struct {
};

pub const QueryValueWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    precision: ?i64 = null,
    requests: []const std.json.Value,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    time: ?WidgetTime = null,
    custom_unit: ?[]const u8 = null,
    text_align: ?WidgetTextAlign = null,
    autoscale: ?bool = null,
    @"type": QueryValueWidgetDefinitionType,
    title: ?[]const u8 = null,
    timeseries_background: ?TimeseriesBackground = null,
};

pub const LogsCategoryProcessorType = struct {
};

pub const DistributionPointTimestamp = struct {
};

pub const LogsTraceRemapperType = struct {
};

pub const NotebookRelativeTime = struct {
    live_span: WidgetLiveSpan,
};

pub const SyntheticsTriggerCITestsResponse = struct {
    batch_id: ?[]const u8 = null,
    results: ?[]const std.json.Value = null,
    triggered_check_ids: ?[]const []const u8 = null,
    locations: ?[]const std.json.Value = null,
};

pub const SearchServiceLevelObjectiveData = struct {
    id: ?[]const u8 = null,
    attributes: ?SearchServiceLevelObjectiveAttributes = null,
    @"type": ?[]const u8 = null,
};

pub const GeomapWidgetDefinitionStyle = struct {
    palette: []const u8,
    palette_flip: bool,
};

pub const LogsAttributeRemapperType = struct {
};

pub const ApmStatsQueryRowType = struct {
};

pub const MonitorSearchCountItem = struct {
    name: ?[]const u8 = null,
    count: ?i64 = null,
};

pub const BarChartWidgetDefinitionType = struct {
};

pub const MonitorOptions = struct {
    evaluation_delay: ?i64 = null,
    enable_samples: ?bool = null,
    notify_by: ?[]const []const u8 = null,
    renotify_interval: ?i64 = null,
    synthetics_check_id: ?[]const u8 = null,
    timeout_h: ?i64 = null,
    no_data_timeframe: ?i64 = null,
    notify_audit: ?bool = null,
    on_missing_data: ?OnMissingDataOption = null,
    new_group_delay: ?i64 = null,
    threshold_windows: ?MonitorThresholdWindowOptions = null,
    include_tags: ?bool = null,
    renotify_statuses: ?[]const std.json.Value = null,
    min_failure_duration: ?i64 = null,
    device_ids: ?[]const std.json.Value = null,
    renotify_occurrences: ?i64 = null,
    group_retention_duration: ?[]const u8 = null,
    silenced: ?std.json.Value = null,
    aggregation: ?MonitorOptionsAggregation = null,
    escalation_message: ?[]const u8 = null,
    variables: ?[]const std.json.Value = null,
    locked: ?bool = null,
    groupby_simple_monitor: ?bool = null,
    notify_no_data: ?bool = null,
    min_location_failed: ?i64 = null,
    new_host_delay: ?i64 = null,
    require_full_window: ?bool = null,
    thresholds: ?MonitorThresholds = null,
    scheduling_options: ?MonitorOptionsSchedulingOptions = null,
    enable_logs_sample: ?bool = null,
    notification_preset_name: ?MonitorOptionsNotificationPresets = null,
};

pub const WidgetSummaryType = struct {
};

pub const UsageProfilingResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const CheckStatusWidgetDefinitionType = struct {
};

pub const GroupWidgetDefinitionType = struct {
};

pub const SyntheticsPrivateLocationMetadata = struct {
    restricted_roles: ?SyntheticsRestrictedRoles = null,
};

pub const SyntheticsTestDetailsSubType = struct {
};

pub const UsageCIVisibilityHour = struct {
    ci_visibility_test_committers: ?i64 = null,
    ci_visibility_pipeline_committers: ?i64 = null,
    ci_pipeline_indexed_spans: ?i64 = null,
    org_name: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    ci_test_indexed_spans: ?i64 = null,
    ci_visibility_itr_committers: ?i64 = null,
};

pub const FreeTextWidgetDefinition = struct {
    text: []const u8,
    text_align: ?WidgetTextAlign = null,
    color: ?[]const u8 = null,
    font_size: ?[]const u8 = null,
    @"type": FreeTextWidgetDefinitionType,
};

pub const MonitorFormulaAndFunctionDataQualityMonitorOptions = struct {
    crontab_override: ?[]const u8 = null,
    custom_where: ?[]const u8 = null,
    custom_sql: ?[]const u8 = null,
    group_by_columns: ?[]const []const u8 = null,
    model_type_override: ?MonitorFormulaAndFunctionDataQualityModelTypeOverride = null,
};

pub const LogsStatusRemapperType = struct {
};

pub const SLOHistoryResponse = struct {
    data: ?SLOHistoryResponseData = null,
    errors: ?[]const std.json.Value = null,
};

pub const NumberFormatUnitCanonical = struct {
    per_unit_name: ?[]const u8 = null,
    unit_name: ?[]const u8 = null,
    @"type": ?NumberFormatUnitScaleType = null,
};

pub const WebhooksIntegrationCustomVariable = struct {
    is_secret: bool,
    value: []const u8,
    name: []const u8,
};

pub const DistributionPointData = struct {
};

pub const GeomapWidgetDefinitionType = struct {
};

pub const SharedDashboardInvites = struct {
    data: SharedDashboardInvitesData,
    meta: ?SharedDashboardInvitesMeta = null,
};

pub const SLOBulkDeleteResponseData = struct {
    updated: ?[]const []const u8 = null,
    deleted: ?[]const []const u8 = null,
};

pub const UsageAttributionAggregatesBody = struct {
    value: ?f64 = null,
    agg_type: ?[]const u8 = null,
    field: ?[]const u8 = null,
};

pub const TopologyRequestType = struct {
};

pub const SLOBulkDeleteError = struct {
    timeframe: SLOErrorTimeframe,
    id: []const u8,
    message: []const u8,
};

pub const SharedDashboardInvitesDataObjectAttributes = struct {
    created_at: ?[]const u8 = null,
    has_session: ?bool = null,
    invitation_expiry: ?[]const u8 = null,
    session_expiry: ?[]const u8 = null,
    email: ?[]const u8 = null,
    share_token: ?[]const u8 = null,
};

pub const SLOTimeSliceCondition = struct {
    threshold: f64,
    comparator: SLOTimeSliceComparator,
    query: SLOTimeSliceQuery,
    query_interval_seconds: ?SLOTimeSliceInterval = null,
};

pub const WidgetMargin = struct {
};

pub const OrganizationSettingsSamlStrictMode = struct {
    enabled: ?bool = null,
};

pub const SyntheticsBrowserTestResultShort = struct {
    status: ?SyntheticsTestMonitorStatus = null,
    result: ?SyntheticsBrowserTestResultShortResult = null,
    probe_dc: ?[]const u8 = null,
    check_time: ?f64 = null,
    result_id: ?[]const u8 = null,
};

pub const MonitorThresholds = struct {
    ok: ?f64 = null,
    warning_recovery: ?f64 = null,
    critical: ?f64 = null,
    unknown: ?f64 = null,
    critical_recovery: ?f64 = null,
    warning: ?f64 = null,
};

pub const SLOListResponseMetadataPage = struct {
    total_count: ?i64 = null,
    total_filtered_count: ?i64 = null,
};

pub const AWSEventBridgeListResponse = struct {
    accounts: ?[]const std.json.Value = null,
    isInstalled: ?bool = null,
};

pub const DowntimeChild = struct {
    active: ?bool = null,
    monitor_id: ?i64 = null,
    mute_first_recovery_notification: ?bool = null,
    recurrence: ?DowntimeRecurrence = null,
    monitor_tags: ?[]const []const u8 = null,
    id: ?i64 = null,
    parent_id: ?i64 = null,
    end: ?i64 = null,
    start: ?i64 = null,
    scope: ?[]const []const u8 = null,
    canceled: ?i64 = null,
    disabled: ?bool = null,
    downtime_type: ?i64 = null,
    updater_id: ?i64 = null,
    timezone: ?[]const u8 = null,
    notify_end_types: ?NotifyEndTypes = null,
    notify_end_states: ?NotifyEndStates = null,
    creator_id: ?i64 = null,
    message: ?[]const u8 = null,
};

pub const ToplistWidgetScaling = struct {
};

pub const LogsRetentionSumUsage = struct {
    logs_live_indexed_logs_usage_sum: ?i64 = null,
    logs_rehydrated_indexed_logs_usage_sum: ?i64 = null,
    retention: ?[]const u8 = null,
    logs_indexed_logs_usage_sum: ?i64 = null,
};

pub const AlertValueWidgetDefinition = struct {
    precision: ?i64 = null,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    text_align: ?WidgetTextAlign = null,
    alert_id: []const u8,
    @"type": AlertValueWidgetDefinitionType,
    title: ?[]const u8 = null,
    unit: ?[]const u8 = null,
};

pub const FormulaAndFunctionMetricQueryDefinition = struct {
    data_source: FormulaAndFunctionMetricDataSource,
    aggregator: ?FormulaAndFunctionMetricAggregation = null,
    cross_org_uuids: ?CrossOrgUuids = null,
    semantic_mode: ?FormulaAndFunctionMetricSemanticMode = null,
    name: []const u8,
    query: []const u8,
};

pub const WidgetDisplayType = struct {
};

pub const AWSEventBridgeCreateStatus = struct {
};

pub const EventCreateRequest = struct {
    tags: ?[]const []const u8 = null,
    host: ?[]const u8 = null,
    priority: ?EventPriority = null,
    related_event_id: ?i64 = null,
    source_type_name: ?[]const u8 = null,
    alert_type: ?EventAlertType = null,
    date_happened: ?i64 = null,
    device_name: ?[]const u8 = null,
    aggregation_key: ?[]const u8 = null,
    text: []const u8,
    title: []const u8,
};

pub const MonitorRenotifyStatusType = struct {
};

pub const ServiceCheckStatus = struct {
};

pub const LogsExclusion = struct {
    name: []const u8,
    is_enabled: ?bool = null,
    filter: ?LogsExclusionFilter = null,
};

pub const PagerDutyServiceKey = struct {
    service_key: []const u8,
};

pub const UsageLogsByRetentionHour = struct {
    org_name: ?[]const u8 = null,
    live_indexed_events_count: ?i64 = null,
    indexed_events_count: ?i64 = null,
    retention: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    rehydrated_indexed_events_count: ?i64 = null,
};

pub const LogsExclusionFilter = struct {
    sample_rate: f64,
    query: ?[]const u8 = null,
};

pub const DashboardDeleteResponse = struct {
    deleted_dashboard_id: ?[]const u8 = null,
};

pub const SuccessfulSignalUpdateResponse = struct {
    status: ?[]const u8 = null,
};

pub const ScatterPlotWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    requests: ScatterPlotWidgetDefinitionRequests,
    color_by_groups: ?[]const []const u8 = null,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    xaxis: ?WidgetAxis = null,
    time: ?WidgetTime = null,
    yaxis: ?WidgetAxis = null,
    @"type": ScatterPlotWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const SyntheticsBasicAuthOauthClientType = struct {
};

pub const SharedDashboardInvitesDataObject = struct {
    attributes: SharedDashboardInvitesDataObjectAttributes,
    @"type": DashboardInviteType,
};

pub const SyntheticsTestCallType = struct {
};

pub const GCPMonitoredResourceConfig = struct {
    filters: ?[]const []const u8 = null,
    @"type": ?GCPMonitoredResourceConfigType = null,
};

pub const SyntheticsBasicAuthDigest = struct {
    password: []const u8,
    username: []const u8,
    @"type": SyntheticsBasicAuthDigestType,
};

pub const SyntheticsCIBatchMetadataGit = struct {
    commitSha: ?[]const u8 = null,
    branch: ?[]const u8 = null,
};

pub const AWSEventBridgeSource = struct {
    name: ?[]const u8 = null,
    region: ?[]const u8 = null,
};

pub const UsageAuditLogsHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    lines_indexed: ?i64 = null,
    public_id: ?[]const u8 = null,
};

pub const SyntheticsGlobalVariableParseTestOptionsType = struct {
};

pub const Organization = struct {
    settings: ?OrganizationSettings = null,
    subscription: ?OrganizationSubscription = null,
    description: ?[]const u8 = null,
    billing: ?OrganizationBilling = null,
    name: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    created: ?[]const u8 = null,
    trial: ?bool = null,
};

pub const SLOTimeSliceQuery = struct {
    formulas: []const std.json.Value,
    queries: []const std.json.Value,
};

pub const SLOWidgetDefinitionType = struct {
};

pub const DashboardListListResponse = struct {
    dashboard_lists: ?[]const std.json.Value = null,
};

pub const FormulaAndFunctionEventsDataSource = struct {
};

pub const SLOFormula = struct {
    formula: []const u8,
};

pub const SLOState = struct {
};

pub const AWSLogsListServicesResponse = struct {
    id: ?[]const u8 = null,
    label: ?[]const u8 = null,
};

pub const SyntheticsGlobalVariableAttributes = struct {
    restricted_roles: ?SyntheticsRestrictedRoles = null,
};

pub const ListStreamQuery = struct {
    data_source: ListStreamSource,
    compute: ?[]const std.json.Value = null,
    group_by: ?[]const std.json.Value = null,
    event_size: ?WidgetEventSize = null,
    storage: ?[]const u8 = null,
    clustering_pattern_field_path: ?[]const u8 = null,
    query_string: []const u8,
    indexes: ?[]const []const u8 = null,
    sort: ?WidgetFieldSort = null,
};

pub const ScatterPlotRequest = struct {
    aggregator: ?ScatterplotWidgetAggregator = null,
    rum_query: ?LogQueryDefinition = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?LogQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
    q: ?[]const u8 = null,
};

pub const SyntheticsBasicAuthDigestType = struct {
};

pub const UsageTimeseriesResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const SyntheticsGlobalVariableParseTestOptions = struct {
    localVariableName: ?[]const u8 = null,
    field: ?[]const u8 = null,
    parser: ?SyntheticsVariableParser = null,
    @"type": SyntheticsGlobalVariableParseTestOptionsType,
};

pub const IntakePayloadAccepted = struct {
    status: ?[]const u8 = null,
};

pub const LogQueryDefinition = struct {
    group_by: ?[]const std.json.Value = null,
    multi_compute: ?[]const std.json.Value = null,
    search: ?LogQueryDefinitionSearch = null,
    index: ?[]const u8 = null,
    compute: ?LogsQueryCompute = null,
};

pub const OrganizationSubscription = struct {
    @"type": ?[]const u8 = null,
};

pub const ResourceProviderConfig = struct {
    metrics_enabled: ?bool = null,
    namespace: ?[]const u8 = null,
};

pub const PowerpackTemplateVariableContents = struct {
    values: []const []const u8,
    name: []const u8,
    prefix: ?[]const u8 = null,
};

pub const SyntheticsAPITestResultFullCheck = struct {
    config: SyntheticsTestConfig,
};

pub const SyntheticsMobileStepParams = struct {
    direction: ?SyntheticsMobileStepParamsDirection = null,
    maxScrolls: ?i64 = null,
    positions: ?SyntheticsMobileStepParamsPositions = null,
    variable: ?SyntheticsMobileStepParamsVariable = null,
    value: ?SyntheticsMobileStepParamsValue = null,
    subtestPublicId: ?[]const u8 = null,
    element: ?SyntheticsMobileStepParamsElement = null,
    y: ?f64 = null,
    x: ?f64 = null,
    enabled: ?bool = null,
    delay: ?i64 = null,
    check: ?SyntheticsCheckType = null,
    withEnter: ?bool = null,
};

pub const MonitorGroupSearchResponse = struct {
    groups: ?[]const std.json.Value = null,
    metadata: ?MonitorSearchResponseMetadata = null,
    counts: ?MonitorGroupSearchResponseCounts = null,
};

pub const TopologyMapWidgetDefinitionType = struct {
};

pub const SyntheticsBatchStatus = struct {
};

pub const WebhooksIntegrationCustomVariableResponse = struct {
    is_secret: bool,
    value: ?[]const u8 = null,
    name: []const u8,
};

pub const Log = struct {
    id: ?[]const u8 = null,
    content: ?LogContent = null,
};

pub const UsageDBMResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const SLOListWidgetDefinition = struct {
    title_align: ?WidgetTextAlign = null,
    requests: []const std.json.Value,
    @"type": SLOListWidgetDefinitionType,
    title_size: ?[]const u8 = null,
    title: ?[]const u8 = null,
};

pub const UsageIngestedSpansHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    ingested_events_bytes: ?i64 = null,
};

pub const WidgetSortOrderBy = struct {
};

pub const IdpFormData = struct {
    idp_file: []const u8,
};

pub const SearchSLOThreshold = struct {
    timeframe: SearchSLOTimeframe,
    target_display: ?[]const u8 = null,
    target: f64,
    warning: ?f64 = null,
    warning_display: ?[]const u8 = null,
};

pub const UsageProfilingHour = struct {
    org_name: ?[]const u8 = null,
    aas_count: ?i64 = null,
    avg_container_agent_count: ?i64 = null,
    hour: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    host_count: ?i64 = null,
};

pub const UsageTimeseriesHour = struct {
    num_custom_output_timeseries: ?i64 = null,
    hour: ?[]const u8 = null,
    num_custom_timeseries: ?i64 = null,
    org_name: ?[]const u8 = null,
    public_id: ?[]const u8 = null,
    num_custom_input_timeseries: ?i64 = null,
};

pub const Downtime = struct {
    active: ?bool = null,
    monitor_id: ?i64 = null,
    mute_first_recovery_notification: ?bool = null,
    recurrence: ?DowntimeRecurrence = null,
    monitor_tags: ?[]const []const u8 = null,
    active_child: ?DowntimeChild = null,
    id: ?i64 = null,
    end: ?i64 = null,
    parent_id: ?i64 = null,
    scope: ?[]const []const u8 = null,
    canceled: ?i64 = null,
    disabled: ?bool = null,
    downtime_type: ?i64 = null,
    start: ?i64 = null,
    updater_id: ?i64 = null,
    timezone: ?[]const u8 = null,
    notify_end_types: ?NotifyEndTypes = null,
    notify_end_states: ?NotifyEndStates = null,
    creator_id: ?i64 = null,
    message: ?[]const u8 = null,
};

pub const IPPrefixesSynthetics = struct {
    prefixes_ipv6: ?[]const []const u8 = null,
    prefixes_ipv6_by_location: ?std.json.Value = null,
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv4_by_location: ?std.json.Value = null,
};

pub const SyntheticsConfigVariable = struct {
    example: ?[]const u8 = null,
    pattern: ?[]const u8 = null,
    id: ?[]const u8 = null,
    name: []const u8,
    secure: ?bool = null,
    @"type": SyntheticsConfigVariableType,
};

pub const SyntheticsConfigVariableType = struct {
};

pub const BarChartWidgetStacked = struct {
    legend: ?BarChartWidgetLegend = null,
    @"type": BarChartWidgetStackedType,
};

pub const ChangeWidgetRequest = struct {
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?LogQueryDefinition = null,
    formulas: ?[]const std.json.Value = null,
    order_by: ?WidgetOrderBy = null,
    order_dir: ?WidgetSort = null,
    q: ?[]const u8 = null,
    queries: ?[]const std.json.Value = null,
    change_type: ?WidgetChangeType = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
    increase_good: ?bool = null,
    compare_to: ?WidgetCompareTo = null,
    show_present: ?bool = null,
};

pub const SlackIntegrationChannelDisplay = struct {
    notified: ?bool = null,
    tags: ?bool = null,
    message: ?bool = null,
    snapshot: ?bool = null,
    mute_buttons: ?bool = null,
};

pub const GeomapWidgetRequest = struct {
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    formulas: ?[]const std.json.Value = null,
    style: ?GeomapWidgetRequestStyle = null,
    q: ?[]const u8 = null,
    text_formats: ?[]const std.json.Value = null,
    queries: ?[]const std.json.Value = null,
    columns: ?[]const std.json.Value = null,
    sort: ?WidgetSortBy = null,
    conditional_formats: ?[]const std.json.Value = null,
    log_query: ?LogQueryDefinition = null,
    query: ?ListStreamQuery = null,
};

pub const MonitorFormulaAndFunctionDataQualityModelTypeOverride = struct {
};

pub const IPPrefixesGlobal = struct {
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv6: ?[]const []const u8 = null,
};

pub const AWSTagFilterCreateRequest = struct {
    tag_filter_str: ?[]const u8 = null,
    account_id: ?[]const u8 = null,
    namespace: ?AWSNamespace = null,
};

pub const Point = struct {
};

pub const UsageMetricCategory = struct {
};

pub const IPPrefixesAgents = struct {
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv6: ?[]const []const u8 = null,
};

pub const UsageAttributionTagNames = struct {
};

pub const UsageIndexedSpansResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const UsageCWSResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const UsageReportsType = struct {
};

pub const NotebookResourceType = struct {
};

pub const SLOCorrectionUpdateRequest = struct {
    data: ?SLOCorrectionUpdateData = null,
};

pub const SyntheticsAPIWaitStepSubtype = struct {
};

pub const TimeseriesWidgetDefinitionType = struct {
};

pub const SyntheticsBrowserTestResultFull = struct {
    result: ?SyntheticsBrowserTestResultData = null,
    check_version: ?i64 = null,
    status: ?SyntheticsTestMonitorStatus = null,
    check: ?SyntheticsBrowserTestResultFullCheck = null,
    result_id: ?[]const u8 = null,
    probe_dc: ?[]const u8 = null,
    check_time: ?f64 = null,
};

pub const FormulaAndFunctionEventQueryDefinitionCompute = struct {
    interval: ?i64 = null,
    aggregation: FormulaAndFunctionEventAggregation,
    metric: ?[]const u8 = null,
};

pub const SyntheticsLocations = struct {
    locations: ?[]const std.json.Value = null,
};

pub const SyntheticsMobileTestType = struct {
};

pub const LogsSort = struct {
};

pub const DashboardBulkActionDataList = struct {
};

pub const SLODataSourceQueryDefinition = struct {
};

pub const UsageSpecifiedCustomReportsMeta = struct {
    page: ?UsageSpecifiedCustomReportsPage = null,
};

pub const MetricSearchResponse = struct {
    results: ?MetricSearchResponseResults = null,
};

pub const NotebookCellUpdateRequest = struct {
    id: []const u8,
    attributes: NotebookCellUpdateRequestAttributes,
    @"type": NotebookCellResourceType,
};

pub const SyntheticsDevice = struct {
    width: i64,
    height: i64,
    id: SyntheticsDeviceID,
    name: []const u8,
    isMobile: ?bool = null,
};

pub const SyntheticsBasicAuthNTLM = struct {
    password: ?[]const u8 = null,
    username: ?[]const u8 = null,
    @"type": SyntheticsBasicAuthNTLMType,
    workstation: ?[]const u8 = null,
    domain: ?[]const u8 = null,
};

pub const NotebookResponseDataAttributes = struct {
    author: ?NotebookAuthor = null,
    modified: ?[]const u8 = null,
    cells: []const std.json.Value,
    status: ?NotebookStatus = null,
    time: NotebookGlobalTime,
    metadata: ?NotebookMetadata = null,
    name: []const u8,
    created: ?[]const u8 = null,
};

pub const WidgetAggregator = struct {
};

pub const LogsStringBuilderProcessor = struct {
    is_replace_missing: ?bool = null,
    template: []const u8,
    name: ?[]const u8 = null,
    @"type": LogsStringBuilderProcessorType,
    target: []const u8,
    is_enabled: ?bool = null,
};

pub const ToplistWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    requests: []const std.json.Value,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    time: ?WidgetTime = null,
    style: ?ToplistWidgetStyle = null,
    @"type": ToplistWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const HostMetaInstallMethod = struct {
    installer_version: ?[]const u8 = null,
    tool: ?[]const u8 = null,
    tool_version: ?[]const u8 = null,
};

pub const SyntheticsTestExecutionRule = struct {
};

pub const LogsUserAgentParserType = struct {
};

pub const UsageCustomReportsResponse = struct {
    data: ?[]const std.json.Value = null,
    meta: ?UsageCustomReportsMeta = null,
};

pub const ServiceSummaryWidgetDefinition = struct {
    title: ?[]const u8 = null,
    show_breakdown: ?bool = null,
    service: []const u8,
    title_align: ?WidgetTextAlign = null,
    show_hits: ?bool = null,
    show_latency: ?bool = null,
    time: ?WidgetTime = null,
    show_distribution: ?bool = null,
    env: []const u8,
    show_resource_list: ?bool = null,
    title_size: ?[]const u8 = null,
    display_format: ?WidgetServiceSummaryDisplayFormat = null,
    size_format: ?WidgetSizeFormat = null,
    @"type": ServiceSummaryWidgetDefinitionType,
    span_name: []const u8,
    show_errors: ?bool = null,
};

pub const SharedDashboardInvitesData = struct {
};

pub const HourlyUsageAttributionMetadata = struct {
    pagination: ?HourlyUsageAttributionPagination = null,
};

pub const ToplistWidgetLegend = struct {
};

pub const SyntheticsMobileStepParamsVariable = struct {
    example: []const u8,
    name: []const u8,
};

pub const UsageSyntheticsResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const Series = struct {
    tags: ?[]const []const u8 = null,
    host: ?[]const u8 = null,
    interval: ?i64 = null,
    @"type": ?[]const u8 = null,
    points: []const std.json.Value,
    metric: []const u8,
};

pub const ToplistWidgetStyle = struct {
    palette: ?[]const u8 = null,
    display: ?ToplistWidgetDisplay = null,
    scaling: ?ToplistWidgetScaling = null,
};

pub const LogsSpanRemapper = struct {
    name: ?[]const u8 = null,
    @"type": LogsSpanRemapperType,
    is_enabled: ?bool = null,
    sources: ?[]const []const u8 = null,
};

pub const SyntheticsMobileStepParamsValueNumber = struct {
};

pub const FormulaAndFunctionCloudCostDataSource = struct {
};

pub const MonitorSearchCount = struct {
};

pub const SLOTimeSliceInterval = struct {
};

pub const WidgetVizType = struct {
};

pub const LogsSchemaData = struct {
    class_name: []const u8,
    class_uid: i64,
    schema_type: []const u8,
    version: []const u8,
    profiles: ?[]const []const u8 = null,
};

pub const UsageBillableSummaryBody = struct {
    elapsed_usage_hours: ?i64 = null,
    account_billable_usage: ?i64 = null,
    account_on_demand_usage: ?i64 = null,
    last_billable_usage_hour: ?[]const u8 = null,
    percentage_in_account: ?f64 = null,
    account_committed_usage: ?i64 = null,
    usage_unit: ?[]const u8 = null,
    org_billable_usage: ?i64 = null,
    first_billable_usage_hour: ?[]const u8 = null,
};

pub const BarChartWidgetLegend = struct {
};

pub const Version = struct {
};

pub const SyntheticsMobileTest = struct {
    steps: ?[]const std.json.Value = null,
    options: SyntheticsMobileTestOptions,
    monitor_id: ?i64 = null,
    tags: ?[]const []const u8 = null,
    public_id: ?[]const u8 = null,
    status: ?SyntheticsTestPauseStatus = null,
    device_ids: ?[]const std.json.Value = null,
    name: []const u8,
    @"type": SyntheticsMobileTestType,
    config: SyntheticsMobileTestConfig,
    message: []const u8,
};

pub const FormulaAndFunctionSLOQueryType = struct {
};

pub const UsageSummaryDateOrg = struct {
    on_call_seat_hwm: ?i64 = null,
    cloud_cost_management_gcp_host_count_avg: ?i64 = null,
    synthetics_browser_check_calls_count_sum: ?i64 = null,
    aws_lambda_invocations_sum: ?i64 = null,
    opentelemetry_host_top99p: ?i64 = null,
    cloud_siem_events_sum: ?i64 = null,
    incident_management_seats_hwm: ?i64 = null,
    mobile_rum_session_count_android_sum: ?i64 = null,
    flex_logs_starter_avg: ?i64 = null,
    event_management_correlation_correlated_events_sum: ?i64 = null,
    sca_fargate_count_avg: ?i64 = null,
    browser_rum_lite_session_count_sum: ?i64 = null,
    custom_historical_ts_avg: ?i64 = null,
    serverless_apps_excl_fargate_azure_function_app_instances_avg: ?i64 = null,
    error_tracking_rum_error_events_sum: ?i64 = null,
    azure_app_service_top99p: ?i64 = null,
    error_tracking_events_sum: ?i64 = null,
    sds_events_scanned_bytes_sum: ?i64 = null,
    flex_logs_starter_storage_retention_adjustment_avg: ?i64 = null,
    code_security_host_top99p: ?i64 = null,
    product_analytics_sum: ?i64 = null,
    ci_pipeline_indexed_spans_sum: ?i64 = null,
    account_public_id: ?[]const u8 = null,
    csm_host_enterprise_gcp_host_count_top99p: ?i64 = null,
    rum_indexed_sessions_sum: ?i64 = null,
    sca_fargate_count_hwm: ?i64 = null,
    container_hwm: ?i64 = null,
    rum_mobile_legacy_session_count_roku_sum: ?i64 = null,
    rum_mobile_lite_session_count_android_sum: ?i64 = null,
    serverless_apps_apm_avg: ?i64 = null,
    rum_session_count_sum: ?i64 = null,
    eph_infra_host_opentelemetry_apm_sum: ?i64 = null,
    cspm_host_top99p: ?i64 = null,
    serverless_apps_azure_count_avg: ?i64 = null,
    flex_logs_compute_medium_avg: ?i64 = null,
    aws_lambda_func_count: ?i64 = null,
    ccm_spend_monitored_pro_last: ?i64 = null,
    serverless_apps_apm_apm_gcp_cloudfunction_instances_avg: ?i64 = null,
    serverless_apps_apm_apm_gcp_cloudrun_instances_avg: ?i64 = null,
    apm_enterprise_standalone_hosts_top99p: ?i64 = null,
    cloud_cost_management_aws_host_count_avg: ?i64 = null,
    rum_mobile_legacy_session_count_ios_sum: ?i64 = null,
    serverless_apps_apm_apm_fargate_ecs_tasks_avg: ?i64 = null,
    eph_infra_host_alibaba_sum: ?i64 = null,
    eph_infra_host_heroku_sum: ?i64 = null,
    rum_browser_lite_session_count_sum: ?i64 = null,
    profiling_aas_count_top99p: ?i64 = null,
    cspm_aws_host_top99p: ?i64 = null,
    name: ?[]const u8 = null,
    cloud_cost_management_azure_host_count_avg: ?i64 = null,
    rum_lite_session_count_sum: ?i64 = null,
    cws_container_count_avg: ?i64 = null,
    ci_visibility_pipeline_committers_hwm: ?i64 = null,
    appsec_fargate_count_avg: ?i64 = null,
    fargate_tasks_count_avg: ?i64 = null,
    heroku_host_top99p: ?i64 = null,
    rum_mobile_lite_session_count_roku_sum: ?i64 = null,
    csm_host_enterprise_aws_host_count_top99p: ?i64 = null,
    mobile_rum_lite_session_count_sum: ?i64 = null,
    mobile_rum_session_count_ios_sum: ?i64 = null,
    siem_analyzed_logs_add_on_count_sum: ?i64 = null,
    indexed_events_count_sum: ?i64 = null,
    flex_logs_compute_xsmall_avg: ?i64 = null,
    csm_container_enterprise_cws_count_sum: ?i64 = null,
    serverless_apps_ecs_avg: ?i64 = null,
    avg_profiled_fargate_tasks: ?i64 = null,
    csm_host_enterprise_compliance_host_count_top99p: ?i64 = null,
    flex_logs_compute_xlarge_avg: ?i64 = null,
    gcp_host_top99p: ?i64 = null,
    rum_mobile_replay_session_count_android_sum: ?i64 = null,
    rum_browser_and_mobile_session_count: ?i64 = null,
    dbm_queries_avg_sum: ?i64 = null,
    rum_mobile_lite_session_count_kotlinmultiplatform_sum: ?i64 = null,
    rum_mobile_legacy_session_count_flutter_sum: ?i64 = null,
    agent_host_top99p: ?i64 = null,
    llm_observability_min_spend_sum: ?i64 = null,
    audit_trail_enabled_hwm: ?i64 = null,
    eph_infra_host_azure_sum: ?i64 = null,
    rum_mobile_replay_session_count_ios_sum: ?i64 = null,
    synthetics_parallel_testing_max_slots_hwm: ?i64 = null,
    incident_management_monthly_active_users_hwm: ?i64 = null,
    serverless_apps_google_cloud_functions_instances_avg: ?i64 = null,
    apm_host_top99p: ?i64 = null,
    account_name: ?[]const u8 = null,
    audit_logs_lines_indexed_sum: ?i64 = null,
    iot_device_agg_sum: ?i64 = null,
    eph_infra_host_proxmox_sum: ?i64 = null,
    cws_fargate_task_avg: ?i64 = null,
    online_archive_events_count_sum: ?i64 = null,
    asm_serverless_sum: ?i64 = null,
    serverless_apps_excl_fargate_azure_container_app_instances_avg: ?i64 = null,
    opentelemetry_apm_host_top99p: ?i64 = null,
    eph_infra_host_opentelemetry_sum: ?i64 = null,
    observability_pipelines_bytes_processed_sum: ?i64 = null,
    rum_mobile_replay_session_count_kotlinmultiplatform_sum: ?i64 = null,
    serverless_apps_google_count_avg: ?i64 = null,
    oci_host_top99p: ?i64 = null,
    browser_rum_units_sum: ?i64 = null,
    rum_replay_session_count_sum: ?i64 = null,
    eph_infra_host_only_aas_sum: ?i64 = null,
    mobile_rum_units_sum: ?i64 = null,
    iot_device_top99p_sum: ?i64 = null,
    mobile_rum_session_count_sum: ?i64 = null,
    sds_apm_scanned_bytes_sum: ?i64 = null,
    sds_rum_scanned_bytes_sum: ?i64 = null,
    serverless_apps_excl_fargate_azure_web_app_instances_avg: ?i64 = null,
    universal_service_monitoring_host_top99p: ?i64 = null,
    aws_host_top99p: ?i64 = null,
    cspm_container_hwm: ?i64 = null,
    error_tracking_apm_error_events_sum: ?i64 = null,
    serverless_apps_apm_apm_azure_containerapp_instances_avg: ?i64 = null,
    csm_host_enterprise_cws_host_count_top99p: ?i64 = null,
    csm_host_enterprise_aas_host_count_top99p: ?i64 = null,
    proxmox_host_sum: ?i64 = null,
    ci_visibility_test_committers_hwm: ?i64 = null,
    serverless_apps_apm_apm_azure_azurefunction_instances_avg: ?i64 = null,
    fargate_container_profiler_profiling_fargate_avg: ?i64 = null,
    serverless_apps_total_count_avg: ?i64 = null,
    serverless_apps_azure_web_app_instances_avg: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_azure_azurefunction_instances_avg: ?i64 = null,
    fargate_tasks_count_hwm: ?i64 = null,
    workflow_executions_usage_sum: ?i64 = null,
    rum_mobile_lite_session_count_ios_sum: ?i64 = null,
    network_device_wireless_top99p: ?i64 = null,
    custom_live_ts_avg: ?i64 = null,
    apm_devsecops_host_top99p: ?i64 = null,
    twol_ingested_events_bytes_sum: ?i64 = null,
    dbm_host_top99p_sum: ?i64 = null,
    error_tracking_error_events_sum: ?i64 = null,
    container_avg: ?i64 = null,
    rum_units_sum: ?i64 = null,
    serverless_apps_apm_apm_azure_appservice_instances_avg: ?i64 = null,
    serverless_apps_google_cloud_run_instances_avg: ?i64 = null,
    event_management_correlation_correlated_related_events_sum: ?i64 = null,
    ndm_netflow_events_sum: ?i64 = null,
    synthetics_check_calls_count_sum: ?i64 = null,
    code_analysis_sa_committers_hwm: ?i64 = null,
    ingested_events_bytes_sum: ?i64 = null,
    published_app_hwm: ?i64 = null,
    rum_browser_legacy_session_count_sum: ?i64 = null,
    browser_rum_replay_session_count_sum: ?i64 = null,
    cloud_cost_management_host_count_avg: ?i64 = null,
    serverless_apps_excl_fargate_google_cloud_functions_instances_avg: ?i64 = null,
    eph_infra_host_agent_sum: ?i64 = null,
    container_excl_agent_avg: ?i64 = null,
    cspm_container_avg: ?i64 = null,
    profiling_host_top99p: ?i64 = null,
    rum_mobile_lite_session_count_reactnative_sum: ?i64 = null,
    ci_test_indexed_spans_sum: ?i64 = null,
    npm_host_top99p: ?i64 = null,
    sds_logs_scanned_bytes_sum: ?i64 = null,
    rum_ingested_sessions_sum: ?i64 = null,
    cws_host_top99p: ?i64 = null,
    mobile_rum_session_count_flutter_sum: ?i64 = null,
    code_analysis_sca_committers_hwm: ?i64 = null,
    rum_mobile_legacy_session_count_android_sum: ?i64 = null,
    flex_logs_starter_storage_index_avg: ?i64 = null,
    infra_host_top99p: ?i64 = null,
    trace_search_indexed_events_count_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_gcp_cloudrun_instances_avg: ?i64 = null,
    cspm_azure_host_top99p: ?i64 = null,
    mobile_rum_session_count_roku_sum: ?i64 = null,
    cspm_aas_host_top99p: ?i64 = null,
    apm_fargate_count_avg: ?i64 = null,
    event_management_correlation_sum: ?i64 = null,
    region: ?[]const u8 = null,
    rum_mobile_replay_session_count_reactnative_sum: ?i64 = null,
    ci_visibility_itr_committers_hwm: ?i64 = null,
    sds_total_scanned_bytes_sum: ?i64 = null,
    oci_host_sum: ?i64 = null,
    apm_pro_standalone_hosts_top99p: ?i64 = null,
    csm_host_enterprise_total_host_count_top99p: ?i64 = null,
    vsphere_host_top99p: ?i64 = null,
    rum_session_replay_add_on_sum: ?i64 = null,
    rum_total_session_count_sum: ?i64 = null,
    proxmox_host_top99p: ?i64 = null,
    netflow_indexed_events_count_sum: ?i64 = null,
    serverless_apps_eks_avg: ?i64 = null,
    flex_stored_logs_avg: ?i64 = null,
    eph_infra_host_ent_sum: ?i64 = null,
    eph_infra_host_only_vsphere_sum: ?i64 = null,
    mobile_rum_session_count_reactnative_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_avg: ?i64 = null,
    synthetics_mobile_test_runs_sum: ?i64 = null,
    csm_container_enterprise_compliance_count_sum: ?i64 = null,
    rum_browser_replay_session_count_sum: ?i64 = null,
    data_jobs_monitoring_host_hr_sum: ?i64 = null,
    rum_mobile_legacy_session_count_reactnative_sum: ?i64 = null,
    eph_infra_host_gcp_sum: ?i64 = null,
    serverless_apps_azure_function_app_instances_avg: ?i64 = null,
    billable_ingested_bytes_sum: ?i64 = null,
    serverless_apps_excl_fargate_avg: ?i64 = null,
    csm_container_enterprise_total_count_sum: ?i64 = null,
    vuln_management_host_count_top99p: ?i64 = null,
    flex_logs_compute_large_avg: ?i64 = null,
    serverless_apps_azure_container_app_instances_avg: ?i64 = null,
    id: ?[]const u8 = null,
    rum_mobile_lite_session_count_flutter_sum: ?i64 = null,
    eph_infra_host_pro_sum: ?i64 = null,
    forwarding_events_bytes_sum: ?i64 = null,
    eph_infra_host_aws_sum: ?i64 = null,
    public_id: ?[]const u8 = null,
    serverless_apps_excl_fargate_google_cloud_run_instances_avg: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_gcp_cloudfunction_instances_avg: ?i64 = null,
    cloud_cost_management_oci_host_count_avg: ?i64 = null,
    csm_host_enterprise_azure_host_count_top99p: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_azure_containerapp_instances_avg: ?i64 = null,
    cspm_gcp_host_top99p: ?i64 = null,
    flex_logs_compute_small_avg: ?i64 = null,
    bits_ai_investigations_sum: ?i64 = null,
    llm_observability_sum: ?i64 = null,
    rum_mobile_lite_session_count_unity_sum: ?i64 = null,
    serverless_apps_apm_excl_fargate_apm_azure_appservice_instances_avg: ?i64 = null,
    custom_ts_avg: ?i64 = null,
    apm_azure_app_service_host_top99p: ?i64 = null,
    eph_infra_host_proplus_sum: ?i64 = null,
    ccm_spend_monitored_ent_last: ?i64 = null,
    fargate_container_profiler_profiling_fargate_eks_avg: ?i64 = null,
};

pub const SyntheticsMobileTestInitialApplicationArguments = struct {
};

pub const SyntheticsAssertionXPathOperator = struct {
};

pub const NotebookGraphSize = struct {
};

pub const SyntheticsBrowserTestResultShortResult = struct {
    device: ?SyntheticsDevice = null,
    errorCount: ?i64 = null,
    duration: ?f64 = null,
    stepCountCompleted: ?i64 = null,
    stepCountTotal: ?i64 = null,
};

pub const SyntheticsGetAPITestLatestResultsResponse = struct {
    last_timestamp_fetched: ?i64 = null,
    results: ?[]const std.json.Value = null,
};

pub const SyntheticsTiming = struct {
    dns: ?f64 = null,
    ssl: ?f64 = null,
    firstByte: ?f64 = null,
    total: ?f64 = null,
    tcp: ?f64 = null,
    handshake: ?f64 = null,
    download: ?f64 = null,
    redirect: ?f64 = null,
    wait: ?f64 = null,
};

pub const ContentEncoding = struct {
};

pub const UsageIncidentManagementResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const LogsPipelineList = struct {
};

pub const LogsUserAgentParser = struct {
    is_enabled: ?bool = null,
    sources: []const []const u8,
    is_encoded: ?bool = null,
    target: []const u8,
    @"type": LogsUserAgentParserType,
    name: ?[]const u8 = null,
};

pub const ServiceMapWidgetDefinitionType = struct {
};

pub const ServiceLevelObjective = struct {
    created_at: ?i64 = null,
    warning_threshold: ?f64 = null,
    timeframe: ?SLOTimeframe = null,
    monitor_tags: ?[]const []const u8 = null,
    creator: ?Creator = null,
    id: ?[]const u8 = null,
    modified_at: ?i64 = null,
    target_threshold: ?f64 = null,
    groups: ?[]const []const u8 = null,
    tags: ?[]const []const u8 = null,
    thresholds: []const std.json.Value,
    description: ?[]const u8 = null,
    monitor_ids: ?[]const i64 = null,
    name: []const u8,
    query: ?ServiceLevelObjectiveQuery = null,
    sli_specification: ?SLOSliSpec = null,
    @"type": SLOType,
};

pub const SyntheticsListTestsResponse = struct {
    tests: ?[]const std.json.Value = null,
};

pub const HourlyUsageAttributionBody = struct {
    hour: ?[]const u8 = null,
    tag_config_source: ?[]const u8 = null,
    tags: ?UsageAttributionTagNames = null,
    region: ?[]const u8 = null,
    org_name: ?[]const u8 = null,
    usage_type: ?HourlyUsageAttributionUsageType = null,
    total_usage_sum: ?f64 = null,
    public_id: ?[]const u8 = null,
    updated_at: ?[]const u8 = null,
};

pub const MonitorFormulaAndFunctionDataQualityQueryDefinition = struct {
    data_source: MonitorFormulaAndFunctionDataQualityDataSource,
    scope: ?[]const u8 = null,
    group_by: ?[]const []const u8 = null,
    monitor_options: ?MonitorFormulaAndFunctionDataQualityMonitorOptions = null,
    schema_version: ?[]const u8 = null,
    measure: MonitorFormulaAndFunctionDataQualityMeasure,
    name: []const u8,
    filter: []const u8,
};

pub const ProcessQueryDefinition = struct {
    limit: ?i64 = null,
    filter_by: ?[]const []const u8 = null,
    search_by: ?[]const u8 = null,
    metric: []const u8,
};

pub const SunburstWidgetDefinition = struct {
    legend: ?SunburstWidgetLegend = null,
    custom_links: ?[]const std.json.Value = null,
    requests: []const std.json.Value,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    time: ?WidgetTime = null,
    @"type": SunburstWidgetDefinitionType,
    hide_total: ?bool = null,
    title: ?[]const u8 = null,
};

pub const SyntheticsAPITestResultShort = struct {
    status: ?SyntheticsTestMonitorStatus = null,
    result: ?SyntheticsAPITestResultShortResult = null,
    probe_dc: ?[]const u8 = null,
    check_time: ?f64 = null,
    result_id: ?[]const u8 = null,
};

pub const UsageNetworkHostsResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const UsageBillableSummaryKeys = struct {
    logs_forwarding_sum: ?UsageBillableSummaryBody = null,
    logs_indexed_180day_sum: ?UsageBillableSummaryBody = null,
    cloud_cost_management_sum: ?UsageBillableSummaryBody = null,
    logs_indexed_1day_sum: ?UsageBillableSummaryBody = null,
    serverless_apm_sum: ?UsageBillableSummaryBody = null,
    npm_host_sum: ?UsageBillableSummaryBody = null,
    prof_host_top99p: ?UsageBillableSummaryBody = null,
    logs_ingested_sum: ?UsageBillableSummaryBody = null,
    siem_sum: ?UsageBillableSummaryBody = null,
    cloud_cost_management_average: ?UsageBillableSummaryBody = null,
    logs_indexed_3day_sum: ?UsageBillableSummaryBody = null,
    apm_profiler_host_top99p: ?UsageBillableSummaryBody = null,
    serverless_infra_average: ?UsageBillableSummaryBody = null,
    cws_container_sum: ?UsageBillableSummaryBody = null,
    network_device_top99p: ?UsageBillableSummaryBody = null,
    logs_indexed_360day_sum: ?UsageBillableSummaryBody = null,
    prof_host_sum: ?UsageBillableSummaryBody = null,
    logs_indexed_45day_sum: ?UsageBillableSummaryBody = null,
    iot_sum: ?UsageBillableSummaryBody = null,
    apm_profiler_host_sum: ?UsageBillableSummaryBody = null,
    application_security_fargate_average: ?UsageBillableSummaryBody = null,
    ci_testing_sum: ?UsageBillableSummaryBody = null,
    fargate_container_average: ?UsageBillableSummaryBody = null,
    dbm_host_top99p: ?UsageBillableSummaryBody = null,
    logs_indexed_7day_sum: ?UsageBillableSummaryBody = null,
    synthetics_app_testing_maximum: ?UsageBillableSummaryBody = null,
    fargate_container_apm_and_profiler_sum: ?UsageBillableSummaryBody = null,
    rum_lite_sum: ?UsageBillableSummaryBody = null,
    synthetics_browser_checks_sum: ?UsageBillableSummaryBody = null,
    logs_indexed_60day_sum: ?UsageBillableSummaryBody = null,
    dbm_normalized_queries_average: ?UsageBillableSummaryBody = null,
    ci_pipeline_sum: ?UsageBillableSummaryBody = null,
    ingested_spans_sum: ?UsageBillableSummaryBody = null,
    cspm_host_sum: ?UsageBillableSummaryBody = null,
    application_security_host_sum: ?UsageBillableSummaryBody = null,
    infra_container_sum: ?UsageBillableSummaryBody = null,
    logs_indexed_custom_retention_sum: ?UsageBillableSummaryBody = null,
    dbm_normalized_queries_sum: ?UsageBillableSummaryBody = null,
    network_device_sum: ?UsageBillableSummaryBody = null,
    ci_pipeline_indexed_spans_sum: ?UsageBillableSummaryBody = null,
    timeseries_average: ?UsageBillableSummaryBody = null,
    incident_management_sum: ?UsageBillableSummaryBody = null,
    infra_and_apm_host_top99p: ?UsageBillableSummaryBody = null,
    serverless_invocation_sum: ?UsageBillableSummaryBody = null,
    ci_testing_maximum: ?UsageBillableSummaryBody = null,
    cspm_container_sum: ?UsageBillableSummaryBody = null,
    ingested_timeseries_average: ?UsageBillableSummaryBody = null,
    ingested_timeseries_sum: ?UsageBillableSummaryBody = null,
    rum_units_sum: ?UsageBillableSummaryBody = null,
    fargate_container_profiler_sum: ?UsageBillableSummaryBody = null,
    cws_host_sum: ?UsageBillableSummaryBody = null,
    serverless_infra_sum: ?UsageBillableSummaryBody = null,
    custom_event_sum: ?UsageBillableSummaryBody = null,
    sensitive_data_scanner_sum: ?UsageBillableSummaryBody = null,
    application_security_host_top99p: ?UsageBillableSummaryBody = null,
    logs_indexed_90day_sum: ?UsageBillableSummaryBody = null,
    cspm_host_top99p: ?UsageBillableSummaryBody = null,
    fargate_container_profiler_average: ?UsageBillableSummaryBody = null,
    lambda_function_sum: ?UsageBillableSummaryBody = null,
    ci_pipeline_maximum: ?UsageBillableSummaryBody = null,
    npm_flow_sum: ?UsageBillableSummaryBody = null,
    apm_trace_search_sum: ?UsageBillableSummaryBody = null,
    standard_timeseries_average: ?UsageBillableSummaryBody = null,
    apm_fargate_average: ?UsageBillableSummaryBody = null,
    ci_test_indexed_spans_sum: ?UsageBillableSummaryBody = null,
    dbm_host_sum: ?UsageBillableSummaryBody = null,
    fargate_container_sum: ?UsageBillableSummaryBody = null,
    npm_host_top99p: ?UsageBillableSummaryBody = null,
    online_archive_sum: ?UsageBillableSummaryBody = null,
    apm_host_top99p: ?UsageBillableSummaryBody = null,
    apm_fargate_sum: ?UsageBillableSummaryBody = null,
    prof_container_sum: ?UsageBillableSummaryBody = null,
    rum_replay_sum: ?UsageBillableSummaryBody = null,
    infra_host_sum: ?UsageBillableSummaryBody = null,
    synthetics_api_tests_sum: ?UsageBillableSummaryBody = null,
    logs_indexed_30day_sum: ?UsageBillableSummaryBody = null,
    cws_host_top99p: ?UsageBillableSummaryBody = null,
    observability_pipeline_sum: ?UsageBillableSummaryBody = null,
    logs_indexed_sum: ?UsageBillableSummaryBody = null,
    rum_sum: ?UsageBillableSummaryBody = null,
    infra_host_top99p: ?UsageBillableSummaryBody = null,
    fargate_container_apm_and_profiler_average: ?UsageBillableSummaryBody = null,
    logs_indexed_15day_sum: ?UsageBillableSummaryBody = null,
    infra_and_apm_host_sum: ?UsageBillableSummaryBody = null,
    timeseries_sum: ?UsageBillableSummaryBody = null,
    apm_host_sum: ?UsageBillableSummaryBody = null,
    iot_top99p: ?UsageBillableSummaryBody = null,
    lambda_function_average: ?UsageBillableSummaryBody = null,
    incident_management_maximum: ?UsageBillableSummaryBody = null,
};

pub const SyntheticsMobileStepParamsValue = struct {
};

pub const SyntheticsTestDetailsType = struct {
};

pub const SearchSLOResponseMeta = struct {
    pagination: ?SearchSLOResponseMetaPage = null,
};

pub const IPPrefixesSyntheticsPrivateLocations = struct {
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv6: ?[]const []const u8 = null,
};

pub const NotebooksResponsePage = struct {
    total_count: ?i64 = null,
    total_filtered_count: ?i64 = null,
};

pub const SyntheticsTestPauseStatus = struct {
};

pub const LogsStringBuilderProcessorType = struct {
};

pub const UsageIngestedSpansResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const SLOCorrectionType = struct {
};

pub const WidgetNumberFormat = struct {
    unit: ?NumberFormatUnit = null,
    unit_scale: ?NumberFormatUnitScale = null,
};

pub const WidgetFormulaSort = struct {
    order: WidgetSort,
    index: i64,
    @"type": FormulaType,
};

pub const NotifyEndStates = struct {
};

pub const SyntheticsAssertionType = struct {
};

pub const UsageCloudSecurityPostureManagementResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const NotebookDistributionCellAttributes = struct {
    graph_size: ?NotebookGraphSize = null,
    split_by: ?NotebookSplitBy = null,
    time: ?NotebookCellTime = null,
    definition: DistributionWidgetDefinition,
};

pub const SyntheticsTestCiOptions = struct {
    executionRule: SyntheticsTestExecutionRule,
};

pub const TableWidgetTextFormatReplaceSubstring = struct {
    with: []const u8,
    @"type": TableWidgetTextFormatReplaceSubstringType,
    substring: []const u8,
};

pub const SLOHistoryResponseErrorWithType = struct {
    error_type: []const u8,
    error_message: []const u8,
};

pub const WidgetTextAlign = struct {
};

pub const UsageSyntheticsBrowserHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    browser_check_calls_count: ?i64 = null,
    public_id: ?[]const u8 = null,
};

pub const IPPrefixesOrchestrator = struct {
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv6: ?[]const []const u8 = null,
};

pub const UsageLogsByRetentionResponse = struct {
    usage: ?[]const std.json.Value = null,
};

pub const SunburstWidgetLegend = struct {
};

pub const UsageSpecifiedCustomReportsData = struct {
    id: ?[]const u8 = null,
    attributes: ?UsageSpecifiedCustomReportsAttributes = null,
    @"type": ?UsageReportsType = null,
};

pub const WidgetLiveSpanUnit = struct {
};

pub const HourlyUsageAttributionPagination = struct {
    next_record_id: ?[]const u8 = null,
};

pub const SyntheticsAPITestResultData = struct {
    responseHeaders: ?std.json.Value = null,
    responseSize: ?i64 = null,
    eventType: ?SyntheticsTestProcessStatus = null,
    failure: ?SyntheticsApiTestResultFailure = null,
    httpStatusCode: ?i64 = null,
    timings: ?SyntheticsTiming = null,
    cert: ?SyntheticsSSLCertificate = null,
    requestHeaders: ?std.json.Value = null,
    responseBody: ?[]const u8 = null,
};

pub const BarChartWidgetStyle = struct {
    palette: ?[]const u8 = null,
    display: ?BarChartWidgetDisplay = null,
    scaling: ?BarChartWidgetScaling = null,
};

pub const MonitorFormulaAndFunctionEventAggregation = struct {
};

pub const TimeseriesWidgetLegendColumn = struct {
};

pub const TableWidgetTextFormatReplace = struct {
};

pub const MonitorFormulaAndFunctionEventQueryDefinition = struct {
    data_source: MonitorFormulaAndFunctionEventsDataSource,
    group_by: ?[]const std.json.Value = null,
    search: ?MonitorFormulaAndFunctionEventQueryDefinitionSearch = null,
    name: []const u8,
    indexes: ?[]const []const u8 = null,
    compute: MonitorFormulaAndFunctionEventQueryDefinitionCompute,
};

pub const SyntheticsTestUptime = struct {
    from_ts: ?i64 = null,
    public_id: ?[]const u8 = null,
    overall: ?SyntheticsUptime = null,
    to_ts: ?i64 = null,
};

pub const SyntheticsAPISubtestStepSubtype = struct {
};

pub const FormulaAndFunctionApmDependencyStatsDataSource = struct {
};

pub const TableWidgetTextFormatPalette = struct {
};

pub const WidgetCustomLink = struct {
    label: ?[]const u8 = null,
    is_hidden: ?bool = null,
    link: ?[]const u8 = null,
    override_label: ?[]const u8 = null,
};

pub const SyntheticsTestOptionsSchedulingTimeframe = struct {
    day: i64,
    from: []const u8,
    to: []const u8,
};

pub const IPPrefixesWebhooks = struct {
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv6: ?[]const []const u8 = null,
};

pub const SyntheticsAssertionTargetValueString = struct {
};

pub const LogsListRequestTime = struct {
    from: []const u8,
    to: []const u8,
    timezone: ?[]const u8 = null,
};

pub const WidgetEventSize = struct {
};

pub const SLOListResponseMetadata = struct {
    page: ?SLOListResponseMetadataPage = null,
};

pub const SyntheticsTestRestrictionPolicyBinding = struct {
    principals: ?SyntheticsTestRestrictionPolicyBindingPrincipals = null,
    relation: ?SyntheticsTestRestrictionPolicyBindingRelation = null,
};

pub const FormulaAndFunctionQueryDefinition = struct {
};

pub const ApplicationKeyListResponse = struct {
    application_keys: ?[]const std.json.Value = null,
};

pub const NotebookCreateRequest = struct {
    data: NotebookCreateData,
};

pub const SLOCorrectionCategory = struct {
};

pub const AWSAccountDeleteRequest = struct {
    access_key_id: ?[]const u8 = null,
    account_id: ?[]const u8 = null,
    role_name: ?[]const u8 = null,
};

pub const RunWorkflowWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    title_size: ?[]const u8 = null,
    inputs: ?[]const std.json.Value = null,
    title_align: ?WidgetTextAlign = null,
    time: ?WidgetTime = null,
    workflow_id: []const u8,
    @"type": RunWorkflowWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const TableWidgetTextFormatReplaceSubstringType = struct {
};

pub const IPPrefixesLogs = struct {
    prefixes_ipv4: ?[]const []const u8 = null,
    prefixes_ipv6: ?[]const []const u8 = null,
};

pub const NotifyEndState = struct {
};

pub const Widget = struct {
    definition: WidgetDefinition,
    id: ?i64 = null,
    layout: ?WidgetLayout = null,
};

pub const UsageHostHour = struct {
    hour: ?[]const u8 = null,
    agent_host_count: ?i64 = null,
    org_name: ?[]const u8 = null,
    alibaba_host_count: ?i64 = null,
    apm_azure_app_service_host_count: ?i64 = null,
    vsphere_host_count: ?i64 = null,
    apm_host_count: ?i64 = null,
    aws_host_count: ?i64 = null,
    gcp_host_count: ?i64 = null,
    opentelemetry_apm_host_count: ?i64 = null,
    opentelemetry_host_count: ?i64 = null,
    azure_host_count: ?i64 = null,
    container_count: ?i64 = null,
    host_count: ?i64 = null,
    heroku_host_count: ?i64 = null,
    infra_azure_app_service: ?i64 = null,
    public_id: ?[]const u8 = null,
};

pub const SyntheticsAPITestStepSubtype = struct {
};

pub const SyntheticsBrowserVariable = struct {
    example: ?[]const u8 = null,
    pattern: ?[]const u8 = null,
    id: ?[]const u8 = null,
    name: []const u8,
    secure: ?bool = null,
    @"type": SyntheticsBrowserVariableType,
};

pub const UsageSyntheticsHour = struct {
    org_name: ?[]const u8 = null,
    hour: ?[]const u8 = null,
    check_calls_count: ?i64 = null,
    public_id: ?[]const u8 = null,
};

pub const SLOHistoryResponseError = struct {
    @"error": ?[]const u8 = null,
};

pub const FormulaAndFunctionMetricAggregation = struct {
};

pub const SLOThreshold = struct {
    timeframe: SLOTimeframe,
    target_display: ?[]const u8 = null,
    target: f64,
    warning: ?f64 = null,
    warning_display: ?[]const u8 = null,
};

pub const SyntheticsTestRequestDNSServerPort = struct {
};

pub const MonitorType = struct {
};

pub const WidgetStyleOrderBy = struct {
};

pub const LogsDecoderProcessorType = struct {
};

pub const PagerDutyService = struct {
    service_name: []const u8,
    service_key: []const u8,
};

pub const MonitorUpdateRequest = struct {
    modified: ?[]const u8 = null,
    draft_status: ?MonitorDraftStatus = null,
    created: ?[]const u8 = null,
    state: ?MonitorState = null,
    assets: ?[]const std.json.Value = null,
    creator: ?Creator = null,
    id: ?i64 = null,
    options: ?MonitorOptions = null,
    tags: ?[]const []const u8 = null,
    overall_state: ?MonitorOverallStates = null,
    priority: ?i64 = null,
    deleted: ?[]const u8 = null,
    restricted_roles: ?[]const []const u8 = null,
    multi: ?bool = null,
    name: ?[]const u8 = null,
    query: ?[]const u8 = null,
    @"type": ?MonitorType = null,
    message: ?[]const u8 = null,
};

pub const MonitorFormulaAndFunctionEventQueryGroupBy = struct {
    limit: ?i64 = null,
    facet: []const u8,
    sort: ?MonitorFormulaAndFunctionEventQueryGroupBySort = null,
};

pub const MonitorOptionsCustomSchedule = struct {
    recurrences: ?[]const std.json.Value = null,
};

pub const SLOTimeSliceSpec = struct {
    time_slice: SLOTimeSliceCondition,
};

pub const UsageRumSessionsHour = struct {
    hour: ?[]const u8 = null,
    session_count_android: ?i64 = null,
    replay_session_count: ?i64 = null,
    session_count_reactnative: ?i64 = null,
    session_count_flutter: ?i64 = null,
    org_name: ?[]const u8 = null,
    session_count_ios: ?i64 = null,
    public_id: ?[]const u8 = null,
    session_count: ?i64 = null,
};

pub const NoteWidgetDefinitionType = struct {
};

pub const UserListResponse = struct {
    users: ?[]const std.json.Value = null,
};

pub const LogsServiceRemapperType = struct {
};

pub const NotifyEndType = struct {
};

pub const LogsDecoderProcessorInputRepresentation = struct {
};

pub const SyntheticsAssertionTargetValueNumber = struct {
};

pub const SyntheticsMobileStepParamsElementContextType = struct {
};

pub const UsageCustomReportsData = struct {
    id: ?[]const u8 = null,
    attributes: ?UsageCustomReportsAttributes = null,
    @"type": ?UsageReportsType = null,
};

pub const DistributionWidgetRequest = struct {
    rum_query: ?LogQueryDefinition = null,
    security_query: ?LogQueryDefinition = null,
    response_format: ?FormulaAndFunctionResponseFormat = null,
    network_query: ?LogQueryDefinition = null,
    event_query: ?LogQueryDefinition = null,
    formulas: ?[]const std.json.Value = null,
    request_type: ?WidgetHistogramRequestType = null,
    style: ?WidgetStyle = null,
    q: ?[]const u8 = null,
    queries: ?[]const std.json.Value = null,
    apm_stats_query: ?ApmStatsQueryDefinition = null,
    apm_query: ?LogQueryDefinition = null,
    log_query: ?LogQueryDefinition = null,
    process_query: ?ProcessQueryDefinition = null,
    profile_metrics_query: ?LogQueryDefinition = null,
    query: ?DistributionWidgetHistogramRequestQuery = null,
};

pub const SyntheticsAssertionTarget = struct {
    timingsScope: ?SyntheticsAssertionTimingsScope = null,
    property: ?[]const u8 = null,
    @"type": SyntheticsAssertionType,
    target: SyntheticsAssertionTargetValue,
    operator: SyntheticsAssertionOperator,
};

pub const SyntheticsGetBrowserTestLatestResultsResponse = struct {
    last_timestamp_fetched: ?i64 = null,
    results: ?[]const std.json.Value = null,
};

pub const WidgetFormulaStyle = struct {
    palette: ?[]const u8 = null,
    palette_index: ?i64 = null,
};

pub const AlertGraphWidgetDefinitionType = struct {
};

pub const WidgetSizeFormat = struct {
};

pub const AWSLogsAsyncError = struct {
    message: ?[]const u8 = null,
    code: ?[]const u8 = null,
};

pub const SyntheticsTestRequestBodyType = struct {
};

pub const WidgetTime = struct {
};

pub const SyntheticsDeleteTestsResponse = struct {
    deleted_tests: ?[]const std.json.Value = null,
};

pub const APIErrorResponse = struct {
    errors: []const []const u8,
};

pub const LogsSchemaCategoryMapperTargets = struct {
    id: ?[]const u8 = null,
    name: ?[]const u8 = null,
};

pub const SyntheticsPrivateLocationCreationResponse = struct {
    result_encryption: ?SyntheticsPrivateLocationCreationResponseResultEncryption = null,
    config: ?std.json.Value = null,
    private_location: ?SyntheticsPrivateLocation = null,
};

pub const AWSEventBridgeCreateResponse = struct {
    status: ?AWSEventBridgeCreateStatus = null,
    has_bus: ?bool = null,
    event_source_name: ?[]const u8 = null,
    region: ?[]const u8 = null,
};

pub const SLOCorrectionUpdateData = struct {
    attributes: ?SLOCorrectionUpdateRequestAttributes = null,
    @"type": ?SLOCorrectionType = null,
};

pub const ApmStatsQueryColumnType = struct {
    alias: ?[]const u8 = null,
    order: ?WidgetSort = null,
    cell_display_mode: ?TableWidgetCellDisplayMode = null,
    name: []const u8,
};

pub const DistributionWidgetYAxis = struct {
    include_zero: ?bool = null,
    label: ?[]const u8 = null,
    max: ?[]const u8 = null,
    scale: ?[]const u8 = null,
    min: ?[]const u8 = null,
};

pub const ListStreamColumn = struct {
    width: ListStreamColumnWidth,
    field: []const u8,
};

pub const SyntheticsTestRequestCertificateItem = struct {
    filename: ?[]const u8 = null,
    updatedAt: ?[]const u8 = null,
    content: ?[]const u8 = null,
};

pub const AWSAccount = struct {
    cspm_resource_collection_enabled: ?bool = null,
    filter_tags: ?[]const []const u8 = null,
    secret_access_key: ?[]const u8 = null,
    extended_resource_collection_enabled: ?bool = null,
    metrics_collection_enabled: ?bool = null,
    access_key_id: ?[]const u8 = null,
    account_id: ?[]const u8 = null,
    excluded_regions: ?[]const []const u8 = null,
    host_tags: ?[]const []const u8 = null,
    account_specific_namespace_rules: ?std.json.Value = null,
    resource_collection_enabled: ?bool = null,
    role_name: ?[]const u8 = null,
};

pub const EventAlertType = struct {
};

pub const SyntheticsMobileStepParamsElementUserLocatorValuesItems = struct {
    value: ?[]const u8 = null,
    @"type": ?SyntheticsMobileStepParamsElementUserLocatorValuesItemsType = null,
};

pub const CheckStatusWidgetDefinition = struct {
    group: ?[]const u8 = null,
    group_by: ?[]const []const u8 = null,
    tags: ?[]const []const u8 = null,
    grouping: WidgetGrouping,
    title_align: ?WidgetTextAlign = null,
    title_size: ?[]const u8 = null,
    time: ?WidgetTime = null,
    check: []const u8,
    @"type": CheckStatusWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const WidgetFieldSort = struct {
    order: WidgetSort,
    column: []const u8,
};

pub const TagToHosts = struct {
    tags: ?std.json.Value = null,
};

pub const GeomapWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    requests: []const std.json.Value,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    time: ?WidgetTime = null,
    view: GeomapWidgetDefinitionView,
    style: GeomapWidgetDefinitionStyle,
    @"type": GeomapWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const MonitorStateGroup = struct {
    last_notified_ts: ?i64 = null,
    last_triggered_ts: ?i64 = null,
    status: ?MonitorOverallStates = null,
    last_nodata_ts: ?i64 = null,
    last_resolved_ts: ?i64 = null,
    name: ?[]const u8 = null,
};

pub const SyntheticsBrowserTest = struct {
    steps: ?[]const std.json.Value = null,
    options: SyntheticsTestOptions,
    monitor_id: ?i64 = null,
    tags: ?[]const []const u8 = null,
    public_id: ?[]const u8 = null,
    locations: []const []const u8,
    status: ?SyntheticsTestPauseStatus = null,
    name: []const u8,
    @"type": SyntheticsBrowserTestType,
    config: SyntheticsBrowserTestConfig,
    message: []const u8,
};

pub const FormulaType = struct {
};

pub const SyntheticsPatchTestOperationName = struct {
};

pub const TreeMapColorBy = struct {
};

pub const SyntheticsMobileStepParamsElementRelativePosition = struct {
    x: ?f64 = null,
    y: ?f64 = null,
};

pub const TopologyMapWidgetDefinition = struct {
    title_align: ?WidgetTextAlign = null,
    custom_links: ?[]const std.json.Value = null,
    requests: []const std.json.Value,
    @"type": TopologyMapWidgetDefinitionType,
    title_size: ?[]const u8 = null,
    title: ?[]const u8 = null,
};

pub const LogsGeoIPParserType = struct {
};

pub const ChangeWidgetDefinition = struct {
    custom_links: ?[]const std.json.Value = null,
    requests: []const std.json.Value,
    title_size: ?[]const u8 = null,
    title_align: ?WidgetTextAlign = null,
    time: ?WidgetTime = null,
    @"type": ChangeWidgetDefinitionType,
    title: ?[]const u8 = null,
};

pub const WidgetSort = struct {
};

pub const UsageTopAvgMetricsResponse = struct {
    usage: ?[]const std.json.Value = null,
    metadata: ?UsageTopAvgMetricsMetadata = null,
};

pub const SyntheticsBasicAuthOauthClient = struct {
    scope: ?[]const u8 = null,
    accessTokenUrl: []const u8,
    clientSecret: []const u8,
    clientId: []const u8,
    tokenApiAuthentication: SyntheticsBasicAuthOauthTokenApiAuthentication,
    resource: ?[]const u8 = null,
    @"type": SyntheticsBasicAuthOauthClientType,
    audience: ?[]const u8 = null,
};

pub const WidgetLayoutType = struct {
};


///////////////////////////////////////////
// Generated Zig API client from OpenAPI
///////////////////////////////////////////

/////////////////
// Summary:
// List all Azure integrations
//
// Description:
// List all Datadog-Azure integrations configured in your Datadog account.
//
pub fn ListAzureIntegration(allocator: std.mem.Allocator) !AzureAccountListResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/integration/azure");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(AzureAccountListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create an Azure integration
//
// Description:
// Create a Datadog-Azure integration.
// 
// Using the `POST` method updates your integration configuration by adding your new
// configuration to the existing one in your Datadog organization.
// 
// Using the `PUT` method updates your integration configuration by replacing your
// current configuration with the new one sent to your Datadog organization.
//
pub fn CreateAzureIntegration(allocator: std.mem.Allocator, requestBody: AzureAccount) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/azure", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Update an Azure integration
//
// Description:
// Update a Datadog-Azure integration. Requires an existing `tenant_name` and `client_id`.
// Any other fields supplied will overwrite existing values. To overwrite `tenant_name` or `client_id`,
// use `new_tenant_name` and `new_client_id`. To leave a field unchanged, do not supply that field in the payload.
//
pub fn UpdateAzureIntegration(allocator: std.mem.Allocator, requestBody: AzureAccount) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/azure", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete an Azure integration
//
// Description:
// Delete a given Datadog-Azure integration from your Datadog account.
//
pub fn DeleteAzureIntegration(allocator: std.mem.Allocator, requestBody: AzureAccount) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/azure", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all application keys
//
// Description:
// Get all application keys available for your Datadog account.
// This endpoint is disabled for organizations in [One-Time Read mode](https://docs.datadoghq.com/account_management/api-app-keys/#one-time-read-mode).
//
pub fn ListApplicationKeys(allocator: std.mem.Allocator) !ApplicationKeyListResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/application_key");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(ApplicationKeyListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create an application key
//
// Description:
// Create an application key with a given name.
// This endpoint is disabled for organizations in [One-Time Read mode](https://docs.datadoghq.com/account_management/api-app-keys/#one-time-read-mode).
//
pub fn CreateApplicationKey(allocator: std.mem.Allocator, requestBody: ApplicationKey) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/application_key", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get an event
//
// Description:
// This endpoint allows you to query for event details.
// 
// **Note**: If the event you’re querying contains markdown formatting of any kind,
// you may see characters such as `%`,`\`,`n` in your output.
//
pub fn GetEvent(allocator: std.mem.Allocator, event_id: []const u8) !EventResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/events/{s}", .{event_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(EventResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get a Mobile test
//
// Description:
// Get the detailed configuration associated with
// a Synthetic Mobile test.
//
pub fn GetMobileTest(allocator: std.mem.Allocator, public_id: []const u8) !SyntheticsMobileTest {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/mobile/{s}", .{public_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsMobileTest, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Edit a Mobile test
//
// Description:
// Edit the configuration of a Synthetic Mobile test.
//
pub fn UpdateMobileTest(allocator: std.mem.Allocator, public_id: []const u8, requestBody: SyntheticsMobileTest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/mobile/{s}", .{public_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Check that an AWS Lambda Function exists
//
// Description:
// Test if permissions are present to add a log-forwarding triggers for the given services and AWS account. The input
// is the same as for Enable an AWS service log collection. Subsequent requests will always repeat the above, so this
// endpoint can be polled intermittently instead of blocking.
// 
// - Returns a status of 'created' when it's checking if the Lambda exists in the account.
// - Returns a status of 'waiting' while checking.
// - Returns a status of 'checked and ok' if the Lambda exists.
// - Returns a status of 'error' if the Lambda does not exist.
//
pub fn CheckAWSLogsLambdaAsync(allocator: std.mem.Allocator, requestBody: AWSAccountAndLambdaRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/logs/check_async", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all SLO corrections
//
// Description:
// Get all Service Level Objective corrections.
//
pub fn ListSLOCorrection(allocator: std.mem.Allocator, offset: []const u8, limit: []const u8) !SLOCorrectionListResponse {
    _ = offset;
    _ = limit;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/correction", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SLOCorrectionListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create an SLO correction
//
// Description:
// Create an SLO Correction.
//
pub fn CreateSLOCorrection(allocator: std.mem.Allocator, requestBody: SLOCorrectionCreateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/correction", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Check if SLOs can be safely deleted
//
// Description:
// Check if an SLO can be safely deleted. For example,
// assure an SLO can be deleted without disrupting a dashboard.
//
pub fn CheckCanDeleteSLO(allocator: std.mem.Allocator, ids: []const u8) !CheckCanDeleteSLOResponse {
    _ = ids;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/can_delete", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(CheckCanDeleteSLOResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Bulk Delete SLO Timeframes
//
// Description:
// Delete (or partially delete) multiple service level objective objects.
// 
// This endpoint facilitates deletion of one or more thresholds for one or more
// service level objective objects. If all thresholds are deleted, the service level
// objective object is deleted as well.
//
pub fn DeleteSLOTimeframeInBulk(allocator: std.mem.Allocator, requestBody: SLOBulkDelete) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/bulk_delete", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get a dashboard list
//
// Description:
// Fetch an existing dashboard list's definition.
//
pub fn GetDashboardList(allocator: std.mem.Allocator, list_id: []const u8) !DashboardList {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/lists/manual/{s}", .{list_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(DashboardList, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update a dashboard list
//
// Description:
// Update the name of a dashboard list.
//
pub fn UpdateDashboardList(allocator: std.mem.Allocator, list_id: []const u8, requestBody: DashboardList) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/lists/manual/{s}", .{list_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a dashboard list
//
// Description:
// Delete a dashboard list.
//
pub fn DeleteDashboardList(allocator: std.mem.Allocator, list_id: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/lists/manual/{s}", .{list_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Pause or start a test
//
// Description:
// Pause or start a Synthetic test by changing the status.
//
pub fn UpdateTestPauseStatus(allocator: std.mem.Allocator, public_id: []const u8, requestBody: SyntheticsUpdateTestPauseStatusPayload) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/{s}/status", .{public_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get hourly logs usage by retention
//
// Description:
// Get hourly usage for indexed logs by retention period.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageLogsByRetention(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageLogsByRetentionResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/logs-by-retention", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageLogsByRetentionResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a webhooks integration
//
// Description:
// Creates an endpoint with the name `<WEBHOOK_NAME>`.
//
pub fn CreateWebhooksIntegration(allocator: std.mem.Allocator, requestBody: WebhooksIntegration) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/webhooks/configuration/webhooks", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Search metrics
//
// Description:
// **Note**: This endpoint is deprecated. Use `/api/v2/metrics` instead.
// 
// Search for metrics from the last 24 hours in Datadog.
//
pub fn ListMetrics(allocator: std.mem.Allocator, q: []const u8) !MetricSearchResponse {
    _ = q;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/search", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(MetricSearchResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for online archive
//
// Description:
// Get hourly usage for online archive.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageOnlineArchive(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageOnlineArchiveResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/online-archive", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageOnlineArchiveResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Take graph snapshots
//
// Description:
// Take graph snapshots. Snapshots are PNG images generated by rendering a specified widget in a web page and capturing it once the data is available. The image is then uploaded to cloud storage.
// 
// **Note**: When a snapshot is created, there is some delay before it is available.
//
pub fn GetGraphSnapshot(allocator: std.mem.Allocator, metric_query: []const u8, start: []const u8, end: []const u8, event_query: []const u8, graph_def: []const u8, title: []const u8, height: []const u8, width: []const u8) !GraphSnapshot {
    _ = metric_query;
    _ = start;
    _ = end;
    _ = event_query;
    _ = graph_def;
    _ = title;
    _ = height;
    _ = width;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/graph/snapshot", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(GraphSnapshot, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Search logs
//
// Description:
// List endpoint returns logs that match a log search query.
// [Results are paginated][1].
// 
// **If you are considering archiving logs for your organization,
// consider use of the Datadog archive capabilities instead of the log list API.
// See [Datadog Logs Archive documentation][2].**
// 
// [1]: /logs/guide/collect-multiple-logs-with-pagination
// [2]: https://docs.datadoghq.com/logs/archives
//
pub fn ListLogs(allocator: std.mem.Allocator, requestBody: LogsListRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs-queries/list", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Validate an existing monitor
//
// Description:
// Validate the monitor provided in the request.
//
pub fn ValidateExistingMonitor(allocator: std.mem.Allocator, monitor_id: []const u8, requestBody: Monitor) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor/{s}/validate", .{monitor_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get specified monthly custom reports
//
// Description:
// Get specified monthly custom reports.
// **Note:** This endpoint will be fully deprecated on December 1, 2022.
// Refer to [Migrating from v1 to v2 of the Usage Attribution API](https://docs.datadoghq.com/account_management/guide/usage-attribution-migration/) for the associated migration guide.
//
pub fn GetSpecifiedMonthlyCustomReports(allocator: std.mem.Allocator, report_id: []const u8) !UsageSpecifiedCustomReportsResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monthly_custom_reports/{s}", .{report_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageSpecifiedCustomReportsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get all notebooks
//
// Description:
// Get all notebooks. This can also be used to search for notebooks with a particular `query` in the notebook
// `name` or author `handle`.
//
pub fn ListNotebooks(allocator: std.mem.Allocator, author_handle: []const u8, exclude_author_handle: []const u8, start: []const u8, count: []const u8, sort_field: []const u8, sort_dir: []const u8, query: []const u8, include_cells: []const u8, is_template: []const u8, @"type": []const u8) !NotebooksResponse {
    _ = author_handle;
    _ = exclude_author_handle;
    _ = start;
    _ = count;
    _ = sort_field;
    _ = sort_dir;
    _ = query;
    _ = include_cells;
    _ = is_template;
    _ = @"type";
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/notebooks", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(NotebooksResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a notebook
//
// Description:
// Create a notebook using the specified options.
//
pub fn CreateNotebook(allocator: std.mem.Allocator, requestBody: NotebookCreateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/notebooks", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get a single service object
//
// Description:
// Get service name in the Datadog-PagerDuty integration.
//
pub fn GetPagerDutyIntegrationService(allocator: std.mem.Allocator, service_name: []const u8) !PagerDutyServiceName {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/pagerduty/configuration/services/{s}", .{service_name});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(PagerDutyServiceName, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update a single service object
//
// Description:
// Update a single service object in the Datadog-PagerDuty integration.
//
pub fn UpdatePagerDutyIntegrationService(allocator: std.mem.Allocator, service_name: []const u8, requestBody: PagerDutyServiceKey) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/pagerduty/configuration/services/{s}", .{service_name, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a single service object
//
// Description:
// Delete a single service object in the Datadog-PagerDuty integration.
//
pub fn DeletePagerDutyIntegrationService(allocator: std.mem.Allocator, service_name: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/pagerduty/configuration/services/{s}", .{service_name});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get a custom variable
//
// Description:
// Shows the content of the custom variable with the name `<CUSTOM_VARIABLE_NAME>`.
// 
// If the custom variable is secret, the value does not return in the
// response payload.
//
pub fn GetWebhooksIntegrationCustomVariable(allocator: std.mem.Allocator, custom_variable_name: []const u8) !WebhooksIntegrationCustomVariableResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/webhooks/configuration/custom-variables/{s}", .{custom_variable_name});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(WebhooksIntegrationCustomVariableResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update a custom variable
//
// Description:
// Updates the endpoint with the name `<CUSTOM_VARIABLE_NAME>`.
//
pub fn UpdateWebhooksIntegrationCustomVariable(allocator: std.mem.Allocator, custom_variable_name: []const u8, requestBody: WebhooksIntegrationCustomVariableUpdateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/webhooks/configuration/custom-variables/{s}", .{custom_variable_name, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a custom variable
//
// Description:
// Deletes the endpoint with the name `<CUSTOM_VARIABLE_NAME>`.
//
pub fn DeleteWebhooksIntegrationCustomVariable(allocator: std.mem.Allocator, custom_variable_name: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/webhooks/configuration/custom-variables/{s}", .{custom_variable_name});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Create a shared dashboard
//
// Description:
// Share a specified private dashboard, generating a URL at which it can be publicly viewed.
//
pub fn CreatePublicDashboard(allocator: std.mem.Allocator, requestBody: SharedDashboard) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/public", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all custom metrics by hourly average
//
// Description:
// Get all [custom metrics](https://docs.datadoghq.com/developers/metrics/custom_metrics/) by hourly average. Use the month parameter to get a month-to-date data resolution or use the day parameter to get a daily resolution. One of the two is required, and only one of the two is allowed.
//
pub fn GetUsageTopAvgMetrics(allocator: std.mem.Allocator, month: []const u8, day: []const u8, names: []const u8, limit: []const u8, next_record_id: []const u8) !UsageTopAvgMetricsResponse {
    _ = month;
    _ = day;
    _ = names;
    _ = limit;
    _ = next_record_id;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/top_avg_metrics", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageTopAvgMetricsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Check if a monitor can be deleted
//
// Description:
// Check if the given monitors can be deleted.
//
pub fn CheckCanDeleteMonitor(allocator: std.mem.Allocator, monitor_ids: []const u8) !CheckCanDeleteMonitorResponse {
    _ = monitor_ids;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor/can_delete", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(CheckCanDeleteMonitorResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update Azure integration host filters
//
// Description:
// Update the defined list of host filters for a given Datadog-Azure integration.
//
pub fn UpdateAzureHostFilters(allocator: std.mem.Allocator, requestBody: AzureAccount) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/azure/host_filters", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get list of AWS log ready services
//
// Description:
// **This endpoint is deprecated - use the V2 endpoint instead.** Get the list of current AWS services that Datadog offers automatic log collection. Use returned service IDs with the services parameter for the Enable an AWS service log collection API endpoint.
//
pub fn ListAWSLogsServices(allocator: std.mem.Allocator) ![]const u8 {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/integration/aws/logs/services");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice([]const u8, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Enable an AWS Logs integration
//
// Description:
// Enable automatic log collection for a list of services. This should be run after running `CreateAWSLambdaARN` to save the configuration.
//
pub fn EnableAWSLogServices(allocator: std.mem.Allocator, requestBody: AWSLogsServicesRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/logs/services", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get organization information
//
// Description:
// Get organization information.
//
pub fn GetOrg(allocator: std.mem.Allocator, public_id: []const u8) !OrganizationResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/org/{s}", .{public_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(OrganizationResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update your organization
//
// Description:
// Update your organization.
//
pub fn UpdateOrg(allocator: std.mem.Allocator, public_id: []const u8, requestBody: Organization) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/org/{s}", .{public_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get a private location
//
// Description:
// Get a Synthetic private location.
//
pub fn GetPrivateLocation(allocator: std.mem.Allocator, location_id: []const u8) !SyntheticsPrivateLocation {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/private-locations/{s}", .{location_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsPrivateLocation, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Edit a private location
//
// Description:
// Edit a Synthetic private location.
//
pub fn UpdatePrivateLocation(allocator: std.mem.Allocator, location_id: []const u8, requestBody: SyntheticsPrivateLocation) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/private-locations/{s}", .{location_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a private location
//
// Description:
// Delete a Synthetic private location.
//
pub fn DeletePrivateLocation(allocator: std.mem.Allocator, location_id: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/private-locations/{s}", .{location_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Monitors search
//
// Description:
// Search and filter your monitors details.
//
pub fn SearchMonitors(allocator: std.mem.Allocator, query: []const u8, page: []const u8, per_page: []const u8, sort: []const u8) !MonitorSearchResponse {
    _ = query;
    _ = page;
    _ = per_page;
    _ = sort;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor/search", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(MonitorSearchResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get all dashboard lists
//
// Description:
// Fetch all of your existing dashboard list definitions.
//
pub fn ListDashboardLists(allocator: std.mem.Allocator) !DashboardListListResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/dashboard/lists/manual");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(DashboardListListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a dashboard list
//
// Description:
// Create an empty dashboard list.
//
pub fn CreateDashboardList(allocator: std.mem.Allocator, requestBody: DashboardList) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/lists/manual", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get hourly usage for logs
//
// Description:
// Get hourly usage for logs.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageLogs(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageLogsResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/logs", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageLogsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get API key
//
// Description:
// Get a given API key.
//
pub fn GetAPIKey(allocator: std.mem.Allocator, key: []const u8) !ApiKeyResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/api_s/{s}", .{key});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(ApiKeyResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Edit an API key
//
// Description:
// Edit an API key name.
//
pub fn UpdateAPIKey(allocator: std.mem.Allocator, key: []const u8, requestBody: ApiKey) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/api_s/{s}", .{key, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete an API key
//
// Description:
// Delete a given API key.
//
pub fn DeleteAPIKey(allocator: std.mem.Allocator, key: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/api_s/{s}", .{key});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Submit a Service Check
//
// Description:
// Submit a list of Service Checks.
// 
// **Notes**:
// - A valid API key is required.
// - Service checks can be submitted up to 10 minutes in the past.
//
pub fn SubmitServiceCheck(allocator: std.mem.Allocator, requestBody: ServiceChecks) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/check_run", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Submit metrics
//
// Description:
// The metrics end-point allows you to post time-series data that can be graphed on Datadog’s dashboards.
// The maximum payload size is 3.2 megabytes (3200000 bytes). Compressed payloads must have a decompressed size of less than 62 megabytes (62914560 bytes).
// 
// If you’re submitting metrics directly to the Datadog API without using DogStatsD, expect:
// 
// - 64 bits for the timestamp
// - 64 bits for the value
// - 40 bytes for the metric names
// - 50 bytes for the timeseries
// - The full payload is approximately 100 bytes. However, with the DogStatsD API,
// compression is applied, which reduces the payload size.
//
pub fn SubmitMetrics(allocator: std.mem.Allocator, Content_Encoding: []const u8, requestBody: MetricsPayload) !void {
    _ = Content_Encoding;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/series", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// get hourly usage for network flows
//
// Description:
// Get hourly usage for network flows.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageNetworkFlows(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageNetworkFlowsResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/network_flows", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageNetworkFlowsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Unmute a host
//
// Description:
// Unmutes a host. This endpoint takes no JSON arguments.
//
pub fn UnmuteHost(allocator: std.mem.Allocator, host_name: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/host/{s}/unmute", .{host_name});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get active metrics list
//
// Description:
// Get the list of actively reporting metrics from a given time until now.
//
pub fn ListActiveMetrics(allocator: std.mem.Allocator, from: []const u8, host: []const u8, tag_filter: []const u8) !MetricsListResponse {
    _ = from;
    _ = host;
    _ = tag_filter;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/metrics", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(MetricsListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get the list of all Synthetic tests
//
// Description:
// Get the list of all Synthetic tests.
//
pub fn ListTests(allocator: std.mem.Allocator, page_size: []const u8, page_number: []const u8) !SyntheticsListTestsResponse {
    _ = page_size;
    _ = page_number;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsListTestsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// List all users
//
// Description:
// List all users for your organization.
//
pub fn ListUsers(allocator: std.mem.Allocator) !UserListResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/user");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UserListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a user
//
// Description:
// Create a user for your organization.
// 
// **Note**: Users can only be created with the admin access role
// if application keys belong to administrators.
//
pub fn CreateUser(allocator: std.mem.Allocator, requestBody: User) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/user", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get a notebook
//
// Description:
// Get a notebook using the specified notebook ID.
//
pub fn GetNotebook(allocator: std.mem.Allocator, notebook_id: []const u8) !NotebookResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/notebooks/{s}", .{notebook_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(NotebookResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update a notebook
//
// Description:
// Update a notebook using the specified ID.
//
pub fn UpdateNotebook(allocator: std.mem.Allocator, notebook_id: []const u8, requestBody: NotebookUpdateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/notebooks/{s}", .{notebook_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a notebook
//
// Description:
// Delete a notebook using the specified ID.
//
pub fn DeleteNotebook(allocator: std.mem.Allocator, notebook_id: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/notebooks/{s}", .{notebook_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get hourly usage for profiled hosts
//
// Description:
// Get hourly usage for profiled hosts.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageProfiling(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageProfilingResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/profiling", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageProfilingResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get a list of events
//
// Description:
// The event stream can be queried and filtered by time, priority, sources and tags.
// 
// **Notes**:
// - If the event you’re querying contains markdown formatting of any kind,
// you may see characters such as `%`,`\`,`n` in your output.
// 
// - This endpoint returns a maximum of `1000` most recent results. To return additional results,
// identify the last timestamp of the last result and set that as the `end` query time to
// paginate the results. You can also use the page parameter to specify which set of `1000` results to return.
//
pub fn ListEvents(allocator: std.mem.Allocator, start: []const u8, end: []const u8, priority: []const u8, sources: []const u8, tags: []const u8, unaggregated: []const u8, exclude_aggregate: []const u8, page: []const u8) !EventListResponse {
    _ = start;
    _ = end;
    _ = priority;
    _ = sources;
    _ = tags;
    _ = unaggregated;
    _ = exclude_aggregate;
    _ = page;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/events", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(EventListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Post an event
//
// Description:
// This endpoint allows you to post events to the stream.
// Tag them, set priority and event aggregate them with other events.
//
pub fn CreateEvent(allocator: std.mem.Allocator, requestBody: EventCreateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/events", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get hourly usage for CSM Pro
//
// Description:
// Get hourly usage for cloud security management (CSM) pro.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageCloudSecurityPostureManagement(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageCloudSecurityPostureManagementResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/cspm", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageCloudSecurityPostureManagementResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for incident management
//
// Description:
// Get hourly usage for incident management.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetIncidentManagement(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageIncidentManagementResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/incident-management", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageIncidentManagementResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a private location
//
// Description:
// Create a new Synthetic private location.
//
pub fn CreatePrivateLocation(allocator: std.mem.Allocator, requestBody: SyntheticsPrivateLocation) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/private-locations", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all Amazon EventBridge sources
//
// Description:
// **This endpoint is deprecated - use the V2 endpoints instead.** Get all Amazon EventBridge sources.
//
pub fn ListAWSEventBridgeSources(allocator: std.mem.Allocator) !AWSEventBridgeListResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/integration/aws/event_bridge");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(AWSEventBridgeListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create an Amazon EventBridge source
//
// Description:
// **This endpoint is deprecated - use the V2 endpoints instead.** Create an Amazon EventBridge source.
//
pub fn CreateAWSEventBridgeSource(allocator: std.mem.Allocator, requestBody: AWSEventBridgeCreateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/event_bridge", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete an Amazon EventBridge source
//
// Description:
// **This endpoint is deprecated - use the V2 endpoints instead.** Delete an Amazon EventBridge source.
//
pub fn DeleteAWSEventBridgeSource(allocator: std.mem.Allocator, requestBody: AWSEventBridgeDeleteRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/event_bridge", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get a pipeline
//
// Description:
// Get a specific pipeline from your organization.
// This endpoint takes no JSON arguments.
//
pub fn GetLogsPipeline(allocator: std.mem.Allocator, pipeline_id: []const u8) !LogsPipeline {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs/config/pipelines/{s}", .{pipeline_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(LogsPipeline, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update a pipeline
//
// Description:
// Update a given pipeline configuration to change it’s processors or their order.
// 
// **Note**: Using this method updates your pipeline configuration by **replacing**
// your current configuration with the new one sent to your Datadog organization.
//
pub fn UpdateLogsPipeline(allocator: std.mem.Allocator, pipeline_id: []const u8, requestBody: LogsPipeline) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs/config/pipelines/{s}", .{pipeline_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a pipeline
//
// Description:
// Delete a given pipeline from your organization.
// This endpoint takes no JSON arguments.
//
pub fn DeleteLogsPipeline(allocator: std.mem.Allocator, pipeline_id: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs/config/pipelines/{s}", .{pipeline_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Create a new service object
//
// Description:
// Create a new service object in the PagerDuty integration.
//
pub fn CreatePagerDutyIntegrationService(allocator: std.mem.Allocator, requestBody: PagerDutyService) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/pagerduty/configuration/services", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get pipeline order
//
// Description:
// Get the current order of your pipelines.
// This endpoint takes no JSON arguments.
//
pub fn GetLogsPipelineOrder(allocator: std.mem.Allocator) !LogsPipelinesOrder {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/logs/config/pipeline-order");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(LogsPipelinesOrder, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update pipeline order
//
// Description:
// Update the order of your pipelines. Since logs are processed sequentially, reordering a pipeline may change
// the structure and content of the data processed by other pipelines and their processors.
// 
// **Note**: Using the `PUT` method updates your pipeline order by replacing your current order
// with the new one sent to your Datadog organization.
//
pub fn UpdateLogsPipelineOrder(allocator: std.mem.Allocator, requestBody: LogsPipelinesOrder) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs/config/pipeline-order", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get hourly usage attribution
//
// Description:
// Get hourly usage attribution. Multi-region data is available starting March 1, 2023.
// 
// This API endpoint is paginated. To make sure you receive all records, check if the value of `next_record_id` is
// set in the response. If it is, make another request and pass `next_record_id` as a parameter.
// Pseudo code example:
// 
// ```
// response := GetHourlyUsageAttribution(start_month)
// cursor := response.metadata.pagination.next_record_id
// WHILE cursor != null BEGIN
//   sleep(5 seconds)  # Avoid running into rate limit
//   response := GetHourlyUsageAttribution(start_month, next_record_id=cursor)
//   cursor := response.metadata.pagination.next_record_id
// END
// ```
// The following values have been **deprecated**:
//     `estimated_indexed_spans_usage`, `estimated_indexed_spans_percentage`, `estimated_ingested_spans_usage`, `estimated_ingested_spans_percentage`, `llm_observability_usage`, `llm_observability_percentage`.
//
pub fn GetHourlyUsageAttribution(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8, usage_type: []const u8, next_record_id: []const u8, tag_breakdown_keys: []const u8, include_descendants: []const u8) !HourlyUsageAttributionResponse {
    _ = start_hr;
    _ = end_hr;
    _ = usage_type;
    _ = next_record_id;
    _ = tag_breakdown_keys;
    _ = include_descendants;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/hourly-attribution", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(HourlyUsageAttributionResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Fetch uptime for multiple tests
//
// Description:
// Fetch uptime for multiple Synthetic tests by ID.
//
pub fn FetchUptimes(allocator: std.mem.Allocator, requestBody: SyntheticsFetchUptimesPayload) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/uptimes", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Change the triage state of a security signal
//
// Description:
// This endpoint is deprecated - Change the triage state of a security signal.
//
pub fn EditSecurityMonitoringSignalState(allocator: std.mem.Allocator, @"#/components/parameters/SignalID": []const u8, requestBody: SignalStateUpdateRequest) !void {
    _ = @"#/components/parameters/SignalID";
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/security_analytics/signals/{signal_id}/state", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PATCH, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all global variables
//
// Description:
// Get the list of all Synthetic global variables.
//
pub fn ListGlobalVariables(allocator: std.mem.Allocator) !SyntheticsListGlobalVariablesResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/synthetics/variables");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsListGlobalVariablesResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a global variable
//
// Description:
// Create a Synthetic global variable.
//
pub fn CreateGlobalVariable(allocator: std.mem.Allocator, requestBody: SyntheticsGlobalVariableRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/variables", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get a test configuration
//
// Description:
// Get the detailed configuration associated with a Synthetic test.
//
pub fn GetTest(allocator: std.mem.Allocator, public_id: []const u8) !SyntheticsTestDetailsWithoutSteps {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/{s}", .{public_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsTestDetailsWithoutSteps, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Patch a Synthetic test
//
// Description:
// Patch the configuration of a Synthetic test with partial data.
//
pub fn PatchTest(allocator: std.mem.Allocator, public_id: []const u8, requestBody: SyntheticsPatchTestBody) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/{s}", .{public_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PATCH, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all pipelines
//
// Description:
// Get all pipelines from your organization.
// This endpoint takes no JSON arguments.
//
pub fn ListLogsPipelines(allocator: std.mem.Allocator) !LogsPipelineList {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/logs/config/pipelines");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(LogsPipelineList, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a pipeline
//
// Description:
// Create a pipeline in your organization.
//
pub fn CreateLogsPipeline(allocator: std.mem.Allocator, requestBody: LogsPipeline) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs/config/pipelines", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get a global variable
//
// Description:
// Get the detailed configuration of a global variable.
//
pub fn GetGlobalVariable(allocator: std.mem.Allocator, variable_id: []const u8) !SyntheticsGlobalVariable {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/variables/{s}", .{variable_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsGlobalVariable, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Edit a global variable
//
// Description:
// Edit a Synthetic global variable.
//
pub fn EditGlobalVariable(allocator: std.mem.Allocator, variable_id: []const u8, requestBody: SyntheticsGlobalVariableRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/variables/{s}", .{variable_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a global variable
//
// Description:
// Delete a Synthetic global variable.
//
pub fn DeleteGlobalVariable(allocator: std.mem.Allocator, variable_id: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/variables/{s}", .{variable_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get hourly usage for indexed spans
//
// Description:
// Get hourly usage for indexed spans.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageIndexedSpans(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageIndexedSpansResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/indexed-spans", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageIndexedSpansResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get a webhook integration
//
// Description:
// Gets the content of the webhook with the name `<WEBHOOK_NAME>`.
//
pub fn GetWebhooksIntegration(allocator: std.mem.Allocator, webhook_name: []const u8) !WebhooksIntegration {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/webhooks/configuration/webhooks/{s}", .{webhook_name});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(WebhooksIntegration, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update a webhook
//
// Description:
// Updates the endpoint with the name `<WEBHOOK_NAME>`.
//
pub fn UpdateWebhooksIntegration(allocator: std.mem.Allocator, webhook_name: []const u8, requestBody: WebhooksIntegrationUpdateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/webhooks/configuration/webhooks/{s}", .{webhook_name, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a webhook
//
// Description:
// Deletes the endpoint with the name `<WEBHOOK NAME>`.
//
pub fn DeleteWebhooksIntegration(allocator: std.mem.Allocator, webhook_name: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/webhooks/configuration/webhooks/{s}", .{webhook_name});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Validate a monitor
//
// Description:
// Validate the monitor provided in the request.
// 
// **Note**: Log monitors require an unscoped App Key.
//
pub fn ValidateMonitor(allocator: std.mem.Allocator, requestBody: Monitor) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor/validate", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Create a mobile test
//
// Description:
// Create a Synthetic mobile test.
//
pub fn CreateSyntheticsMobileTest(allocator: std.mem.Allocator, requestBody: SyntheticsMobileTest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/mobile", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Trigger Synthetic tests
//
// Description:
// Trigger a set of Synthetic tests.
//
pub fn TriggerTests(allocator: std.mem.Allocator, requestBody: SyntheticsTriggerBody) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/trigger", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all AWS tag filters
//
// Description:
// Get all AWS tag filters.
//
pub fn ListAWSTagFilters(allocator: std.mem.Allocator, account_id: []const u8) !AWSTagFilterListResponse {
    _ = account_id;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/filtering", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(AWSTagFilterListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Set an AWS tag filter
//
// Description:
// Set an AWS tag filter.
//
pub fn CreateAWSTagFilter(allocator: std.mem.Allocator, requestBody: AWSTagFilterCreateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/filtering", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a tag filtering entry
//
// Description:
// Delete a tag filtering entry.
//
pub fn DeleteAWSTagFilter(allocator: std.mem.Allocator, requestBody: AWSTagFilterDeleteRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/filtering", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Create a browser test
//
// Description:
// Create a Synthetic browser test.
//
pub fn CreateSyntheticsBrowserTest(allocator: std.mem.Allocator, requestBody: SyntheticsBrowserTest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/browser", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get specified daily custom reports
//
// Description:
// Get specified daily custom reports.
// **Note:** This endpoint will be fully deprecated on December 1, 2022.
// Refer to [Migrating from v1 to v2 of the Usage Attribution API](https://docs.datadoghq.com/account_management/guide/usage-attribution-migration/) for the associated migration guide.
//
pub fn GetSpecifiedDailyCustomReports(allocator: std.mem.Allocator, report_id: []const u8) !UsageSpecifiedCustomReportsResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/daily_custom_reports/{s}", .{report_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageSpecifiedCustomReportsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get a Slack integration channel
//
// Description:
// Get a channel configured for your Datadog-Slack integration.
//
pub fn GetSlackIntegrationChannel(allocator: std.mem.Allocator, @"#/components/parameters/SlackAccountNamePathParameter": []const u8, @"#/components/parameters/SlackChannelNamePathParameter": []const u8) !SlackIntegrationChannel {
    _ = @"#/components/parameters/SlackAccountNamePathParameter";
    _ = @"#/components/parameters/SlackChannelNamePathParameter";
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/slack/configuration/accounts/{account_name}/channels/{channel_name}", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SlackIntegrationChannel, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Remove a Slack integration channel
//
// Description:
// Remove a channel from your Datadog-Slack integration.
//
pub fn RemoveSlackIntegrationChannel(allocator: std.mem.Allocator, @"#/components/parameters/SlackAccountNamePathParameter": []const u8, @"#/components/parameters/SlackChannelNamePathParameter": []const u8) !void {
    _ = @"#/components/parameters/SlackAccountNamePathParameter";
    _ = @"#/components/parameters/SlackChannelNamePathParameter";
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/slack/configuration/accounts/{account_name}/channels/{channel_name}", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Update a Slack integration channel
//
// Description:
// Update a channel used in your Datadog-Slack integration.
//
pub fn UpdateSlackIntegrationChannel(allocator: std.mem.Allocator, @"#/components/parameters/SlackAccountNamePathParameter": []const u8, @"#/components/parameters/SlackChannelNamePathParameter": []const u8, requestBody: SlackIntegrationChannel) !void {
    _ = @"#/components/parameters/SlackAccountNamePathParameter";
    _ = @"#/components/parameters/SlackChannelNamePathParameter";
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/slack/configuration/accounts/{account_name}/channels/{channel_name}", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PATCH, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get an SLO's history
//
// Description:
// Get a specific SLO’s history, regardless of its SLO type.
// 
// The detailed history data is structured according to the source data type.
// For example, metric data is included for event SLOs that use
// the metric source, and monitor SLO types include the monitor transition history.
// 
// **Note:** There are different response formats for event based and time based SLOs.
// Examples of both are shown.
//
pub fn GetSLOHistory(allocator: std.mem.Allocator, slo_id: []const u8, from_ts: []const u8, to_ts: []const u8, target: []const u8, apply_correction: []const u8) !SLOHistoryResponse {
    _ = from_ts;
    _ = to_ts;
    _ = target;
    _ = apply_correction;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/{s}/history", .{slo_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SLOHistoryResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get an API test's latest results summaries
//
// Description:
// Get the last 150 test results summaries for a given Synthetic API test.
//
pub fn GetAPITestLatestResults(allocator: std.mem.Allocator, public_id: []const u8, from_ts: []const u8, to_ts: []const u8, probe_dc: []const u8) !SyntheticsGetAPITestLatestResultsResponse {
    _ = from_ts;
    _ = to_ts;
    _ = probe_dc;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/{s}/results", .{public_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsGetAPITestLatestResultsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for cloud workload security
//
// Description:
// Get hourly usage for cloud workload security.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageCWS(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageCWSResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/cws", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageCWSResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for ingested spans
//
// Description:
// Get hourly usage for ingested spans.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetIngestedSpans(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageIngestedSpansResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/ingested-spans", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageIngestedSpansResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get metric metadata
//
// Description:
// Get metadata about a specific metric.
//
pub fn GetMetricMetadata(allocator: std.mem.Allocator, metric_name: []const u8) !MetricMetadata {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/metrics/{s}", .{metric_name});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(MetricMetadata, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Edit metric metadata
//
// Description:
// Edit metadata of a specific metric. Find out more about [supported types](https://docs.datadoghq.com/developers/metrics).
//
pub fn UpdateMetricMetadata(allocator: std.mem.Allocator, metric_name: []const u8, requestBody: MetricMetadata) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/metrics/{s}", .{metric_name, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Generate a new external ID
//
// Description:
// **This endpoint is deprecated - use the V2 endpoints instead.** Generate a new AWS external ID for a given AWS account ID and role name pair.
//
pub fn CreateNewAWSExternalID(allocator: std.mem.Allocator, requestBody: AWSAccount) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/generate_new_external_id", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all dashboards
//
// Description:
// Get all dashboards.
// 
// **Note**: This query will only return custom created or cloned dashboards.
// This query will not return preset dashboards.
//
pub fn ListDashboards(allocator: std.mem.Allocator, @"filter[shared]": []const u8, @"filter[deleted]": []const u8, count: []const u8, start: []const u8) !DashboardSummary {
    _ = @"filter[shared]";
    _ = @"filter[deleted]";
    _ = count;
    _ = start;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(DashboardSummary, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a new dashboard
//
// Description:
// Create a dashboard using the specified options. When defining queries in your widgets, take note of which queries should have the `as_count()` or `as_rate()` modifiers appended.
// Refer to the following [documentation](https://docs.datadoghq.com/developers/metrics/type_modifiers/?tab=count#in-application-modifiers) for more information on these modifiers.
//
pub fn CreateDashboard(allocator: std.mem.Allocator, requestBody: Dashboard) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete dashboards
//
// Description:
// Delete dashboards using the specified IDs. If there are any failures, no dashboards will be deleted (partial success is not allowed).
//
pub fn DeleteDashboards(allocator: std.mem.Allocator, requestBody: DashboardBulkDeleteRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Restore deleted dashboards
//
// Description:
// Restore dashboards using the specified IDs. If there are any failures, no dashboards will be restored (partial success is not allowed).
//
pub fn RestoreDashboards(allocator: std.mem.Allocator, requestBody: DashboardRestoreRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PATCH, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Send logs
//
// Description:
// Send your logs to your Datadog platform over HTTP. Limits per HTTP request are:
// 
// - Maximum content size per payload (uncompressed): 5MB
// - Maximum size for a single log: 1MB
// - Maximum array size if sending multiple logs in an array: 1000 entries
// 
// Any log exceeding 1MB is accepted and truncated by Datadog:
// - For a single log request, the API truncates the log at 1MB and returns a 2xx.
// - For a multi-logs request, the API processes all logs, truncates only logs larger than 1MB, and returns a 2xx.
// 
// Datadog recommends sending your logs compressed.
// Add the `Content-Encoding: gzip` header to the request when sending compressed logs.
// 
// The status codes answered by the HTTP API are:
// - 200: OK
// - 400: Bad request (likely an issue in the payload formatting)
// - 403: Permission issue (likely using an invalid API Key)
// - 413: Payload too large (batch is above 5MB uncompressed)
// - 5xx: Internal error, request should be retried after some time
//
pub fn SubmitLog(allocator: std.mem.Allocator, Content_Encoding: []const u8, ddtags: []const u8, requestBody: HTTPLogItem) !void {
    _ = Content_Encoding;
    _ = ddtags;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/v1/input", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Create a custom variable
//
// Description:
// Creates an endpoint with the name `<CUSTOM_VARIABLE_NAME>`.
//
pub fn CreateWebhooksIntegrationCustomVariable(allocator: std.mem.Allocator, requestBody: WebhooksIntegrationCustomVariable) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/webhooks/configuration/custom-variables", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get a browser test
//
// Description:
// Get the detailed configuration (including steps) associated with
// a Synthetic browser test.
//
pub fn GetBrowserTest(allocator: std.mem.Allocator, public_id: []const u8) !SyntheticsBrowserTest {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/browser/{s}", .{public_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsBrowserTest, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Edit a browser test
//
// Description:
// Edit the configuration of a Synthetic browser test.
//
pub fn UpdateBrowserTest(allocator: std.mem.Allocator, public_id: []const u8, requestBody: SyntheticsBrowserTest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/browser/{s}", .{public_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Create an API test
//
// Description:
// Create a Synthetic API test.
//
pub fn CreateSyntheticsAPITest(allocator: std.mem.Allocator, requestBody: SyntheticsAPITest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/api", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get All Host Tags
//
// Description:
// Returns a mapping of tags to hosts. For each tag, the response returns a list of host names that contain this tag. There is a restriction of 10k total host names from the org that can be attached to tags and returned.
//
pub fn ListHostTags(allocator: std.mem.Allocator, source: []const u8) !TagToHosts {
    _ = source;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/tags/hosts", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(TagToHosts, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get all indexes
//
// Description:
// The Index object describes the configuration of a log index.
// This endpoint returns an array of the `LogIndex` objects of your organization.
//
pub fn ListLogIndexes(allocator: std.mem.Allocator) !LogsIndexListResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/logs/config/indexes");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(LogsIndexListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create an index
//
// Description:
// Creates a new index. Returns the Index object passed in the request body when the request is successful.
//
pub fn CreateLogsIndex(allocator: std.mem.Allocator, requestBody: LogsIndex) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs/config/indexes", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get Corrections For an SLO
//
// Description:
// Get corrections applied to an SLO
//
pub fn GetSLOCorrections(allocator: std.mem.Allocator, slo_id: []const u8) !SLOCorrectionListResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/{s}/corrections", .{slo_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SLOCorrectionListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get Host Tags
//
// Description:
// Return the list of tags that apply to a given host.
//
pub fn GetHostTags(allocator: std.mem.Allocator, host_name: []const u8, source: []const u8) !HostTags {
    _ = source;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/tags/hosts/{s}", .{host_name, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(HostTags, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Add tags to a host
//
// Description:
// This endpoint allows you to add new tags to a host,
// optionally specifying what source these tags come from. If tags already exist, appends new tags to the tag list. If no source is specified, defaults to "user".
//
pub fn CreateHostTags(allocator: std.mem.Allocator, host_name: []const u8, source: []const u8, requestBody: HostTags) !void {
    _ = source;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/tags/hosts/{s}", .{host_name, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Update host tags
//
// Description:
// This endpoint allows you to update/replace all tags in
// an integration source with those supplied in the request.
//
pub fn UpdateHostTags(allocator: std.mem.Allocator, host_name: []const u8, source: []const u8, requestBody: HostTags) !void {
    _ = source;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/tags/hosts/{s}", .{host_name, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Remove host tags
//
// Description:
// This endpoint allows you to remove all tags
// for a single host. If no source is specified, only deletes from the source "User".
//
pub fn DeleteHostTags(allocator: std.mem.Allocator, host_name: []const u8, source: []const u8) !void {
    _ = source;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/tags/hosts/{s}", .{host_name, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get a shared dashboard
//
// Description:
// Fetch an existing shared dashboard's sharing metadata associated with the specified token.
//
pub fn GetPublicDashboard(allocator: std.mem.Allocator, token: []const u8) !SharedDashboard {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/public/{s}", .{token});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SharedDashboard, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update a shared dashboard
//
// Description:
// Update a shared dashboard associated with the specified token.
//
pub fn UpdatePublicDashboard(allocator: std.mem.Allocator, token: []const u8, requestBody: SharedDashboardUpdateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/public/{s}", .{token, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Revoke a shared dashboard URL
//
// Description:
// Revoke the public URL for a dashboard (rendering it private) associated with the specified token.
//
pub fn DeletePublicDashboard(allocator: std.mem.Allocator, token: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/public/{s}", .{token});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get hourly usage for synthetics browser checks
//
// Description:
// Get hourly usage for synthetics browser checks.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageSyntheticsBrowser(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageSyntheticsBrowserResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/synthetics_browser", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageSyntheticsBrowserResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get an API test result
//
// Description:
// Get a specific full result from a given Synthetic API test.
//
pub fn GetAPITestResult(allocator: std.mem.Allocator, public_id: []const u8, result_id: []const u8) !SyntheticsAPITestResultFull {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/{s}/results/{s}", .{public_id, result_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsAPITestResultFull, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for hosts and containers
//
// Description:
// Get hourly usage for hosts and containers.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageHosts(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageHostsResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/hosts", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageHostsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get an index
//
// Description:
// Get one log index from your organization. This endpoint takes no JSON arguments.
//
pub fn GetLogsIndex(allocator: std.mem.Allocator, name: []const u8) !LogsIndex {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs/config/indexes/{s}", .{name});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(LogsIndex, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update an index
//
// Description:
// Update an index as identified by its name.
// Returns the Index object passed in the request body when the request is successful.
// 
// Using the `PUT` method updates your index’s configuration by **replacing**
// your current configuration with the new one sent to your Datadog organization.
//
pub fn UpdateLogsIndex(allocator: std.mem.Allocator, name: []const u8, requestBody: LogsIndexUpdateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs/config/indexes/{s}", .{name, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete an index
//
// Description:
// Delete an existing index from your organization. Index deletions are permanent and cannot be reverted.
// You cannot recreate an index with the same name as deleted ones.
//
pub fn DeleteLogsIndex(allocator: std.mem.Allocator, name: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs/config/indexes/{s}", .{name});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get the list of available monthly custom reports
//
// Description:
// Get monthly custom reports.
// **Note:** This endpoint will be fully deprecated on December 1, 2022.
// Refer to [Migrating from v1 to v2 of the Usage Attribution API](https://docs.datadoghq.com/account_management/guide/usage-attribution-migration/) for the associated migration guide.
//
pub fn GetMonthlyCustomReports(allocator: std.mem.Allocator, @"page[size]": []const u8, @"page[number]": []const u8, sort_dir: []const u8, sort: []const u8) !UsageCustomReportsResponse {
    _ = @"page[size]";
    _ = @"page[number]";
    _ = sort_dir;
    _ = sort;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monthly_custom_reports", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageCustomReportsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Upload IdP metadata
//
// Description:
// There are a couple of options for updating the Identity Provider (IdP)
// metadata from your SAML IdP.
// 
// * **Multipart Form-Data**: Post the IdP metadata file using a form post.
// 
// * **XML Body:** Post the IdP metadata file as the body of the request.
//
pub fn UploadIdPForOrg(allocator: std.mem.Allocator, public_id: []const u8, requestBody: IdpFormData) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/org/{s}/idp_metadata", .{public_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all locations (public and private)
//
// Description:
// Get the list of public and private locations available for Synthetic
// tests. No arguments required.
//
pub fn ListLocations(allocator: std.mem.Allocator) !SyntheticsLocations {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/synthetics/locations");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsLocations, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get indexes order
//
// Description:
// Get the current order of your log indexes. This endpoint takes no JSON arguments.
//
pub fn GetLogsIndexOrder(allocator: std.mem.Allocator) !LogsIndexesOrder {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/logs/config/index-order");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(LogsIndexesOrder, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update indexes order
//
// Description:
// This endpoint updates the index order of your organization.
// It returns the index order object passed in the request body when the request is successful.
//
pub fn UpdateLogsIndexOrder(allocator: std.mem.Allocator, requestBody: LogsIndexesOrder) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/logs/config/index-order", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all channels in a Slack integration
//
// Description:
// Get a list of all channels configured for your Datadog-Slack integration.
//
pub fn GetSlackIntegrationChannels(allocator: std.mem.Allocator, @"#/components/parameters/SlackAccountNamePathParameter": []const u8) !SlackIntegrationChannels {
    _ = @"#/components/parameters/SlackAccountNamePathParameter";
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/slack/configuration/accounts/{account_name}/channels", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SlackIntegrationChannels, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a Slack integration channel
//
// Description:
// Add a channel to your Datadog-Slack integration.
//
pub fn CreateSlackIntegrationChannel(allocator: std.mem.Allocator, @"#/components/parameters/SlackAccountNamePathParameter": []const u8, requestBody: SlackIntegrationChannel) !void {
    _ = @"#/components/parameters/SlackAccountNamePathParameter";
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/slack/configuration/accounts/{account_name}/channels", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Trigger tests from CI/CD pipelines
//
// Description:
// Trigger a set of Synthetic tests for continuous integration.
//
pub fn TriggerCITests(allocator: std.mem.Allocator, requestBody: SyntheticsCITestBody) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/trigger/ci", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get hourly usage for logs by index
//
// Description:
// Get hourly usage for logs by index.
//
pub fn GetUsageLogsByIndex(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8, index_name: []const u8) !UsageLogsByIndexResponse {
    _ = start_hr;
    _ = end_hr;
    _ = index_name;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/logs_by_index", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageLogsByIndexResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Mute a host
//
// Description:
// Mute a host. **Note:** This creates a [Downtime V2](https://docs.datadoghq.com/api/latest/downtimes/#schedule-a-downtime) for the host.
//
pub fn MuteHost(allocator: std.mem.Allocator, host_name: []const u8, requestBody: HostMuteSettings) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/host/{s}/mute", .{host_name, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get details of batch
//
// Description:
// Get a batch's updated details.
//
pub fn GetSyntheticsCIBatch(allocator: std.mem.Allocator, batch_id: []const u8) !SyntheticsBatchDetails {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/ci/batch/{s}", .{batch_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsBatchDetails, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for database monitoring
//
// Description:
// Get hourly usage for database monitoring
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageDBM(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageDBMResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/dbm", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageDBMResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// List all AWS integrations
//
// Description:
// **This endpoint is deprecated - use the V2 endpoints instead.** List all Datadog-AWS integrations available in your Datadog organization.
//
pub fn ListAWSAccounts(allocator: std.mem.Allocator, account_id: []const u8, role_name: []const u8, access_key_id: []const u8) !AWSAccountListResponse {
    _ = account_id;
    _ = role_name;
    _ = access_key_id;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(AWSAccountListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create an AWS integration
//
// Description:
// **This endpoint is deprecated - use the V2 endpoints instead.** Create a Datadog-Amazon Web Services integration.
// Using the `POST` method updates your integration configuration
// by adding your new configuration to the existing one in your Datadog organization.
// A unique AWS Account ID for role based authentication.
//
pub fn CreateAWSAccount(allocator: std.mem.Allocator, requestBody: AWSAccount) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Update an AWS integration
//
// Description:
// **This endpoint is deprecated - use the V2 endpoints instead.** Update a Datadog-Amazon Web Services integration.
//
pub fn UpdateAWSAccount(allocator: std.mem.Allocator, account_id: []const u8, role_name: []const u8, access_key_id: []const u8, requestBody: AWSAccount) !void {
    _ = account_id;
    _ = role_name;
    _ = access_key_id;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete an AWS integration
//
// Description:
// **This endpoint is deprecated - use the V2 endpoints instead.** Delete a Datadog-AWS integration matching the specified `account_id` and `role_name parameters`.
//
pub fn DeleteAWSAccount(allocator: std.mem.Allocator, requestBody: AWSAccountDeleteRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get active downtimes for a monitor
//
// Description:
// Get all active v1 downtimes for the specified monitor. **Note:** This endpoint has been deprecated. Please use v2 endpoints.
//
pub fn ListMonitorDowntimes(allocator: std.mem.Allocator, monitor_id: []const u8) ![]const u8 {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor/{s}/downtimes", .{monitor_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice([]const u8, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Spin-off Child Organization
//
// Description:
// Only available for MSP customers. Removes a child organization from the hierarchy of the master organization and places the child organization on a 30-day trial.
//
pub fn DowngradeOrg(allocator: std.mem.Allocator, public_id: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/org/{s}/downgrade", .{public_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// List namespace rules
//
// Description:
// **This endpoint is deprecated - use the V2 endpoints instead.** List all namespace rules for a given Datadog-AWS integration. This endpoint takes no arguments.
//
pub fn ListAvailableAWSNamespaces(allocator: std.mem.Allocator) ![]const u8 {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/integration/aws/available_namespace_rules");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice([]const u8, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Modify the triage assignee of a security signal
//
// Description:
// This endpoint is deprecated - Modify the triage assignee of a security signal.
//
pub fn EditSecurityMonitoringSignalAssignee(allocator: std.mem.Allocator, @"#/components/parameters/SignalID": []const u8, requestBody: SignalAssigneeUpdateRequest) !void {
    _ = @"#/components/parameters/SignalID";
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/security_analytics/signals/{signal_id}/assignee", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PATCH, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get an SLO correction for an SLO
//
// Description:
// Get an SLO correction.
//
pub fn GetSLOCorrection(allocator: std.mem.Allocator, slo_correction_id: []const u8) !SLOCorrectionResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/correction/{s}", .{slo_correction_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SLOCorrectionResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Delete an SLO correction
//
// Description:
// Permanently delete the specified SLO correction object.
//
pub fn DeleteSLOCorrection(allocator: std.mem.Allocator, slo_correction_id: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/correction/{s}", .{slo_correction_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Update an SLO correction
//
// Description:
// Update the specified SLO correction object.
//
pub fn UpdateSLOCorrection(allocator: std.mem.Allocator, slo_correction_id: []const u8, requestBody: SLOCorrectionUpdateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/correction/{s}", .{slo_correction_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PATCH, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete tests
//
// Description:
// Delete multiple Synthetic tests by ID.
//
pub fn DeleteTests(allocator: std.mem.Allocator, requestBody: SyntheticsDeleteTestsPayload) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/delete", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all invitations for a shared dashboard
//
// Description:
// Describe the invitations that exist for the given shared dashboard (paginated).
//
pub fn GetPublicDashboardInvitations(allocator: std.mem.Allocator, token: []const u8, page_size: []const u8, page_number: []const u8) !SharedDashboardInvites {
    _ = page_size;
    _ = page_number;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/public/{s}/invitation", .{token, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SharedDashboardInvites, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Send shared dashboard invitation email
//
// Description:
// Send emails to specified email addresses containing links to access a given authenticated shared dashboard. Email addresses must already belong to the authenticated shared dashboard's share_list.
//
pub fn SendPublicDashboardInvitation(allocator: std.mem.Allocator, token: []const u8, requestBody: SharedDashboardInvites) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/public/{s}/invitation", .{token, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Revoke shared dashboard invitations
//
// Description:
// Revoke previously sent invitation emails and active sessions used to access a given shared dashboard for specific email addresses.
//
pub fn DeletePublicDashboardInvitation(allocator: std.mem.Allocator, token: []const u8, requestBody: SharedDashboardInvites) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/public/{s}/invitation", .{token, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get hourly usage for IoT
//
// Description:
// Get hourly usage for IoT.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageInternetOfThings(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageIoTResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/iot", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageIoTResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get the list of available daily custom reports
//
// Description:
// Get daily custom reports.
// **Note:** This endpoint will be fully deprecated on December 1, 2022.
// Refer to [Migrating from v1 to v2 of the Usage Attribution API](https://docs.datadoghq.com/account_management/guide/usage-attribution-migration/) for the associated migration guide.
//
pub fn GetDailyCustomReports(allocator: std.mem.Allocator, @"page[size]": []const u8, @"page[number]": []const u8, sort_dir: []const u8, sort: []const u8) !UsageCustomReportsResponse {
    _ = @"page[size]";
    _ = @"page[number]";
    _ = sort_dir;
    _ = sort;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/daily_custom_reports", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageCustomReportsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for synthetics API checks
//
// Description:
// Get hourly usage for [synthetics API checks](https://docs.datadoghq.com/synthetics/).
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageSyntheticsAPI(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageSyntheticsAPIResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/synthetics_api", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageSyntheticsAPIResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get monthly usage attribution
//
// Description:
// Get monthly usage attribution. Multi-region data is available starting March 1, 2023.
// 
// This API endpoint is paginated. To make sure you receive all records, check if the value of `next_record_id` is
// set in the response. If it is, make another request and pass `next_record_id` as a parameter.
// Pseudo code example:
// 
// ```
// response := GetMonthlyUsageAttribution(start_month)
// cursor := response.metadata.pagination.next_record_id
// WHILE cursor != null BEGIN
//   sleep(5 seconds)  # Avoid running into rate limit
//   response := GetMonthlyUsageAttribution(start_month, next_record_id=cursor)
//   cursor := response.metadata.pagination.next_record_id
// END
// ```
//
pub fn GetMonthlyUsageAttribution(allocator: std.mem.Allocator, start_month: []const u8, end_month: []const u8, fields: []const u8, sort_direction: []const u8, sort_name: []const u8, tag_breakdown_keys: []const u8, next_record_id: []const u8, include_descendants: []const u8) !MonthlyUsageAttributionResponse {
    _ = start_month;
    _ = end_month;
    _ = fields;
    _ = sort_direction;
    _ = sort_name;
    _ = tag_breakdown_keys;
    _ = next_record_id;
    _ = include_descendants;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/monthly-attribution", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(MonthlyUsageAttributionResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for custom metrics
//
// Description:
// Get hourly usage for [custom metrics](https://docs.datadoghq.com/developers/metrics/custom_metrics/).
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageTimeseries(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageTimeseriesResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/timeseries", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageTimeseriesResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for CI visibility
//
// Description:
// Get hourly usage for CI visibility (tests, pipeline, and spans).
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageCIApp(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageCIVisibilityResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/ci-app", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageCIVisibilityResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get a browser test's latest results summaries
//
// Description:
// Get the last 150 test results summaries for a given Synthetic browser test.
//
pub fn GetBrowserTestLatestResults(allocator: std.mem.Allocator, public_id: []const u8, from_ts: []const u8, to_ts: []const u8, probe_dc: []const u8) !SyntheticsGetBrowserTestLatestResultsResponse {
    _ = from_ts;
    _ = to_ts;
    _ = probe_dc;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/browser/{s}/results", .{public_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsGetBrowserTestLatestResultsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for Fargate
//
// Description:
// Get hourly usage for [Fargate](https://docs.datadoghq.com/integrations/ecs_fargate/).
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageFargate(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageFargateResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/fargate", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageFargateResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get an API test
//
// Description:
// Get the detailed configuration associated with
// a Synthetic API test.
//
pub fn GetAPITest(allocator: std.mem.Allocator, public_id: []const u8) !SyntheticsAPITest {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/api/{s}", .{public_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsAPITest, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Edit an API test
//
// Description:
// Edit the configuration of a Synthetic API test.
//
pub fn UpdateAPITest(allocator: std.mem.Allocator, public_id: []const u8, requestBody: SyntheticsAPITest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/api/{s}", .{public_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all monitors
//
// Description:
// Get all monitors from your organization.
//
pub fn ListMonitors(allocator: std.mem.Allocator, group_states: []const u8, name: []const u8, tags: []const u8, monitor_tags: []const u8, with_downtimes: []const u8, id_offset: []const u8, page: []const u8, page_size: []const u8) ![]const u8 {
    _ = group_states;
    _ = name;
    _ = tags;
    _ = monitor_tags;
    _ = with_downtimes;
    _ = id_offset;
    _ = page;
    _ = page_size;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice([]const u8, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a monitor
//
// Description:
// Create a monitor using the specified options.
// 
// #### Monitor Types
// 
// The type of monitor chosen from:
// 
// - anomaly: `query alert`
// - APM: `query alert` or `trace-analytics alert`
// - composite: `composite`
// - custom: `service check`
// - forecast: `query alert`
// - host: `service check`
// - integration: `query alert` or `service check`
// - live process: `process alert`
// - logs: `log alert`
// - metric: `query alert`
// - network: `service check`
// - outlier: `query alert`
// - process: `service check`
// - rum: `rum alert`
// - SLO: `slo alert`
// - watchdog: `event-v2 alert`
// - event-v2: `event-v2 alert`
// - audit: `audit alert`
// - error-tracking: `error-tracking alert`
// - database-monitoring: `database-monitoring alert`
// - network-performance: `network-performance alert`
// - cloud cost: `cost alert`
// - network-path: `network-path alert`
// 
// **Notes**:
// - Synthetic monitors are created through the Synthetics API. See the [Synthetics API](https://docs.datadoghq.com/api/latest/synthetics/) documentation for more information.
// - Log monitors require an unscoped App Key.
// 
// #### Query Types
// 
// ##### Metric Alert Query
// 
// Example: `time_aggr(time_window):space_aggr:metric{tags} [by {key}] operator #`
// 
// - `time_aggr`: avg, sum, max, min, change, or pct_change
// - `time_window`: `last_#m` (with `#` between 1 and 10080 depending on the monitor type) or `last_#h`(with `#` between 1 and 168 depending on the monitor type) or `last_1d`, or `last_1w`
// - `space_aggr`: avg, sum, min, or max
// - `tags`: one or more tags (comma-separated), or *
// - `key`: a 'key' in key:value tag syntax; defines a separate alert for each tag in the group (multi-alert)
// - `operator`: <, <=, >, >=, ==, or !=
// - `#`: an integer or decimal number used to set the threshold
// 
// If you are using the `_change_` or `_pct_change_` time aggregator, instead use `change_aggr(time_aggr(time_window),
// timeshift):space_aggr:metric{tags} [by {key}] operator #` with:
// 
// - `change_aggr` change, pct_change
// - `time_aggr` avg, sum, max, min [Learn more](https://docs.datadoghq.com/monitors/create/types/#define-the-conditions)
// - `time_window` last\_#m (between 1 and 2880 depending on the monitor type), last\_#h (between 1 and 48 depending on the monitor type), or last_#d (1 or 2)
// - `timeshift` #m_ago (5, 10, 15, or 30), #h_ago (1, 2, or 4), or 1d_ago
// 
// Use this to create an outlier monitor using the following query:
// `avg(last_30m):outliers(avg:system.cpu.user{role:es-events-data} by {host}, 'dbscan', 7) > 0`
// 
// ##### Service Check Query
// 
// Example: `"check".over(tags).last(count).by(group).count_by_status()`
// 
// - `check` name of the check, for example `datadog.agent.up`
// - `tags` one or more quoted tags (comma-separated), or "*". for example: `.over("env:prod", "role:db")`; `over` cannot be blank.
// - `count` must be at greater than or equal to your max threshold (defined in the `options`). It is limited to 100.
// For example, if you've specified to notify on 1 critical, 3 ok, and 2 warn statuses, `count` should be at least 3.
// - `group` must be specified for check monitors. Per-check grouping is already explicitly known for some service checks.
// For example, Postgres integration monitors are tagged by `db`, `host`, and `port`, and Network monitors by `host`, `instance`, and `url`. See [Service Checks](https://docs.datadoghq.com/api/latest/service-checks/) documentation for more information.
// 
// ##### Event Alert Query
// 
// **Note:** The Event Alert Query has been replaced by the Event V2 Alert Query. For more information, see the [Event Migration guide](https://docs.datadoghq.com/service_management/events/guides/migrating_to_new_events_features/).
// 
// ##### Event V2 Alert Query
// 
// Example: `events(query).rollup(rollup_method[, measure]).last(time_window) operator #`
// 
// - `query` The search query - following the [Log search syntax](https://docs.datadoghq.com/logs/search_syntax/).
// - `rollup_method` The stats roll-up method - supports `count`, `avg` and `cardinality`.
// - `measure` For `avg` and cardinality `rollup_method` - specify the measure or the facet name you want to use.
// - `time_window` #m (between 1 and 2880), #h (between 1 and 48).
// - `operator` `<`, `<=`, `>`, `>=`, `==`, or `!=`.
// - `#` an integer or decimal number used to set the threshold.
// 
// ##### Process Alert Query
// 
// Example: `processes(search).over(tags).rollup('count').last(timeframe) operator #`
// 
// - `search` free text search string for querying processes.
// Matching processes match results on the [Live Processes](https://docs.datadoghq.com/infrastructure/process/?tab=linuxwindows) page.
// - `tags` one or more tags (comma-separated)
// - `timeframe` the timeframe to roll up the counts. Examples: 10m, 4h. Supported timeframes: s, m, h and d
// - `operator` <, <=, >, >=, ==, or !=
// - `#` an integer or decimal number used to set the threshold
// 
// ##### Logs Alert Query
// 
// Example: `logs(query).index(index_name).rollup(rollup_method[, measure]).last(time_window) operator #`
// 
// - `query` The search query - following the [Log search syntax](https://docs.datadoghq.com/logs/search_syntax/).
// - `index_name` For multi-index organizations, the log index in which the request is performed.
// - `rollup_method` The stats roll-up method - supports `count`, `avg` and `cardinality`.
// - `measure` For `avg` and cardinality `rollup_method` - specify the measure or the facet name you want to use.
// - `time_window` #m (between 1 and 2880), #h (between 1 and 48).
// - `operator` `<`, `<=`, `>`, `>=`, `==`, or `!=`.
// - `#` an integer or decimal number used to set the threshold.
// 
// ##### Composite Query
// 
// Example: `12345 && 67890`, where `12345` and `67890` are the IDs of non-composite monitors
// 
// * `name` [*required*, *default* = **dynamic, based on query**]: The name of the alert.
// * `message` [*required*, *default* = **dynamic, based on query**]: A message to include with notifications for this monitor.
// Email notifications can be sent to specific users by using the same '@username' notation as events.
// * `tags` [*optional*, *default* = **empty list**]: A list of tags to associate with your monitor.
// When getting all monitor details via the API, use the `monitor_tags` argument to filter results by these tags.
// It is only available via the API and isn't visible or editable in the Datadog UI.
// 
// ##### SLO Alert Query
// 
// Example: `error_budget("slo_id").over("time_window") operator #`
// 
// - `slo_id`: The alphanumeric SLO ID of the SLO you are configuring the alert for.
// - `time_window`: The time window of the SLO target you wish to alert on. Valid options: `7d`, `30d`, `90d`.
// - `operator`: `>=` or `>`
// 
// ##### Audit Alert Query
// 
// Example: `audits(query).rollup(rollup_method[, measure]).last(time_window) operator #`
// 
// - `query` The search query - following the [Log search syntax](https://docs.datadoghq.com/logs/search_syntax/).
// - `rollup_method` The stats roll-up method - supports `count`, `avg` and `cardinality`.
// - `measure` For `avg` and cardinality `rollup_method` - specify the measure or the facet name you want to use.
// - `time_window` #m (between 1 and 2880), #h (between 1 and 48).
// - `operator` `<`, `<=`, `>`, `>=`, `==`, or `!=`.
// - `#` an integer or decimal number used to set the threshold.
// 
// ##### CI Pipelines Alert Query
// 
// Example: `ci-pipelines(query).rollup(rollup_method[, measure]).last(time_window) operator #`
// 
// - `query` The search query - following the [Log search syntax](https://docs.datadoghq.com/logs/search_syntax/).
// - `rollup_method` The stats roll-up method - supports `count`, `avg`, and `cardinality`.
// - `measure` For `avg` and cardinality `rollup_method` - specify the measure or the facet name you want to use.
// - `time_window` #m (between 1 and 2880), #h (between 1 and 48).
// - `operator` `<`, `<=`, `>`, `>=`, `==`, or `!=`.
// - `#` an integer or decimal number used to set the threshold.
// 
// ##### CI Tests Alert Query
// 
// Example: `ci-tests(query).rollup(rollup_method[, measure]).last(time_window) operator #`
// 
// - `query` The search query - following the [Log search syntax](https://docs.datadoghq.com/logs/search_syntax/).
// - `rollup_method` The stats roll-up method - supports `count`, `avg`, and `cardinality`.
// - `measure` For `avg` and cardinality `rollup_method` - specify the measure or the facet name you want to use.
// - `time_window` #m (between 1 and 2880), #h (between 1 and 48).
// - `operator` `<`, `<=`, `>`, `>=`, `==`, or `!=`.
// - `#` an integer or decimal number used to set the threshold.
// 
// ##### Error Tracking Alert Query
// 
// "New issue" example: `error-tracking(query).source(issue_source).new().rollup(rollup_method[, measure]).by(group_by).last(time_window) operator #`
// "High impact issue" example: `error-tracking(query).source(issue_source).impact().rollup(rollup_method[, measure]).by(group_by).last(time_window) operator #`
// 
// - `query` The search query - following the [Log search syntax](https://docs.datadoghq.com/logs/search_syntax/).
// - `issue_source` The issue source - supports `all`, `browser`, `mobile` and `backend` and defaults to `all` if omitted.
// - `rollup_method` The stats roll-up method - supports `count`, `avg`, and `cardinality` and defaults to `count` if omitted.
// - `measure` For `avg` and cardinality `rollup_method` - specify the measure or the facet name you want to use.
// - `group by` Comma-separated list of attributes to group by - should contain at least `issue.id`.
// - `time_window` #m (between 1 and 2880), #h (between 1 and 48).
// - `operator` `<`, `<=`, `>`, `>=`, `==`, or `!=`.
// - `#` an integer or decimal number used to set the threshold.
// 
// **Database Monitoring Alert Query**
// 
// Example: `database-monitoring(query).rollup(rollup_method[, measure]).last(time_window) operator #`
// 
// - `query` The search query - following the [Log search syntax](https://docs.datadoghq.com/logs/search_syntax/).
// - `rollup_method` The stats roll-up method - supports `count`, `avg`, and `cardinality`.
// - `measure` For `avg` and cardinality `rollup_method` - specify the measure or the facet name you want to use.
// - `time_window` #m (between 1 and 2880), #h (between 1 and 48).
// - `operator` `<`, `<=`, `>`, `>=`, `==`, or `!=`.
// - `#` an integer or decimal number used to set the threshold.
// 
// **Network Performance Alert Query**
// 
// Example: `network-performance(query).rollup(rollup_method[, measure]).last(time_window) operator #`
// 
// - `query` The search query - following the [Log search syntax](https://docs.datadoghq.com/logs/search_syntax/).
// - `rollup_method` The stats roll-up method - supports `count`, `avg`, and `cardinality`.
// - `measure` For `avg` and cardinality `rollup_method` - specify the measure or the facet name you want to use.
// - `time_window` #m (between 1 and 2880), #h (between 1 and 48).
// - `operator` `<`, `<=`, `>`, `>=`, `==`, or `!=`.
// - `#` an integer or decimal number used to set the threshold.
// 
// **Cost Alert Query**
// 
// Example: `formula(query).timeframe_type(time_window).function(parameter) operator #`
// 
// - `query` The search query - following the [Log search syntax](https://docs.datadoghq.com/logs/search_syntax/).
// - `timeframe_type` The timeframe type to evaluate the cost
//         - for `forecast` supports `current`
//         - for `change`, `anomaly`, `threshold` supports `last`
// - `time_window` - supports daily roll-up e.g. `7d`
// - `function` - [optional, defaults to `threshold` monitor if omitted] supports `change`, `anomaly`, `forecast`
// - `parameter` Specify the parameter of the type
//     - for `change`:
//         - supports `relative`, `absolute`
//         - [optional] supports `#`, where `#` is an integer or decimal number used to set the threshold
//     - for `anomaly`:
//         - supports `direction=both`, `direction=above`, `direction=below`
//         - [optional] supports `threshold=#`, where `#` is an integer or decimal number used to set the threshold
// - `operator`
//     - for `threshold` supports `<`, `<=`, `>`, `>=`, `==`, or `!=`
//     - for `change` supports `>`, `<`
//     - for `anomaly` supports `>=`
//     - for `forecast` supports `>`
// - `#` an integer or decimal number used to set the threshold.
// 
// **Network Path Alert Query**
// 
// Example: `network-path(query).index(index_name).rollup(rollup_method[, measure]).last(time_window) operator #`
// 
// - `query` The search query - following the [Log search syntax](https://docs.datadoghq.com/logs/search_syntax/).
// - `index_name` The data type to monitor on - supports `netpath-path` and `netpath-hop`.
// - `rollup_method` The stats roll-up method - supports `count`, `avg`, and `cardinality`.
// - `measure` For `avg` and cardinality `rollup_method` - specify the measure or the facet name you want to use.
// - `time_window` #m (between 1 and 2880), #h (between 1 and 48).
// - `operator` `<`, `<=`, `>`, `>=`, `==`, or `!=`.
// - `#` an integer or decimal number used to set the threshold.
//
pub fn CreateMonitor(allocator: std.mem.Allocator, requestBody: Monitor) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Search Synthetic tests
//
// Description:
// Search for Synthetic tests.
//
pub fn SearchTests(allocator: std.mem.Allocator, text: []const u8, include_full_config: []const u8, facets_only: []const u8, start: []const u8, count: []const u8, sort: []const u8) !SyntheticsListTestsResponse {
    _ = text;
    _ = include_full_config;
    _ = facets_only;
    _ = start;
    _ = count;
    _ = sort;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/search", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsListTestsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get billable usage across your account
//
// Description:
// Get billable usage across your account.
// 
// This endpoint is only accessible for [parent-level organizations](https://docs.datadoghq.com/account_management/multi_organization/).
//
pub fn GetUsageBillableSummary(allocator: std.mem.Allocator, month: []const u8, include_connected_accounts: []const u8) !UsageBillableSummaryResponse {
    _ = month;
    _ = include_connected_accounts;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/billable-summary", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageBillableSummaryResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get the default locations
//
// Description:
// Get the default locations settings.
//
pub fn GetSyntheticsDefaultLocations(allocator: std.mem.Allocator) !SyntheticsDefaultLocations {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/synthetics/settings/default_locations");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsDefaultLocations, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for network hosts
//
// Description:
// Get hourly usage for network hosts.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageNetworkHosts(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageNetworkHostsResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/network_hosts", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageNetworkHostsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get a browser test result
//
// Description:
// Get a specific full result from a given Synthetic browser test.
//
pub fn GetBrowserTestResult(allocator: std.mem.Allocator, public_id: []const u8, result_id: []const u8) !SyntheticsBrowserTestResultFull {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/synthetics/tests/browser/{s}/results/{s}", .{public_id, result_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SyntheticsBrowserTestResultFull, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Cancel downtimes by scope
//
// Description:
// Delete all downtimes that match the scope of `X`. **Note:** This only interacts with Downtimes created using v1 endpoints. This endpoint has been deprecated and will not be replaced. Please use v2 endpoints to find and cancel downtimes.
//
pub fn CancelDowntimesByScope(allocator: std.mem.Allocator, requestBody: CancelDowntimesByScopeRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/downtime/cancel/by_scope", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get a monitor's details
//
// Description:
// Get details about the specified monitor from your organization.
//
pub fn GetMonitor(allocator: std.mem.Allocator, monitor_id: []const u8, group_states: []const u8, with_downtimes: []const u8, with_assets: []const u8) !Monitor {
    _ = group_states;
    _ = with_downtimes;
    _ = with_assets;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor/{s}", .{monitor_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(Monitor, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Edit a monitor
//
// Description:
// Edit the specified monitor.
//
pub fn UpdateMonitor(allocator: std.mem.Allocator, monitor_id: []const u8, requestBody: MonitorUpdateRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor/{s}", .{monitor_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a monitor
//
// Description:
// Delete the specified monitor
//
pub fn DeleteMonitor(allocator: std.mem.Allocator, monitor_id: []const u8, force: []const u8) !void {
    _ = force;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor/{s}", .{monitor_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get hourly usage for audit logs
//
// Description:
// Get hourly usage for audit logs.
// **Note:** This endpoint has been deprecated.
//
pub fn GetUsageAuditLogs(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageAuditLogsResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/audit_logs", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageAuditLogsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get all API keys
//
// Description:
// Get all API keys available for your account.
//
pub fn ListAPIKeys(allocator: std.mem.Allocator) !ApiKeyListResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/api_key");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(ApiKeyListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create an API key
//
// Description:
// Creates an API key with a given name.
//
pub fn CreateAPIKey(allocator: std.mem.Allocator, requestBody: ApiKey) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/api_key", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get user details
//
// Description:
// Get a user's details.
//
pub fn GetUser(allocator: std.mem.Allocator, user_handle: []const u8) !UserResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/user/{s}", .{user_handle});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UserResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update a user
//
// Description:
// Update a user information.
// 
// **Note**: It can only be used with application keys belonging to administrators.
//
pub fn UpdateUser(allocator: std.mem.Allocator, user_handle: []const u8, requestBody: User) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/user/{s}", .{user_handle, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Disable a user
//
// Description:
// Delete a user from an organization.
// 
// **Note**: This endpoint can only be used with application keys belonging to
// administrators.
//
pub fn DisableUser(allocator: std.mem.Allocator, user_handle: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/user/{s}", .{user_handle});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get hourly usage for RUM units
//
// Description:
// Get hourly usage for [RUM](https://docs.datadoghq.com/real_user_monitoring/) Units.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageRumUnits(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageRumUnitsResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/rum", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageRumUnitsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Search for SLOs
//
// Description:
// Get a list of service level objective objects for your organization.
//
pub fn SearchSLO(allocator: std.mem.Allocator, query: []const u8, @"page[size]": []const u8, @"page[number]": []const u8, include_facets: []const u8) !SearchSLOResponse {
    _ = query;
    _ = @"page[size]";
    _ = @"page[number]";
    _ = include_facets;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/search", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SearchSLOResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// List all AWS Logs integrations
//
// Description:
// List all Datadog-AWS Logs integrations configured in your Datadog account.
//
pub fn ListAWSLogsIntegrations(allocator: std.mem.Allocator) ![]const u8 {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/integration/aws/logs");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice([]const u8, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Add AWS Log Lambda ARN
//
// Description:
// Attach the Lambda ARN of the Lambda created for the Datadog-AWS log collection to your AWS account ID to enable log collection.
//
pub fn CreateAWSLambdaARN(allocator: std.mem.Allocator, requestBody: AWSAccountAndLambdaRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/logs", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete an AWS Logs integration
//
// Description:
// Delete a Datadog-AWS logs configuration by removing the specific Lambda ARN associated with a given AWS account.
//
pub fn DeleteAWSLambdaARN(allocator: std.mem.Allocator, requestBody: AWSAccountAndLambdaRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/logs", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// List IP Ranges
//
// Description:
// Get information about Datadog IP ranges.
//
pub fn GetIPRanges(allocator: std.mem.Allocator) !IPRanges {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(IPRanges, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// List all GCP integrations
//
// Description:
// This endpoint is deprecated – use the V2 endpoints instead. List all Datadog-GCP integrations configured in your Datadog account.
//
pub fn ListGCPIntegration(allocator: std.mem.Allocator) !GCPAccountListResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/integration/gcp");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(GCPAccountListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a GCP integration
//
// Description:
// This endpoint is deprecated – use the V2 endpoints instead. Create a Datadog-GCP integration.
//
pub fn CreateGCPIntegration(allocator: std.mem.Allocator, requestBody: GCPAccount) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/gcp", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Update a GCP integration
//
// Description:
// This endpoint is deprecated – use the V2 endpoints instead. Update a Datadog-GCP integrations host_filters and/or auto-mute.
// Requires a `project_id` and `client_email`, however these fields cannot be updated.
// If you need to update these fields, delete and use the create (`POST`) endpoint.
// The unspecified fields will keep their original values.
//
pub fn UpdateGCPIntegration(allocator: std.mem.Allocator, requestBody: GCPAccount) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/gcp", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a GCP integration
//
// Description:
// This endpoint is deprecated – use the V2 endpoints instead. Delete a given Datadog-GCP integration.
//
pub fn DeleteGCPIntegration(allocator: std.mem.Allocator, requestBody: GCPAccount) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/gcp", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Query timeseries points
//
// Description:
// Query timeseries points.
//
pub fn QueryMetrics(allocator: std.mem.Allocator, from: []const u8, to: []const u8, query: []const u8) !MetricsQueryResponse {
    _ = from;
    _ = to;
    _ = query;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/query", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(MetricsQueryResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get all SLOs
//
// Description:
// Get a list of service level objective objects for your organization.
//
pub fn ListSLOs(allocator: std.mem.Allocator, ids: []const u8, query: []const u8, tags_query: []const u8, metrics_query: []const u8, limit: []const u8, offset: []const u8) !SLOListResponse {
    _ = ids;
    _ = query;
    _ = tags_query;
    _ = metrics_query;
    _ = limit;
    _ = offset;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SLOListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create an SLO object
//
// Description:
// Create a service level objective object.
//
pub fn CreateSLO(allocator: std.mem.Allocator, requestBody: ServiceLevelObjectiveRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get an application key
//
// Description:
// Get a given application key.
// This endpoint is disabled for organizations in [One-Time Read mode](https://docs.datadoghq.com/account_management/api-app-keys/#one-time-read-mode).
//
pub fn GetApplicationKey(allocator: std.mem.Allocator, key: []const u8) !ApplicationKeyResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/application_s/{s}", .{key});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(ApplicationKeyResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Edit an application key
//
// Description:
// Edit an application key name.
// This endpoint is disabled for organizations in [One-Time Read mode](https://docs.datadoghq.com/account_management/api-app-keys/#one-time-read-mode).
//
pub fn UpdateApplicationKey(allocator: std.mem.Allocator, key: []const u8, requestBody: ApplicationKey) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/application_s/{s}", .{key, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete an application key
//
// Description:
// Delete a given application key.
// This endpoint is disabled for organizations in [One-Time Read mode](https://docs.datadoghq.com/account_management/api-app-keys/#one-time-read-mode).
//
pub fn DeleteApplicationKey(allocator: std.mem.Allocator, key: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/application_s/{s}", .{key});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get a downtime
//
// Description:
// Get downtime detail by `downtime_id`. **Note:** This endpoint has been deprecated. Please use v2 endpoints.
//
pub fn GetDowntime(allocator: std.mem.Allocator, downtime_id: []const u8) !Downtime {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/downtime/{s}", .{downtime_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(Downtime, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update a downtime
//
// Description:
// Update a single downtime by `downtime_id`. **Note:** This endpoint has been deprecated. Please use v2 endpoints.
//
pub fn UpdateDowntime(allocator: std.mem.Allocator, downtime_id: []const u8, requestBody: Downtime) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/downtime/{s}", .{downtime_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Cancel a downtime
//
// Description:
// Cancel a downtime. **Note:** This endpoint has been deprecated. Please use v2 endpoints.
//
pub fn CancelDowntime(allocator: std.mem.Allocator, downtime_id: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/downtime/{s}", .{downtime_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Get an SLO's details
//
// Description:
// Get a service level objective object.
//
pub fn GetSLO(allocator: std.mem.Allocator, slo_id: []const u8, with_configured_alert_ids: []const u8) !SLOResponse {
    _ = with_configured_alert_ids;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/{s}", .{slo_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(SLOResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update an SLO
//
// Description:
// Update the specified service level objective object.
//
pub fn UpdateSLO(allocator: std.mem.Allocator, slo_id: []const u8, requestBody: ServiceLevelObjective) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/{s}", .{slo_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete an SLO
//
// Description:
// Permanently delete the specified service level objective object.
// 
// If an SLO is used in a dashboard, the `DELETE /v1/slo/` endpoint returns
// a 409 conflict error because the SLO is referenced in a dashboard.
//
pub fn DeleteSLO(allocator: std.mem.Allocator, slo_id: []const u8, force: []const u8) !void {
    _ = force;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/slo/{s}", .{slo_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// Submit distribution points
//
// Description:
// The distribution points end-point allows you to post distribution data that can be graphed on Datadog’s dashboards.
//
pub fn SubmitDistributionPoints(allocator: std.mem.Allocator, Content_Encoding: []const u8, requestBody: DistributionPointsPayload) !void {
    _ = Content_Encoding;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/distribution_points", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get the total number of active hosts
//
// Description:
// This endpoint returns the total number of active and up hosts in your Datadog account.
// Active means the host has reported in the past hour, and up means it has reported in the past two hours.
//
pub fn GetHostTotals(allocator: std.mem.Allocator, from: []const u8) !HostTotals {
    _ = from;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/hosts/totals", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(HostTotals, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Add a security signal to an incident
//
// Description:
// Add a security signal to an incident. This makes it possible to search for signals by incident within the signal explorer and to view the signals on the incident timeline.
//
pub fn AddSecurityMonitoringSignalToIncident(allocator: std.mem.Allocator, @"#/components/parameters/SignalID": []const u8, requestBody: AddSignalToIncidentRequest) !void {
    _ = @"#/components/parameters/SignalID";
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/security_analytics/signals/{signal_id}/add_to_incident", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PATCH, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get hourly usage for Lambda
//
// Description:
// Get hourly usage for Lambda.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageLambda(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageLambdaResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/aws_lambda", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageLambdaResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for sensitive data scanner
//
// Description:
// Get hourly usage for sensitive data scanner.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageSDS(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageSDSResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/sds", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageSDSResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for synthetics checks
//
// Description:
// Get hourly usage for [synthetics checks](https://docs.datadoghq.com/synthetics/).
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageSynthetics(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageSyntheticsResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/synthetics", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageSyntheticsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for RUM sessions
//
// Description:
// Get hourly usage for [RUM](https://docs.datadoghq.com/real_user_monitoring/) Sessions.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageRumSessions(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8, @"type": []const u8) !UsageRumSessionsResponse {
    _ = start_hr;
    _ = end_hr;
    _ = @"type";
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/rum_sessions", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageRumSessionsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get all hosts for your organization
//
// Description:
// This endpoint allows searching for hosts by name, alias, or tag.
// Hosts live within the past 3 hours are included by default.
// Retention is 7 days.
// Results are paginated with a max of 1000 results at a time.
// **Note:** If the host is an Amazon EC2 instance, `id` is replaced with `aws_id` in the response.
// **Note**: To enrich the data returned by this endpoint with security scans, see the new [api/v2/security/scanned-assets-metadata](https://docs.datadoghq.com/api/latest/security-monitoring/#list-scanned-assets-metadata) endpoint.
//
pub fn ListHosts(allocator: std.mem.Allocator, filter: []const u8, sort_field: []const u8, sort_dir: []const u8, start: []const u8, count: []const u8, from: []const u8, include_muted_hosts_data: []const u8, include_hosts_metadata: []const u8) !HostListResponse {
    _ = filter;
    _ = sort_field;
    _ = sort_dir;
    _ = start;
    _ = count;
    _ = from;
    _ = include_muted_hosts_data;
    _ = include_hosts_metadata;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/hosts", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(HostListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Monitors group search
//
// Description:
// Search and filter your monitor groups details.
//
pub fn SearchMonitorGroups(allocator: std.mem.Allocator, query: []const u8, page: []const u8, per_page: []const u8, sort: []const u8) !MonitorGroupSearchResponse {
    _ = query;
    _ = page;
    _ = per_page;
    _ = sort;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/monitor/groups/search", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(MonitorGroupSearchResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get hourly usage for SNMP devices
//
// Description:
// Get hourly usage for SNMP devices.
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageSNMP(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageSNMPResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/snmp", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageSNMPResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get usage across your account
//
// Description:
// Get all usage across your account.
// 
// This endpoint is only accessible for [parent-level organizations](https://docs.datadoghq.com/account_management/multi_organization/).
//
pub fn GetUsageSummary(allocator: std.mem.Allocator, start_month: []const u8, end_month: []const u8, include_org_details: []const u8, include_connected_accounts: []const u8) !UsageSummaryResponse {
    _ = start_month;
    _ = end_month;
    _ = include_org_details;
    _ = include_connected_accounts;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/summary", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageSummaryResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Check permissions for log services
//
// Description:
// Test if permissions are present to add log-forwarding triggers for the
// given services and AWS account. Input is the same as for `EnableAWSLogServices`.
// Done async, so can be repeatedly polled in a non-blocking fashion until
// the async request completes.
// 
// - Returns a status of `created` when it's checking if the permissions exists
//   in the AWS account.
// - Returns a status of `waiting` while checking.
// - Returns a status of `checked and ok` if the Lambda exists.
// - Returns a status of `error` if the Lambda does not exist.
//
pub fn CheckAWSLogsServicesAsync(allocator: std.mem.Allocator, requestBody: AWSLogsServicesRequest) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/integration/aws/logs/services_async", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get all downtimes
//
// Description:
// Get all scheduled downtimes. **Note:** This endpoint has been deprecated. Please use v2 endpoints.
//
pub fn ListDowntimes(allocator: std.mem.Allocator, current_only: []const u8, with_creator: []const u8) ![]const u8 {
    _ = current_only;
    _ = with_creator;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/downtime", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice([]const u8, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Schedule a downtime
//
// Description:
// Schedule a downtime. **Note:** This endpoint has been deprecated. Please use v2 endpoints.
//
pub fn CreateDowntime(allocator: std.mem.Allocator, requestBody: Downtime) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/downtime", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Validate API key
//
// Description:
// Check if the API key (not the APP key) is valid. If invalid, a 403 is returned.
//
pub fn Validate(allocator: std.mem.Allocator) !AuthenticationValidationResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/validate");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(AuthenticationValidationResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Get a dashboard
//
// Description:
// Get a dashboard using the specified ID.
//
pub fn GetDashboard(allocator: std.mem.Allocator, dashboard_id: []const u8) !Dashboard {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/{s}", .{dashboard_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(Dashboard, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Update a dashboard
//
// Description:
// Update a dashboard using the specified ID.
//
pub fn UpdateDashboard(allocator: std.mem.Allocator, dashboard_id: []const u8, requestBody: Dashboard) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/{s}", .{dashboard_id, });
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.PUT, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Delete a dashboard
//
// Description:
// Delete a dashboard using the specified ID.
//
pub fn DeleteDashboard(allocator: std.mem.Allocator, dashboard_id: []const u8) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/dashboard/{s}", .{dashboard_id});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.DELETE, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();
}

/////////////////
// Summary:
// List your managed organizations
//
// Description:
// This endpoint returns data on your top-level organization.
//
pub fn ListOrgs(allocator: std.mem.Allocator) !OrganizationListResponse {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri = try std.Uri.parse("/api/v1/org");
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(OrganizationListResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

/////////////////
// Summary:
// Create a child organization
//
// Description:
// Create a child organization.
// 
// This endpoint requires the
// [multi-organization account](https://docs.datadoghq.com/account_management/multi_organization/)
// feature and must be enabled by
// [contacting support](https://docs.datadoghq.com/help/).
// 
// Once a new child organization is created, you can interact with it
// by using the `org.public_id`, `api_key.key`, and
// `application_key.hash` provided in the response.
//
pub fn CreateChildOrg(allocator: std.mem.Allocator, requestBody: OrganizationCreateBody) !void {
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/org", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.POST, uri, .{ .extra_headers = headers });
    defer req.deinit();

    const payload = try std.fmt.allocPrint(allocator, "{f}", .{std.json.fmt(requestBody, .{})});
    defer allocator.free(payload);

    req.transfer_encoding = .{ .content_length = payload.len };
    try req.sendBodyComplete(payload);

}

/////////////////
// Summary:
// Get hourly usage for analyzed logs
//
// Description:
// Get hourly usage for analyzed logs (Security Monitoring).
// **Note:** This endpoint has been deprecated. Hourly usage data for all products is now available in the [Get hourly usage by product family API](https://docs.datadoghq.com/api/latest/usage-metering/#get-hourly-usage-by-product-family). Refer to [Migrating from the V1 Hourly Usage APIs to V2](https://docs.datadoghq.com/account_management/guide/hourly-usage-migration/) for the associated migration guide.
//
pub fn GetUsageAnalyzedLogs(allocator: std.mem.Allocator, start_hr: []const u8, end_hr: []const u8) !UsageAnalyzedLogsResponse {
    _ = start_hr;
    _ = end_hr;
    var client = std.http.Client { .allocator = allocator };
    defer client.deinit();

    const headers = &[_]std.http.Header{
        .{ .name = "Content-Type", .value = "application/json" },
        .{ .name = "Accept", .value = "application/json" },
    };

    const uri_str = try std.fmt.allocPrint(allocator, "/api/v1/usage/analyzed_logs", .{});
    defer allocator.free(uri_str);
    const uri = try std.Uri.parse(uri_str);
    var req = try client.request(std.http.Method.GET, uri, .{ .extra_headers = headers });
    defer req.deinit();

    try req.sendBodiless();

    var response = try req.receiveHead(&.{});
    if (response.head.status != .ok) {
        return error.ResponseError;
    }

    var reader_buffer: [100]u8 = undefined;
    const body_reader = response.reader(&reader_buffer);
    const body = try body_reader.readAlloc(allocator, response.head.content_length orelse 1024 * 1024 * 4);
    defer allocator.free(body);

    const parsed = try std.json.parseFromSlice(UsageAnalyzedLogsResponse, allocator, body, .{});
    defer parsed.deinit();

    return parsed.value;
}

