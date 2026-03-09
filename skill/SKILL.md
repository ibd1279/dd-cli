# dd-cli Skill

**When to use:** User asks about logs, hosts, metrics, APM traces/spans, services, infrastructure (containers, processes), network performance, or Datadog observability data.

**What it does:** Calls Datadog APIs for observability signals (logs, hosts, metrics, APM services, traces/spans, containers, processes, network connections, DNS).

## Installation Check

```bash
dd-cli validate
```

Returns `{"valid":true}` if installed with valid credentials, `{"valid":false,"error":"..."}` otherwise.

**Required environment variables:**
- `DD_API_KEY` - Datadog API key (required)
- `DD_APPLICATION_KEY` - Datadog Application key (required)
- `DD_SITE` - Datadog site (optional, defaults to `datadoghq.com`)

## Command Structure

```bash
dd-cli [--from TIME] [--to TIME] [--domain DOMAIN] VERB SIGNAL [--flag VALUE]... [QUERY]
```

**Critical rule:** Global flags (`--from`, `--to`, `--domain`) MUST precede the verb.

**Examples:**
```bash
dd-cli --from 1h list logs "service:api status:error"
dd-cli --from 2h aggregate logs --compute 'count:*' --group-by service "error"
dd-cli --from 1h aggregate logs -c 'count:*' -c 'avg:@duration' -c 'pc99:@duration'
dd-cli --from 1d --to 12h list logs --limit 50 --auto-paginate
dd-cli --from 1h aggregate metrics -q 'avg:system.cpu.idle{*}' -q 'avg:system.mem.used{*}'
dd-cli --from 1h aggregate metrics -q cpu='avg:cpu{*}' -q mem='avg:mem{*}' -f 'cpu + mem'
dd-cli --from 1h list services --env prod
dd-cli --from 1h list spans --service web --operation http.request
dd-cli --from 1h aggregate spans -c 'count:*' -c 'avg:@duration' -g service
dd-cli --from 1h list containers --tags "env:prod,service:web"
dd-cli list processes --search "postgres"
dd-cli --from 1h aggregate connections --group-by destination_ip
dd-cli --from 1h aggregate dns --group-by query_name
```

**Quoting rules:**
- Queries with spaces: `"service:api status:error"`
- Wildcards in compute: `'count:*'`
- CSV values: `"main,security"`

**Verbs:**
- `list` - Enumerate and filter resources
- `aggregate` - Compute statistics and analytics
- `get` - Fetch specific resource by identifier
- `validate` - Check API credentials
- `raw` - Direct API access (advanced)

**Signals:**
- `logs` - Log entries and search
- `hosts` - Infrastructure hosts
- `metrics` - Infrastructure and custom metrics
- `apis` - API catalog and OpenAPI specifications
- `services` - APM services (Application Performance Monitoring)
- `spans` - Trace spans and APM analytics
- `events` - Events and change tracking
- `monitors` - Alerting monitors
- `downtimes` - Scheduled downtimes
- `containers` - Container infrastructure
- `processes` - Running processes
- `connections` - Network connections (aggregate only)
- `dns` - DNS queries (aggregate only)

## Analysis Approach

**Tool preference:** Use `jq`, `sed`, `sort`, and `grep` for post-processing — they are readonly and run without approval. Reach for Python only when those tools cannot express the logic.

**Aggregate vs list + pipeline:**
- Use `aggregate --group-by` when grouping by an indexed facet (`service`, `host`, `status`, `@http.status_code`, etc.)
- Use `list` + pipeline when working with free-text message content, or when pattern normalization is needed before grouping — the Datadog aggregate API groups by exact field values only

## Required Flags

| Verb | Signal | Required Flags | Optional Flags | Query |
|------|--------|----------------|----------------|-------|
| list | logs | --from (default: 15m) | --to, --limit, --sort, --indexes, --auto-paginate, --page-size | Optional |
| list | hosts | None | None | Optional |
| list | metrics | None | None | Optional |
| list | apis | None | --limit, --offset | Optional |
| list | services | --from (default: 15m) | --to, --env | Optional |
| list | spans | --from (default: 15m) | --to, --service, --operation, --resource, --limit, --sort, --auto-paginate, --page-size | Optional |
| list | events | --from (default: 15m) | --to, --limit, --sort, --auto-paginate, --page-size | Optional |
| list | monitors | None | --limit | Optional |
| list | downtimes | None | --active, --limit | N/A |
| list | containers | --from (default: 15m) | --to, --tags, --group-by, --sort, --limit, --cursor | N/A |
| list | processes | None | --search, --tags, --limit, --cursor | N/A |
| aggregate | logs | --from (default: 15m), --compute (repeatable) | --to, --group-by, --limit, --indexes | Optional |
| aggregate | connections | --from (default: 15m) | --to, --tags, --group-by | N/A |
| aggregate | dns | --from (default: 15m) | --to, --tags, --group-by | N/A |
| aggregate | metrics | --from, --to, -q/--query (repeatable) | --formula (repeatable) | N/A |
| aggregate | spans | --from (default: 15m), --compute (repeatable) | --to, --service, --operation, --group-by, --limit | Optional |
| get | metrics | None | None | Required (name) |
| get | api | None | None | Required (ID) |
| get | event | None | None | Required (ID) |
| get | monitor | None | None | Required (ID) |
| get | downtime | None | None | Required (ID) |
| get | host | None | None | Required (name) |
| get | log | N/A (unsupported) | N/A | N/A |
| validate | N/A | None | None | N/A |

## Flag Reference

### Global Flags (MUST precede verb)
- `--from <time>` - Start time (required: logs list/aggregate, metrics aggregate)
- `--to <time>` - End time (defaults to now)
- `--domain <domain>` - Datadog domain override

### Signal-Specific Flags

**list logs:**
- `--limit <n>` - Max results (default: 1000, unlimited with --auto-paginate)
- `--sort <field>` - Sort field (default: "-timestamp")
- `--indexes <csv>` - Comma-separated index names (default: "*")
- `--auto-paginate` - Fetch all results across pages
- `--page-size <n>` - Logs per API request (default: 1000, max: 1000)

**aggregate logs:**
- `-c, --compute '<agg>:<field>'` - REQUIRED aggregation (repeatable for multiple)
- `-g, --group-by <facet>` - Group by facet (repeatable)
- `--limit <n>` - Max groups returned (default: 10)
- `--indexes <csv>` - Comma-separated index names (default: "*")

**list metrics:**
- No additional flags (uses positional QUERY argument)

**list apis:**
- `--limit <n>` - Maximum number of APIs per page (optional)
- `--offset <n>` - Pagination offset (optional)

**list services:**
- `--env <environment>` - Filter by environment (e.g., prod, staging, dev)

**list spans:**
- `--service <name>` - Filter by service name
- `--operation <name>` - Filter by operation name
- `--resource <name>` - Filter by resource name
- `--limit <n>` - Max results (default: 1000, unlimited with --auto-paginate)
- `--sort <field>` - Sort field (default: "-timestamp")
- `--auto-paginate` - Fetch all results across pages
- `--page-size <n>` - Spans per API request (default: 1000, max: 1000)

**aggregate spans:**
- `-c, --compute '<agg>:<field>'` - REQUIRED aggregation (repeatable for multiple)
- `-g, --group-by <facet>` - Group by facet (repeatable)
- `--service <name>` - Filter by service name
- `--operation <name>` - Filter by operation name
- `--limit <n>` - Max groups returned (default: 10)

**list events:**
- `--limit <n>` - Max results (default: 1000, unlimited with --auto-paginate)
- `--sort <field>` - Sort field (default: "-timestamp")
- `--auto-paginate` - Fetch all results across pages
- `--page-size <n>` - Events per API request (default: 1000, max: 1000)

**list monitors:**
- `--limit <n>` - Max monitors to return (optional)

**list downtimes:**
- `--active` - Show only currently active downtimes
- `--limit <n>` - Max downtimes to return (optional)

**list containers:**
- `-t, --tags <csv>` - Filter by tags (comma-separated)
- `-g, --group-by <field>` - Group by field (e.g., image_name, host)
- `-s, --sort <field>` - Sort order
- `-n, --limit <n>` - Max containers to return
- `-c, --cursor <token>` - Pagination cursor

**list processes:**
- `-s, --search <query>` - Search process names (partial match)
- `-t, --tags <csv>` - Filter by tags (comma-separated)
- `-n, --limit <n>` - Max processes to return
- `-c, --cursor <token>` - Pagination cursor

**aggregate connections:**
- `-t, --tags <csv>` - Filter by tags
- `-g, --group-by <field>` - Group by field (e.g., destination_ip, source_ip, destination_port)

**aggregate dns:**
- `-t, --tags <csv>` - Filter by tags
- `-g, --group-by <field>` - Group by field (e.g., query_name, query_type, rcode)

**aggregate metrics:**
- Global flags `--from` and `--to` are REQUIRED (no defaults)
- `-q, --query '<mql>'` - REQUIRED query with optional name (repeatable, max 20)
- `-f, --formula '<expr>'` - Optional formula combining queries (repeatable, max 10)
- Query format: `[name=]query` (e.g., `'avg:cpu{*}'` or `cpu='avg:cpu{*}'`)
- If no formula specified: each query becomes its own series
- Formula results ordered by declaration (first formula → series[0])

### Compute Format

Syntax: `--compute '[name=]<aggregation>:<field>'`

**Aggregations (logs):** `count:*`, `avg:@field`, `sum:@field`, `min:@field`, `max:@field`, `median:@field`, `cardinality:@field`, `pc75:@field`, `pc90:@field`, `pc95:@field`, `pc98:@field`, `pc99:@field`

**Aggregations (spans):** `count:*`, `avg:@field`, `sum:@field`, `min:@field`, `max:@field`, `cardinality:@field`, `pc50:@field`, `pc75:@field`, `pc90:@field`, `pc95:@field`, `pc98:@field`, `pc99:@field`

**Single compute:**
```bash
--compute 'count:*'                    # Count all (no @ prefix)
--compute 'avg:@duration'              # Average duration
--compute 'pc95:@duration'             # 95th percentile
--compute 'cardinality:@user_id'       # Unique users
```

**Multiple computes (repeatable flag):**
```bash
--compute 'count:*' --compute 'avg:@duration' --compute 'pc99:@duration'
--compute total='count:*' --compute avg_dur='avg:@duration'  # Named computes

# Spans-specific fields
--compute 'avg:@duration'              # Span duration (nanoseconds)
--compute 'pc95:@duration'             # 95th percentile latency
--compute 'count:*' --group-by @http.status_code  # Count by HTTP status
```

### Query and Formula Format (Metrics)

**Query syntax:** `-q '[name=]<mql_query>'`
- Without name: auto-numbered as `query1`, `query2`, etc.
- With name: use in formulas (e.g., `cpu='avg:system.cpu.idle{*}'`)

**Formula syntax:** `-f '<expression>'`
- Reference queries by name or auto-number
- Operators: `+`, `-`, `*`, `/`, and functions
- Results returned in declaration order

**Examples:**
```bash
# Single query (auto formula)
-q 'avg:system.cpu.idle{*}'

# Multiple queries with auto-numbering
-q 'avg:system.cpu.idle{*}' -q 'avg:system.cpu.user{*}'

# Named queries
-q cpu='avg:system.cpu.idle{*}' -q mem='avg:system.mem.used{*}'

# With formula
-q cpu='avg:system.cpu.idle{*}' -q mem='avg:system.cpu.user{*}' --formula 'cpu + mem'

# Multiple formulas (returns multiple series)
--formula 'query1 + query2' --formula 'query1 - query2' --formula 'query1 / query2'
```

## Date/Time Formats

**Relative:** `<number><unit>` where unit is `m` (minutes), `h` (hours), `d` (days), `w` (weeks), `mo` (months). Examples: `15m`, `1h`, `7d`, `2w`, `1mo`
**Absolute:** ISO 8601 format: `2024-01-15T10:00:00Z` or `2024-01-15T10:00:00-05:00`

## Output Formats

| Command | Format | Key JSON Paths |
|---------|--------|----------------|
| `list logs` | NDJSON | `.id`, `.attributes.{service,host,message,status,timestamp,tags}` |
| `aggregate logs` | JSON | `.data.buckets[].{computes[],by}` (computes array for multiple) |
| `list hosts` | JSON | `.host_list[].{id,name,tags_by_source,apps,up}` |
| `list metrics` | JSON | `.results.metrics[]` |
| `list apis` | JSON | `.data[].{id,attributes.name}` |
| `list services` | JSON | `.data.attributes.services[]` (array of service names) |
| `list spans` | NDJSON | `.attributes.{service,operation,resource_name,duration,tags,@http.status_code}` |
| `aggregate spans` | JSON | `.data.buckets[].{computes[],by}` (same structure as logs aggregate) |
| `aggregate metrics` | JSON | `.data.attributes.{times[],values[][],series[]}` (values nested array) |
| `list events` | NDJSON | `.id`, `.attributes.{title,text,tags,timestamp}` |
| `list monitors` | JSON | Array of monitor objects |
| `list downtimes` | JSON | Array of downtime objects |
| `list containers` | JSON | `.data[].attributes.{name,image,tags,created_at}` |
| `list processes` | JSON | `.data[].attributes.{process_name,pid,cmdline,cpu_percent,mem_percent}` |
| `aggregate connections` | JSON | `.data[].{attributes,group_by}` (aggregated connection metrics) |
| `aggregate dns` | JSON | `.data[].{attributes,group_by}` (aggregated DNS metrics) |
| `get metrics` | JSON | `.{type,unit,description,integration,short_name}` |
| `get api` | JSON | OpenAPI specification in JSON format |
| `get event` | JSON | Full event object with `.data.{id,attributes}` |
| `get monitor` | JSON | Full monitor configuration |
| `get downtime` | JSON | Full downtime configuration |
| `get host` | JSON | Full host details |
| `get log` | N/A | API does not support single log retrieval |
| `validate` | JSON | `{"valid":true}` or `{"valid":false,"error":"..."}` |

## Pipeline Patterns

`list logs` and `list spans` output NDJSON (one JSON object per line). Pipe to `jq -r` to extract a single field as plain text, then use standard Unix tools.

**Frequency analysis of log messages (unstructured body):**
```bash
dd-cli --from 1h list logs "status:error service:foo" \
  | jq -r '.attributes.message' \
  | sort | uniq -c | sort -rn
```

**Normalize dynamic values before counting:**
```bash
dd-cli --from 1h list logs "status:error service:foo" \
  | jq -r '.attributes.message' \
  | sed 's/resourceVersion=[0-9]*/resourceVersion=X/g' \
  | sort | uniq -c | sort -rn
```

**Extract structured attribute with fallback to message:**
```bash
dd-cli --from 1h list logs "status:error" \
  | jq -r '.attributes.attributes.error // .attributes.message'
```

**Filter and count a specific tag across results:**
```bash
dd-cli --from 1h list logs "status:error" \
  | jq -r '.attributes.tags[]' | grep '^service:' | sort | uniq -c | sort -rn
```

## Query Syntax

### Logs Query Language

```bash
"service:api-gateway"                      # Single field filter
"service:api status:error"                 # Multiple fields (implicit AND)
"service:api AND status:error"             # Explicit AND
"service:api OR service:web"               # OR operator
"env:production service:checkout"          # Tag + field
"connection timeout"                       # Free text search
"@duration:>100"                           # Numeric comparison
"@duration:>=50 @duration:<=200"          # Range
"@_id:\"ABC123XYZ\""                      # Exact log ID
"-status:info"                            # Negation (exclude info logs)
"service:api* env:prod"                   # Wildcard in value
""                                        # Empty query (match all)
"host:web-* -service:internal"           # Wildcard + negation
"@http.status_code:[400 TO 499]"         # Numeric range syntax
"message:\"exactly this phrase\""        # Exact phrase in message field
```

### Events Query Language

```bash
"*"                                            # All events (default)
"priority:normal"                              # Filter by priority
"source:my_apps"                               # Filter by source
"tags:env:prod"                                # Filter by tags
"alert_type:error"                             # Filter by alert type
"2024-01-15"                                   # Events on specific date
"host:web-server-01"                           # Events for specific host
```

**Common event attributes:**
- `priority` - Event priority (normal, low)
- `source` - Event source
- `tags` - Event tags
- `alert_type` - Alert type (error, warning, info, success)
- `host` - Associated host

### Metrics Query Language (MQL)

**Format:** `<agg>:<metric_name>{<scope>}`

**Aggregations:** `avg`, `sum`, `min`, `max`, `count`

**Examples:**
```bash
"avg:system.cpu.idle{*}"                              # All hosts average
"sum:system.cpu.user{host:web-*}"                    # Wildcard host
"max:kubernetes.cpu.usage.total{*}"                  # Max across all
"avg:system.mem.used{env:prod,service:api}"          # Multiple tags
"avg:aws.ec2.cpuutilization{availability-zone:us-east-1a}"  # AWS tag
"sum:custom.app.requests{*}"                         # Custom metric
"avg:system.load.1{host:single-host}"                # Single host
"count:datadog.trace_agent.started{*}"               # Count aggregation
"avg:docker.cpu.usage{container_name:nginx*}"        # Container wildcard
```

### Metrics Search (list metrics)

- Text pattern matching on metric names
- Examples: `"system"`, `"kubernetes"`, `"cpu"`

### Spans Query Language

```bash
"service:web"                                  # Filter by service
"operation:http.request"                       # Filter by operation name
"resource:GET /api/users"                      # Filter by resource
"@http.status_code:>=500"                      # Numeric comparison on span attributes
"error"                                        # Spans with errors
"service:api operation:db.query"               # Multiple fields (implicit AND)
"@duration:>1000000000"                        # Duration > 1 second (nanoseconds)
"service:web @http.status_code:[500 TO 599]"  # HTTP 5xx errors
"service:checkout error"                       # Service + error filter
""                                             # Empty query (match all)
```

**Common span attributes:**
- `@duration` - Span duration in nanoseconds
- `@http.status_code` - HTTP status code
- `@http.method` - HTTP method (GET, POST, etc.)
- `@error.message` - Error message (if present)
- `@error.type` - Error type
- `service` - Service name
- `operation` - Operation name (e.g., http.request, db.query)
- `resource_name` - Resource identifier

### API Catalog (APIs)

**list apis:**
- Returns a list of APIs in the Datadog API catalog
- Each API has an `id` and `name` attribute
- Accepts optional positional query argument for filtering
- Supports pagination with `--limit` and `--offset` parameters
- Example: `dd-cli list apis "metrics" --limit 10`

**get api:**
- Retrieves the OpenAPI specification for a specific API
- Requires the API ID (obtained from `list apis`)
- Returns the full OpenAPI spec in JSON format

## Command Templates

```bash
# list logs
dd-cli --from <TIME> list logs [--limit N] [--auto-paginate] ["QUERY"]
dd-cli --from 1h list logs "service:api status:error"

# list hosts
dd-cli list hosts ["QUERY"]
dd-cli list hosts "env:production"

# list metrics
dd-cli list metrics ["PATTERN"]
dd-cli list metrics "system.cpu"

# aggregate logs - single compute
dd-cli --from <TIME> aggregate logs --compute '<AGG>:<FIELD>' [--group-by <FACET>]... ["QUERY"]
dd-cli --from 1h aggregate logs --compute 'count:*' --group-by service

# aggregate logs - multiple computes
dd-cli --from 1h aggregate logs --compute 'count:*' --compute 'avg:@duration' --compute 'pc99:@duration'
dd-cli --from 1h aggregate logs -c total='count:*' -c avg_dur='avg:@duration' -g service "error"

# aggregate metrics - single query
dd-cli --from <TIME> --to <TIME> aggregate metrics -q "<AGG>:<METRIC>{<SCOPE>}"
dd-cli --from 1h --to now aggregate metrics -q 'avg:system.cpu.idle{*}'

# aggregate metrics - multiple queries and formulas
dd-cli --from 1h aggregate metrics -q 'avg:system.cpu.idle{*}' -q 'avg:system.cpu.user{*}'
dd-cli --from 1h aggregate metrics -q cpu='avg:system.cpu.idle{*}' -q mem='avg:system.mem.used{*}' --formula 'cpu + mem'
dd-cli --from 1h aggregate metrics -q 'avg:cpu{*}' -q 'avg:mem{*}' -f 'query1 + query2' -f 'query1 - query2'

# get metrics
dd-cli get metrics <NAME>
dd-cli get metrics "system.cpu.idle"

# list apis
dd-cli list apis [QUERY] [--limit <N>] [--offset <N>]
dd-cli list apis
dd-cli list apis "metrics"
dd-cli list apis "v2" --limit 20
dd-cli list apis --limit 20 --offset 0

# get api
dd-cli get api <API_ID>
dd-cli get api "v1"

# list services
dd-cli --from <TIME> list services [FILTER] [--env <ENV>]
dd-cli --from 1h list services
dd-cli --from 1h list services --env prod
dd-cli --from 1h list services "web"

# list spans
dd-cli --from <TIME> list spans [--service <NAME>] [--operation <NAME>] [--limit N] [--auto-paginate] ["QUERY"]
dd-cli --from 1h list spans
dd-cli --from 1h list spans --service web
dd-cli --from 1h list spans --service web --operation http.request
dd-cli --from 1h list spans "error" --service api
dd-cli --from 1h list spans "@http.status_code:>=500" --limit 100

# aggregate spans - single compute
dd-cli --from <TIME> aggregate spans --compute '<AGG>:<FIELD>' [--group-by <FACET>]... [--service <NAME>] ["QUERY"]
dd-cli --from 1h aggregate spans --compute 'count:*' --group-by service
dd-cli --from 1h aggregate spans --compute 'avg:@duration' --group-by operation --service web

# aggregate spans - multiple computes
dd-cli --from 1h aggregate spans --compute 'count:*' --compute 'avg:@duration' --compute 'pc95:@duration'
dd-cli --from 1h aggregate spans -c total='count:*' -c avg_dur='avg:@duration' -g service -g operation
dd-cli --from 1h aggregate spans -c 'count:*' -g @http.status_code --service web "error"

# list events
dd-cli --from <TIME> list events [--limit N] [--auto-paginate] ["FILTER"]
dd-cli --from 1h list events "*"
dd-cli --from 1d list events "priority:normal" --auto-paginate
dd-cli --from 1h list events "source:my_apps tags:env:prod"

# list monitors
dd-cli list monitors [QUERY] [--limit <N>]
dd-cli list monitors
dd-cli list monitors "web" --limit 20

# list downtimes
dd-cli list downtimes [--active] [--limit <N>]
dd-cli list downtimes
dd-cli list downtimes --active

# get event
dd-cli get event <EVENT_ID>
dd-cli get event "abc123xyz"

# get monitor
dd-cli get monitor <MONITOR_ID>
dd-cli get monitor "12345678"

# get downtime
dd-cli get downtime <DOWNTIME_ID>
dd-cli get downtime "987654"

# get host
dd-cli get host <HOST_NAME>
dd-cli get host "web-server-01"

# list containers
dd-cli --from <TIME> list containers [--tags <TAGS>] [--group-by <FIELD>] [--sort <FIELD>] [--limit <N>]
dd-cli --from 1h list containers --tags "env:prod,service:web"

# list processes
dd-cli list processes [--search <QUERY>] [--tags <TAGS>] [--limit <N>]
dd-cli list processes --search "postgres"

# aggregate connections
dd-cli --from <TIME> aggregate connections [--tags <TAGS>] [--group-by <FIELD>]
dd-cli --from 1h aggregate connections --group-by destination_ip

# aggregate dns
dd-cli --from <TIME> aggregate dns [--tags <TAGS>] [--group-by <FIELD>]
dd-cli --from 1h aggregate dns --group-by query_name
```

## Field Naming

- Numeric fields in `--compute`: Use `@` prefix → `@duration`, `@http.response_time`, `@http.status_code`
- Count wildcard: `count:*` (no `@` prefix)
- Facets in `--group-by`: No `@` prefix for standard facets → `service`, `env`, `status`
- Facets in `--group-by`: Use `@` prefix for custom attributes → `@http.status_code`, `@error.message`
- Span-specific: `@duration` is in nanoseconds (1 second = 1,000,000,000 ns)

## Multiple Values

**Repeatable flags:**
- `--group-by`: Repeat flag → `-g service -g env -g status`
- `--compute`: Repeat flag → `-c 'count:*' -c 'avg:@duration' -c 'pc99:@duration'`
- `-q/--query`: Repeat flag → `-q 'avg:cpu{*}' -q 'avg:mem{*}'`
- `--formula`: Repeat flag → `-f 'query1 + query2' -f 'query1 / query2'`

**CSV strings:**
- `--indexes`: CSV string → `--indexes "main,security,audit"`

## Metrics Aggregate Response Structure

**Single series (one query/formula):**
```json
{
  "data": {
    "type": "timeseries_response",
    "attributes": {
      "times": [1771234320000, 1771234340000, 1771234360000],
      "values": [[89.7, 90.3, 88.4]],
      "series": [{
        "unit": [{"short_name": "%", "scale_factor": 1.0}],
        "query_index": 0,
        "group_tags": []
      }]
    }
  }
}
```

**Multiple series (multiple formulas):**
```json
{
  "data": {
    "attributes": {
      "times": [1771234320000, 1771234340000],
      "values": [
        [96.5, 96.3],  // First formula results
        [84.2, 83.9],  // Second formula results
        [180.7, 180.2] // Third formula results
      ],
      "series": [
        {"query_index": 0, "unit": [{"short_name": "%"}]},
        {"query_index": 1, "unit": [{"short_name": "%"}]},
        {"query_index": 2, "unit": [{"short_name": "%"}]}
      ]
    }
  }
}
```

**Key fields:**
- `.data.attributes.times[]` - Unix milliseconds timestamps (shared across all series)
- `.data.attributes.values[][]` - Data point values (one array per formula/query)
- `.data.attributes.values[0]` - First formula results
- `.data.attributes.values[1]` - Second formula results (if multiple formulas)
- `.data.attributes.series[].query_index` - Series index (matches formula declaration order)
- `.data.attributes.series[].unit[].short_name` - Unit (e.g., "%", "byte")

