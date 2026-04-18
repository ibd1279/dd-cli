# dd-cli

Command-line tool for querying the Datadog API.

## Installation

```bash
# Install to /usr/local
sudo zig build -Doptimize=ReleaseFast --prefix /usr/local

# Install to ~/.local
zig build -Doptimize=ReleaseFast --prefix ~/.local

# Verify
dd-cli --help
```

## Configuration

### API Key Authentication

Set environment variables:

```bash
export DD_API_KEY="your_api_key"
export DD_APPLICATION_KEY="your_application_key"
export DD_SITE="datadoghq.com"  # Optional: datadoghq.eu, us3.datadoghq.com, etc.
```

### Bearer Token Authentication

Set `DD_ACCESS_TOKEN` to use a bearer token directly:

```bash
export DD_ACCESS_TOKEN="your_access_token"
```

Alternatively, place a token JSON file at `~/.config/dd-cli/token.json` with the fields `access_token` and `expires_at` (Unix seconds). dd-cli reads this file automatically when no env vars are set.

**Authentication priority:** `DD_ACCESS_TOKEN` env var → `~/.config/dd-cli/token.json` → `DD_API_KEY` + `DD_APPLICATION_KEY`

## Commands

### validate

Verify API credentials:

```bash
dd-cli validate
dd-cli --domain datadoghq.eu validate
```

### list hosts

List hosts with optional filters:

```bash
# All hosts
dd-cli list hosts

# Filter by tags
dd-cli list hosts "env:prod"
dd-cli list hosts "env:prod,role:web"

# With time range (ISO 8601)
dd-cli --from "2024-01-15T00:00:00Z" --to "2024-01-15T23:59:59Z" list hosts
```

### get host

Get specific host details:

```bash
dd-cli get host "i-abc123"
dd-cli get host "server.example.com"
```

### list logs

Search and retrieve log events with optional pagination:

```bash
# Basic search - returns first page (up to 1000 logs by default)
dd-cli list logs "service:web"

# Search with time range
dd-cli --from "2024-01-15T10:00:00Z" --to "2024-01-15T11:00:00Z" \
  list logs "status:error"

# Single page with explicit limit
dd-cli list logs "*" --limit 100

# Multiple pages up to 5000 total logs
dd-cli list logs "*" --auto-paginate --limit 5000

# Get all logs matching query (use with caution!)
dd-cli list logs "status:error" --auto-paginate

# Search specific indexes
dd-cli list logs "*" --indexes "main,staging"

# Sort order (default: -timestamp for newest first)
dd-cli list logs "*" --sort "timestamp"  # Oldest first

# Pipe to jq for filtering
dd-cli list logs "@http.status_code:>=500" | jq -r '.attributes.message'

# Real-time log monitoring pattern
dd-cli list logs "*" --auto-paginate | grep "ERROR"

# Extract specific fields
dd-cli list logs "service:api" | \
  jq -r '[.attributes.timestamp, .attributes.service, .attributes.message] | @tsv'
```

**Options:**
- `FILTER`: Search query string (positional, default: `*` for all logs)
- `-i, --indexes`: Comma-separated index names (default: `*` for all indexes)
- `-n, --limit`: Maximum total logs to return
  - Without `--auto-paginate`: defaults to 1000 (single page cap)
  - With `--auto-paginate`: defaults to unlimited (fetch all matching logs)
- `--page-size`: Logs per API request (default: 1000, max: 1000)
- `-s, --sort`: Sort order (default: `-timestamp` for newest first)
- `--auto-paginate`: Enable automatic pagination across multiple pages

**Pagination Behavior:**

Without `--auto-paginate` (default):
- Fetches a single page only
- Returns up to 1000 logs (or `--limit` if specified)
- Fast and safe for exploratory queries

With `--auto-paginate`:
- Fetches multiple pages until exhausted or limit reached
- Without `--limit`: fetches ALL matching logs (use carefully!)
- With `--limit`: stops after reaching the specified number

**Output Format:** Newline-delimited JSON (NDJSON) - one log event per line, ideal for piping to tools like `jq`, `grep`, and `awk`.

**Query Syntax:** Uses [Datadog Log Search Syntax](https://docs.datadoghq.com/logs/explorer/search_syntax/)
- `service:web` - filter by service
- `status:error` - filter by status
- `@http.status_code:>=500` - filter by custom attributes
- `env:prod AND status:error` - combine conditions
- `*` - match all logs

### aggregate logs

Aggregate log analytics with multiple compute operations:

```bash
# Single compute (count all logs)
dd-cli --from 1h aggregate logs --compute 'count:*'

# Multiple computes in one request
dd-cli --from 1h aggregate logs \
  --compute 'count:*' \
  --compute 'avg:@duration' \
  --compute 'pc99:@response_time'

# Named computes (for clarity in results)
dd-cli --from 1h aggregate logs \
  --compute total='count:*' \
  --compute avg_dur='avg:@duration' \
  --compute p99_dur='pc99:@duration'

# With filter and group-by
dd-cli --from 1h aggregate logs \
  --compute 'count:*' \
  --compute 'avg:@duration' \
  --group-by service \
  --group-by status \
  'service:web'

# With indexes
dd-cli --from 1h aggregate logs \
  --compute 'count:*' \
  --indexes "main,staging" \
  'status:error'
```

**Options:**
- `-c, --compute`: Compute metric (repeatable). Format: `[name=]aggregation:field`
  - Examples: `count:*`, `avg:@duration`, `total='count:*'`
  - Aggregations: count, avg, sum, min, max, median, cardinality, pc75, pc90, pc95, pc98, pc99
- `-g, --group-by`: Group by facet (repeatable)
- `-i, --indexes`: Comma-separated indexes (default: `*`)
- `--limit`: Max buckets per group-by (default: 10)
- `FILTER`: Optional positional filter query (default: `*`)

### aggregate metrics

Aggregate metrics with MQL queries and formulas:

```bash
# Single query
dd-cli --from 1h aggregate metrics \
  -q 'avg:system.cpu.idle{*}'

# Multiple queries with auto-numbered names
dd-cli --from 1h aggregate metrics \
  -q 'avg:system.cpu.idle{*}' \
  -q 'avg:system.mem.used{*}'

# Named queries
dd-cli --from 1h aggregate metrics \
  -q cpu='avg:system.cpu.idle{*}' \
  -q mem='avg:system.mem.used{*}'

# Single formula combining queries
dd-cli --from 1h aggregate metrics \
  -q cpu='avg:system.cpu.idle{*}' \
  -q mem='avg:system.mem.used{*}' \
  --formula 'cpu + mem'

# Auto-numbered queries with formula
dd-cli --from 1h aggregate metrics \
  -q 'avg:system.cpu.idle{*}' \
  -q 'avg:system.mem.used{*}' \
  --formula 'query1 / query2'

# Multiple formulas (returns multiple result series)
dd-cli --from 1h aggregate metrics \
  -q 'avg:system.cpu.idle{*}' \
  -q 'avg:system.mem.used{*}' \
  --formula 'query1 + query2' \
  --formula 'query1 - query2' \
  --formula 'query1 / query2'

# Complex example with multiple queries and formulas
dd-cli --from 1h aggregate metrics \
  -q cpu_idle='avg:system.cpu.idle{*}' \
  -q cpu_user='avg:system.cpu.user{*}' \
  -q cpu_system='avg:system.cpu.system{*}' \
  --formula 'cpu_idle + cpu_user + cpu_system' \
  --formula '100 - cpu_idle'
```

**Options:**
- `-q, --query`: Query with optional name (repeatable, max 20). Format: `[name=]query`
  - Examples: `'avg:cpu{*}'`, `cpu='avg:cpu{*}'`
  - Without name: auto-numbered as query1, query2, ...
- `-f, --formula`: Formula combining queries (repeatable, max 10)
  - Examples: `'query1 + query2'`, `'cpu / mem * 100'`
  - If not specified: each query becomes its own formula
  - Multiple formulas return multiple result series
  - **Result order matches formula declaration order** (first formula → series[0], etc.)

**Note:** Both aggregate commands require `--from` and `--to` flags or relative time ranges.

**Time Range Examples:**
```bash
# Relative time (1 hour ago to now)
dd-cli --from 1h aggregate logs --compute 'count:*'

# ISO 8601 timestamps
dd-cli --from "2024-01-15T10:00:00Z" --to "2024-01-15T11:00:00Z" \
  aggregate metrics -q 'avg:system.cpu.idle{*}'

# Last 24 hours
dd-cli --from 1d aggregate logs --compute 'avg:@duration' --group-by service
```

### Time Range Formats

dd-cli supports three time formats for `--from` and `--to`:

1. **"now" keyword** - Current timestamp (case-insensitive)
   ```bash
   dd-cli --from 1h --to now list logs "*"
   ```

2. **Relative times** - Offset from current time
   - Minutes: `15m`, `30min`
   - Hours: `1h`, `2hours`
   - Days: `1d`, `7days`
   - Weeks: `1w`, `2weeks`
   - Months: `1mo`, `3months`

   ```bash
   dd-cli --from 1d list logs "error"
   ```

3. **ISO 8601 absolute timestamps** - Exact time in UTC
   ```bash
   dd-cli --from "2024-01-15T10:00:00Z" --to "2024-01-15T11:00:00Z" list logs "*"
   ```

**Default behavior:**
- `--from` defaults to 15 minutes ago if not specified
- `--to` defaults to now if not specified

## APM (Application Performance Monitoring)

### list services

List APM services in your environment:

```bash
# List all services from last hour
dd-cli --from 1h list services

# Filter by environment
dd-cli --from 1h list services --env prod

# Filter by service name pattern
dd-cli --from 1h list services "web"

# Specific time range
dd-cli --from "2024-01-15T10:00:00Z" --to "2024-01-15T11:00:00Z" list services
```

**Options:**
- `FILTER`: Optional service filter query (positional)
- `--env`: Filter by environment (e.g., prod, staging, dev)

**Output:** JSON response with array of service names and metadata.

### list spans

Search and retrieve trace spans with automatic pagination:

```bash
# List spans from last hour
dd-cli --from 1h list spans

# Filter by service
dd-cli --from 1h list spans --service web

# Filter by service and operation
dd-cli --from 1h list spans --service web --operation http.request

# Search with query filter
dd-cli --from 1h list spans "error"
dd-cli --from 1h list spans "@http.status_code:>=500"

# Combine query with service filter
dd-cli --from 1h list spans "error" --service api --operation db.query

# Multiple pages up to 5000 spans
dd-cli --from 1h list spans --auto-paginate --limit 5000

# Extract specific fields with jq
dd-cli --from 1h list spans --service web | \
  jq -r '.attributes | [.service, .resource_name, .duration] | @tsv'

# Find slowest operations
dd-cli --from 1h list spans --service web --limit 1000 | \
  jq -r '.attributes | [.duration, .resource_name] | @tsv' | \
  sort -rn | head -20
```

**Options:**
- `FILTER`: Span filter query (default: `*`)
- `--service`: Filter by service name
- `--operation`: Filter by operation name
- `--resource`: Filter by resource name
- `-n, --limit`: Max total spans (default: 1000 without `--auto-paginate`, unlimited with)
- `--page-size`: Spans per API request (default: 1000, max: 1000)
- `-s, --sort`: Sort order (default: `-timestamp`)
- `--auto-paginate`: Fetch multiple pages automatically

**Output Format:** Newline-delimited JSON (NDJSON) - one span per line.

**Query Syntax:** Uses Datadog span search syntax:
- `service:web` - filter by service
- `operation:http.request` - filter by operation
- `resource:GET /api/users` - filter by resource
- `@http.status_code:>=500` - filter by span attributes
- `error` - spans with errors
- `*` - match all spans

### aggregate spans

Compute analytics on span data with multiple aggregations:

```bash
# Count spans by service
dd-cli --from 1h aggregate spans \
  --compute 'count:*' \
  --group-by service

# Average duration by service and operation
dd-cli --from 1h aggregate spans \
  --compute 'avg:@duration' \
  --group-by service \
  --group-by operation

# Multiple metrics with named computes
dd-cli --from 1h aggregate spans \
  --compute total='count:*' \
  --compute avg_duration='avg:@duration' \
  --compute p99_duration='pc99:@duration' \
  --group-by service

# Error rate by service
dd-cli --from 1h aggregate spans \
  --compute 'count:*' \
  --group-by service \
  "error"

# Filter by service
dd-cli --from 1h aggregate spans \
  --compute 'count:*' \
  --compute 'avg:@duration' \
  --service web \
  --group-by operation

# Complex aggregation with multiple dimensions
dd-cli --from 1h aggregate spans \
  --compute total='count:*' \
  --compute errors='count:*' \
  --compute avg_dur='avg:@duration' \
  --compute p95_dur='pc95:@duration' \
  --compute p99_dur='pc99:@duration' \
  --group-by service \
  --group-by @http.status_code \
  --limit 20
```

**Options:**
- `-c, --compute`: Compute metric (repeatable, max 20). Format: `[name=]aggregation:field`
  - Examples: `count:*`, `avg:@duration`, `pc99:@duration`
  - Aggregations: count, avg, sum, min, max, pc50, pc75, pc90, pc95, pc98, pc99, cardinality
  - Common span metrics: `@duration`, `@http.status_code`, `@error.message`
- `-g, --group-by`: Group by facet (repeatable, max 20)
  - Examples: `service`, `operation`, `resource_name`, `@http.status_code`
- `--service`: Filter by service name
- `--operation`: Filter by operation name
- `--limit`: Max buckets per group-by (default: 10)
- `FILTER`: Optional positional filter query (default: `*`)

**Output:** JSON response with aggregated metrics grouped by specified facets.

**Common Use Cases:**
```bash
# Service health dashboard
dd-cli --from 1h aggregate spans \
  --compute 'count:*' \
  --compute 'avg:@duration' \
  --compute 'pc95:@duration' \
  --group-by service

# Error analysis
dd-cli --from 1h aggregate spans \
  --compute 'count:*' \
  --group-by service \
  --group-by @error.message \
  "error"

# HTTP status code distribution
dd-cli --from 1h aggregate spans \
  --compute 'count:*' \
  --group-by @http.status_code \
  --service web

# Slowest operations
dd-cli --from 1h aggregate spans \
  --compute 'avg:@duration' \
  --compute 'pc99:@duration' \
  --group-by operation \
  --service web \
  --limit 20
```

## Infrastructure

### list containers

List containers with filtering and pagination:

```bash
# List all containers from last hour
dd-cli --from 1h list containers

# Filter by tags
dd-cli --from 1h list containers --tags "env:prod,service:web"

# Group by image name
dd-cli --from 1h list containers --group-by image_name

# Sort and limit results
dd-cli --from 1h list containers --sort name --limit 50

# Pagination with cursor
dd-cli --from 1h list containers --limit 100 --cursor "next_page_token"

# Extract container details with jq
dd-cli --from 1h list containers --tags "env:prod" | \
  jq -r '.data[] | "\(.attributes.name) - \(.attributes.image)"'
```

**Options:**
- `-t, --tags`: Filter by tags (comma-separated, e.g., "env:prod,service:web")
- `-g, --group-by`: Group by field (e.g., image_name, host)
- `-s, --sort`: Sort order
- `-n, --limit`: Max containers to return
- `-c, --cursor`: Pagination cursor from previous response

**Output:** JSON response with container data including names, images, tags, and resource usage.

### list processes

List running processes with search and filtering:

```bash
# List all processes
dd-cli list processes

# Search for specific process
dd-cli list processes --search "postgres"

# Filter by tags
dd-cli list processes --tags "env:prod"

# Search and filter combined
dd-cli list processes --search "nginx" --tags "env:prod,role:web"

# Limit results
dd-cli list processes --limit 100

# Pagination with cursor
dd-cli list processes --limit 50 --cursor "next_page_token"

# Extract process details with jq
dd-cli list processes --search "python" | \
  jq -r '.data[] | "\(.attributes.process_name) (PID: \(.attributes.pid))"'
```

**Options:**
- `-s, --search`: Search process names (partial match)
- `-t, --tags`: Filter by tags (comma-separated)
- `-n, --limit`: Max processes to return
- `-c, --cursor`: Pagination cursor from previous response

**Output:** JSON response with process data including names, PIDs, command lines, and resource metrics.

**Note:** The processes API does not support time filtering. The `--from` and `--to` flags are ignored for this command (a warning is displayed if provided).

## Network Performance Monitoring

### aggregate connections

Aggregate network connection data:

```bash
# Aggregate all connections from last hour
dd-cli --from 1h aggregate connections

# Group by destination IP
dd-cli --from 1h aggregate connections --group-by destination_ip

# Filter by tags
dd-cli --from 30m aggregate connections --tags "env:prod"

# Group by multiple dimensions
dd-cli --from 1h aggregate connections --tags "service:web" --group-by source_ip

# Analyze connection patterns
dd-cli --from 1h aggregate connections --group-by destination_port | \
  jq '.data[] | select(.attributes.count > 1000)'
```

**Options:**
- `-t, --tags`: Filter by tags
- `-g, --group-by`: Group by field (e.g., destination_ip, source_ip, destination_port)

**Output:** JSON response with aggregated connection metrics grouped by specified dimensions.

**Common Use Cases:**
```bash
# Top destination IPs
dd-cli --from 1h aggregate connections --group-by destination_ip

# Analyze traffic by service
dd-cli --from 1h aggregate connections --tags "env:prod" --group-by service

# Connection patterns by port
dd-cli --from 30m aggregate connections --group-by destination_port
```

### aggregate dns

Aggregate DNS query data:

```bash
# Aggregate all DNS queries from last hour
dd-cli --from 1h aggregate dns

# Group by query name
dd-cli --from 1h aggregate dns --group-by query_name

# Filter by tags
dd-cli --from 30m aggregate dns --tags "env:prod"

# Analyze DNS performance
dd-cli --from 1h aggregate dns --group-by query_type

# Find most queried domains
dd-cli --from 1h aggregate dns --group-by query_name | \
  jq '.data[] | {name: .attributes.query_name, count: .attributes.count}' | \
  jq -s 'sort_by(.count) | reverse | .[:10]'
```

**Options:**
- `-t, --tags`: Filter by tags
- `-g, --group-by`: Group by field (e.g., query_name, query_type, rcode)

**Output:** JSON response with aggregated DNS metrics grouped by specified dimensions.

**Common Use Cases:**
```bash
# Most queried domains
dd-cli --from 1h aggregate dns --group-by query_name

# DNS query types distribution
dd-cli --from 1h aggregate dns --group-by query_type

# Analyze DNS errors
dd-cli --from 1h aggregate dns --group-by rcode

# DNS performance by service
dd-cli --from 30m aggregate dns --tags "service:api" --group-by query_name
```

## Events, Monitors, and Downtimes

### list events

Search and retrieve events with automatic pagination:

```bash
# List events from last hour
dd-cli --from 1h list events

# Search all events (wildcard)
dd-cli --from 1h list events "*"

# Filter by priority
dd-cli --from 1h list events "priority:normal"

# Filter by source and tags
dd-cli --from 1h list events "source:my_apps tags:env:prod"

# Filter by alert type
dd-cli --from 1h list events "alert_type:error"

# Events from specific host
dd-cli --from 1h list events "host:web-server-01"

# Events on specific date
dd-cli --from 1d list events "2024-01-15"

# Multiple pages with auto-pagination
dd-cli --from 1d list events "priority:normal" --auto-paginate

# Limit results
dd-cli --from 1h list events "*" --limit 100

# Extract event titles with jq
dd-cli --from 1h list events "*" | jq -r '.attributes.title'

# Filter by tags and get recent changes
dd-cli --from 6h list events "tags:deployment" | \
  jq -r '[.attributes.timestamp, .attributes.title] | @tsv'
```

**Options:**
- `FILTER`: Event filter query (default: `*`)
- `-n, --limit`: Max total events (default: 1000 without `--auto-paginate`, unlimited with)
- `--page-size`: Events per API request (default: 1000, max: 1000)
- `-s, --sort`: Sort order (default: `-timestamp`)
- `--auto-paginate`: Fetch multiple pages automatically

**Output Format:** Newline-delimited JSON (NDJSON) - one event per line.

**Query Syntax:** Datadog event search syntax:
- `*` - all events (default)
- `priority:normal` or `priority:low` - filter by priority
- `source:my_apps` - filter by source
- `tags:env:prod` - filter by tags
- `alert_type:error` - filter by alert type (error, warning, info, success)
- `host:hostname` - events for specific host
- Date filters like `2024-01-15` for events on a specific date

### get event

Retrieve a specific event by ID:

```bash
# Get event details
dd-cli get event "abc123xyz"

# Format with jq
dd-cli get event "8507301089841695052" | jq '.data.attributes | {title, text, tags, timestamp}'
```

### list monitors

List alerting monitors with optional filtering:

```bash
# List all monitors
dd-cli list monitors

# Filter monitors by name/query
dd-cli list monitors "web"

# Limit results
dd-cli list monitors --limit 20

# Filter and limit
dd-cli list monitors "database" --limit 10

# Extract monitor names and types
dd-cli list monitors | jq -r '.[] | "\(.id): \(.name) (\(.type))"'

# Find critical monitors
dd-cli list monitors | jq -r '.[] | select(.overall_state == "Alert") | {id, name, state: .overall_state}'
```

**Options:**
- `QUERY`: Optional monitor filter query (searches monitor names and tags)
- `--limit`: Maximum number of monitors to return

**Output:** JSON array of monitor objects with full configuration.

### get monitor

Retrieve a specific monitor by ID:

```bash
# Get monitor configuration
dd-cli get monitor "12345678"

# Extract monitor details
dd-cli get monitor "12345678" | jq '{name, type, query, message, tags}'
```

### list downtimes

List scheduled downtimes:

```bash
# List all downtimes
dd-cli list downtimes

# Show only currently active downtimes
dd-cli list downtimes --active

# Limit results
dd-cli list downtimes --limit 50

# Show active downtimes with details
dd-cli list downtimes --active | \
  jq -r '.[] | "\(.id): \(.message) (ends: \(.end | todate))"'

# Find downtimes for specific scope
dd-cli list downtimes | jq -r '.[] | select(.scope[] | contains("env:prod"))'
```

**Options:**
- `--active`: Show only currently active downtimes
- `--limit`: Maximum number of downtimes to return

**Output:** JSON array of downtime objects with schedules and scopes.

### get downtime

Retrieve a specific downtime by ID:

```bash
# Get downtime details
dd-cli get downtime "987654"

# Show downtime scope and schedule
dd-cli get downtime "987654" | jq '{id, scope, start: .start | todate, end: .end | todate, message}'
```

**Common Use Cases:**
```bash
# Monitor recent deployment events
dd-cli --from 1h list events "source:deployment tags:env:prod" | \
  jq -r '.attributes | [.timestamp, .title, .text] | @tsv'

# Check for error events
dd-cli --from 6h list events "alert_type:error" --auto-paginate | \
  jq -r '.attributes.title' | sort | uniq -c | sort -rn

# Find all alerting monitors
dd-cli list monitors | jq -r '.[] | select(.overall_state == "Alert") | .name'

# List active downtimes affecting production
dd-cli list downtimes --active | \
  jq -r '.[] | select(.scope[] | contains("env:prod")) | {id, message, scope}'

# Event timeline for troubleshooting
dd-cli --from 24h list events "*" --auto-paginate | \
  jq -r '.attributes | [.timestamp, .alert_type, .title] | @tsv' | \
  sort
```

## Incident Management and Cases

### list incidents

List incidents with optional state filtering:

```bash
# All incidents
dd-cli list incidents

# Active incidents only
dd-cli list incidents --state active

# With time range
dd-cli --from 1d list incidents --state active

# Extract titles
dd-cli list incidents | jq -r '.data[] | "\(.id): \(.attributes.title)"'
```

**Options:**
- `--state`: Filter by state (active, stable, resolved)
- `--limit`: Max incidents to return

### get incident

Retrieve a specific incident by ID:

```bash
dd-cli get incident "abc-123"
dd-cli get incident "abc-123" | jq '.data.attributes | {title, status, created}'
```

### list cases

List cases in the Case Management system:

```bash
# All open cases
dd-cli list cases --state open

# High-priority open cases
dd-cli list cases --state open --priority P1

# Search by keyword
dd-cli list cases "database" --limit 20

# Extract case summaries
dd-cli list cases | jq -r '.data[] | "\(.id): [\(.attributes.priority)] \(.attributes.title)"'
```

**Options:**
- `QUERY`: Optional keyword search (positional)
- `--state`: Filter by state
- `--priority`: Filter by priority (P1, P2, P3, P4, P5)
- `--limit`: Max cases to return

### get case

Retrieve a specific case by ID:

```bash
dd-cli get case "12345"
dd-cli get case "12345" | jq '.data.attributes | {title, state, priority}'
```

## Dashboards and Notebooks

### list dashboards

List dashboards with optional name filtering:

```bash
# All dashboards
dd-cli list dashboards

# Filter by name
dd-cli list dashboards "production"

# Extract IDs and titles
dd-cli list dashboards | jq -r '.dashboards[] | "\(.id): \(.title)"'
```

**Options:**
- `FILTER`: Optional name filter (positional)
- `--limit`: Max dashboards to return

### get dashboard

Retrieve a specific dashboard by ID:

```bash
dd-cli get dashboard "abc-123-def"
dd-cli get dashboard "abc-123-def" | jq '{title, widgets: (.widgets | length)}'
```

### list notebooks

List notebooks with optional text search:

```bash
# All notebooks
dd-cli list notebooks

# Search by name
dd-cli list notebooks "runbook"

# Extract names
dd-cli list notebooks | jq -r '.data[] | "\(.id): \(.attributes.name)"'
```

**Options:**
- `FILTER`: Optional text search (positional)
- `--limit`: Max notebooks to return

### get notebook

Retrieve a specific notebook by ID:

```bash
dd-cli get notebook "12345"
```

## Synthetics

### list synthetics

List Synthetic tests:

```bash
# All tests
dd-cli list synthetics

# Filter by name
dd-cli list synthetics "checkout"

# Show test IDs and status
dd-cli list synthetics | jq -r '.tests[] | "\(.public_id): \(.name) (\(.status))"'
```

**Options:**
- `FILTER`: Optional text filter (positional)
- `--limit`: Max tests to return

### get synthetic

Retrieve a specific Synthetic test by public ID:

```bash
dd-cli get synthetic "abc-def-ghi"
dd-cli get synthetic "abc-def-ghi" | jq '{name, type, status}'
```

## Real User Monitoring

### list rum

Search and retrieve RUM events with automatic pagination:

```bash
# All RUM events from last hour
dd-cli --from 1h list rum

# Filter by service
dd-cli --from 1h list rum --service web

# Search with query
dd-cli --from 1h list rum "session.type:user"

# Filter by service and query
dd-cli --from 1h list rum "action.type:click" --service checkout

# Auto-paginate to get more events
dd-cli --from 1h list rum --auto-paginate --limit 5000

# Extract session IDs
dd-cli --from 1h list rum | jq -r '.attributes.session.id // empty'
```

**Options:**
- `FILTER`: RUM search query (default: `*`)
- `--service`: Filter by service name
- `-n, --limit`: Max events (default: 1000 without `--auto-paginate`, unlimited with)
- `--page-size`: Events per API request (default: 1000, max: 1000)
- `-s, --sort`: Sort order (default: `-timestamp`)
- `--auto-paginate`: Fetch multiple pages automatically

**Output Format:** Newline-delimited JSON (NDJSON) — one event per line.

**Note:** Requires RUM to be configured for your application.

## Security Monitoring

### list signals

Search security monitoring signals:

```bash
# All signals from last hour
dd-cli --from 1h list signals

# Filter by rule
dd-cli --from 1h list signals "rule:brute_force"

# High severity signals
dd-cli --from 1h list signals "severity:high"

# Extract signal summaries
dd-cli --from 1h list signals | jq -r '.data[] | "\(.id): [\(.attributes.severity)] \(.attributes.message)"'
```

**Options:**
- `FILTER`: Signal search query (default: `*`)
- `--limit`: Max signals to return (default: 1000)

### get signal

Retrieve a specific security signal by ID:

```bash
dd-cli get signal "AQAAAYmLbW5zFHh4BAAAAAABAA..."
dd-cli get signal "<ID>" | jq '.data.attributes | {message, status, severity}'
```

### list findings

List Security Posture Management findings:

```bash
# All findings
dd-cli list findings

# Filter by tag
dd-cli list findings "env:prod"

# Extract finding details
dd-cli list findings | jq -r '.data[] | "\(.id): \(.attributes.rule.name)"'
```

**Options:**
- `FILTER`: Tag filter (positional)
- `--limit`: Max findings to return

**Note:** Requires Cloud Security Posture Management (CSPM) to be enabled.

### get finding

Retrieve a specific finding by ID:

```bash
dd-cli get finding "<FINDING_ID>"
dd-cli get finding "<FINDING_ID>" | jq '.data.attributes | {rule, status, resource_type}'
```

## Error Tracking

### list errors

List Error Tracking issues:

```bash
# All issues
dd-cli list errors

# Filter by service
dd-cli list errors --service api

# Search by message text
dd-cli list errors "NullPointerException"

# Filter service + search
dd-cli list errors "timeout" --service checkout

# Extract error summaries
dd-cli list errors | jq -r '.data[] | "\(.id): \(.attributes.message)"'
```

**Options:**
- `FILTER`: Search query (positional)
- `--service`: Filter by service name
- `--limit`: Max issues to return

**Note:** Requires Error Tracking to be configured.

### get error

Retrieve a specific Error Tracking issue by ID:

```bash
dd-cli get error "<ISSUE_ID>"
dd-cli get error "<ISSUE_ID>" | jq '.data.attributes | {message, service, status}'
```

## CI Visibility

### list pipelines

List CI pipeline events:

```bash
# Pipeline events from last day
dd-cli --from 1d list pipelines

# Filter by pipeline name
dd-cli --from 1d list pipelines --service my-pipeline

# Search by text
dd-cli --from 1d list pipelines "deploy"

# Extract pipeline results
dd-cli --from 1d list pipelines | jq -r '.data[] | "\(.attributes.pipeline_name): \(.attributes.status)"'
```

**Options:**
- `FILTER`: Search query (positional)
- `--service`: Filter by pipeline/service name
- `--limit`: Max events to return

**Note:** Requires CI Visibility to be configured.

### get pipeline-event

Retrieve a specific pipeline event by ID:

```bash
dd-cli get pipeline-event "<EVENT_ID>"
```

### list tests

List CI test events:

```bash
# Test events from last day
dd-cli --from 1d list tests

# Filter by test suite/service
dd-cli --from 1d list tests --service my-suite

# Find failing tests
dd-cli --from 1d list tests "status:fail"

# Extract test results
dd-cli --from 1d list tests | jq -r '.data[] | "\(.attributes.test_name): \(.attributes.status)"'
```

**Options:**
- `FILTER`: Search query (positional)
- `--service`: Filter by test service/suite
- `--limit`: Max events to return

### get test-event

Retrieve a specific test event by ID:

```bash
dd-cli get test-event "<EVENT_ID>"
```

## Network Device Monitoring

### list devices

List monitored network devices:

```bash
# All devices
dd-cli list devices

# Search by name or type
dd-cli list devices "router"

# Extract device details
dd-cli list devices | jq -r '.data[] | "\(.id): \(.attributes.name) (\(.attributes.ip_address))"'
```

**Options:**
- `FILTER`: Query string (positional)
- `--limit`: Max devices to return

### get device

Retrieve a specific network device by ID:

```bash
dd-cli get device "<DEVICE_ID>"
dd-cli get device "<DEVICE_ID>" | jq '.data.attributes | {name, ip_address, tags}'
```

## Service Catalog

### list dependencies

List service catalog relations (dependencies between services):

```bash
# All relations
dd-cli list dependencies

# Dependencies of a specific service
dd-cli list dependencies "checkout-service"

# Extract upstream/downstream services
dd-cli list dependencies "api-gateway" | jq -r '.data[] | "\(.attributes.from) → \(.attributes.to) (\(.attributes.type))"'
```

**Options:**
- `SERVICE`: Source service to filter by (positional)
- `--limit`: Max relations to return

### raw

Direct API access with full control:

```bash
# GET request
dd-cli raw --path /api/v1/validate

# With query string (you handle encoding)
dd-cli raw --path /api/v1/hosts --query "filter=env%3Aprod&count=10"

# POST with body
dd-cli raw --path /api/v1/series \
  --method POST \
  --header "Content-Type:application/json" \
  --data '{"series":[{"metric":"test.metric","points":[[1707955200,1]]}]}'

# Custom headers
dd-cli raw --path /api/v1/validate \
  --header "X-Custom:Value1" \
  --header "Authorization:Bearer token"
```

**Options:**
- `-p, --path`: API endpoint path (required)
- `-X, --method`: HTTP method (default: GET)
- `-q, --query`: Query string (not URL-encoded)
- `-H, --header`: Custom headers (repeatable)
- `--data`: Request body

**Note:** The `raw` command does not encode query strings or apply global date flags. Use it when you need precise control.

## Global Flags

Available for all commands:

- `--domain, -d`: Override Datadog site (datadoghq.eu, us3.datadoghq.com, etc.)
- `--from`: Start time ("now", relative like "1h", or ISO 8601 like "2024-01-15T10:00:00Z")
- `--to`: End time (same formats as --from; defaults to "now" if not specified)
- `--verbose, -v`: Print each request URL to stderr before executing

**Domain priority:** `--domain` flag > `DD_SITE` env > `datadoghq.com`

## Examples

```bash
# Quick validation
dd-cli validate

# Production hosts from last 24 hours
dd-cli --from $(date -u -v-24H +%Y-%m-%dT%H:%M:%SZ) list hosts "env:prod"

# Get host details
dd-cli get host "web-server-01"

# Custom API query with jq
dd-cli list hosts "env:prod" | jq '.host_list[] | {name: .name, up: .up}'

# Search logs from the last hour
dd-cli --from $(date -u -v-1H +%Y-%m-%dT%H:%M:%SZ) \
  list logs "service:web AND status:error"

# Monitor logs in real-time with grep
dd-cli list logs "service:api" --auto-paginate | grep -i "timeout"

# Extract error messages from logs
dd-cli list logs "status:error" --limit 100 | \
  jq -r '.attributes.message' | sort | uniq -c | sort -rn

# List APM services
dd-cli --from 1h list services --env prod

# Find slow spans
dd-cli --from 1h list spans --service web --limit 1000 | \
  jq -r '.attributes | select(.duration > 1000000000) | [.service, .operation, .duration] | @tsv'

# Get error rate by service
dd-cli --from 1h aggregate spans \
  --compute 'count:*' \
  --group-by service \
  "error"

# Analyze operation performance
dd-cli --from 1h aggregate spans \
  --compute 'avg:@duration' \
  --compute 'pc95:@duration' \
  --compute 'pc99:@duration' \
  --group-by operation \
  --service web

# Check recent deployment events
dd-cli --from 1h list events "source:deployment tags:env:prod"

# Find alerting monitors
dd-cli list monitors | jq -r '.[] | select(.overall_state == "Alert") | .name'

# List active downtimes
dd-cli list downtimes --active

# Get specific event details
dd-cli get event "8507301089841695052"

# Get monitor configuration
dd-cli get monitor "12345678"

# List containers in production
dd-cli --from 1h list containers --tags "env:prod"

# Find processes by name
dd-cli list processes --search "nginx"

# Analyze network connections
dd-cli --from 1h aggregate connections --group-by destination_ip

# DNS query analysis
dd-cli --from 1h aggregate dns --group-by query_name

# Post metrics
dd-cli raw --path /api/v1/series \
  --method POST \
  --header "Content-Type:application/json" \
  --data '{
    "series": [{
      "metric": "custom.metric",
      "points": [['"$(date +%s)"', 42]],
      "tags": ["env:prod"]
    }]
  }'
```

## Development

```bash
# Build
zig build

# Run tests
zig build test --summary all

# Run directly
zig build run -- validate
```

### Code organization

```
src/
├── main.zig        # Entry point: CLI argument setup and subcommand dispatch
├── common.zig      # Shared types, time parsing, URL building, HTTP client,
│                   # JSON utilities, auth context, and streaming helpers
├── auth.zig        # OAuth2 PKCE login/logout and token storage
├── list.zig        # list verb: logs, spans, hosts, metrics, APIs, services,
│                   # monitors, downtimes, containers, processes, rum, incidents,
│                   # cases, dashboards, notebooks, synthetics, devices,
│                   # signals, findings, errors, pipelines, tests, dependencies
├── aggregate.zig   # aggregate verb: logs, metrics, spans, connections, DNS
├── get.zig         # get verb: events, monitors, downtimes, hosts, metrics,
│                   # APIs, incidents, notebooks, errors, devices, cases,
│                   # dashboards, synthetics, signals, findings,
│                   # pipeline-event, test-event
├── validate.zig    # validate verb: credential check handler
├── raw.zig         # raw verb: direct HTTP request handler
└── api/
    ├── datadog_v1.zig  # Datadog v1 API type definitions
    └── datadog_v2.zig  # Datadog v2 API type definitions
```

## Requirements

- Zig 0.16.0 or later

## API Reference

- [Datadog API Documentation](https://docs.datadoghq.com/api/)
- [Hosts API](https://docs.datadoghq.com/api/latest/hosts/)
- [Logs API](https://docs.datadoghq.com/api/latest/logs/)
- [Log Search Syntax](https://docs.datadoghq.com/logs/explorer/search_syntax/)
- [APM API](https://docs.datadoghq.com/api/latest/apm/)
- [Spans API](https://docs.datadoghq.com/api/latest/spans/)
- [Events API](https://docs.datadoghq.com/api/latest/events/)
- [Monitors API](https://docs.datadoghq.com/api/latest/monitors/)
- [Downtimes API](https://docs.datadoghq.com/api/latest/downtimes/)
- [Containers API](https://docs.datadoghq.com/api/latest/containers/)
- [Processes API](https://docs.datadoghq.com/api/latest/processes/)
- [Network Performance Monitoring API](https://docs.datadoghq.com/api/latest/network-device-monitoring/)
- [Authentication](https://docs.datadoghq.com/api/latest/authentication/)

## License

BSD 3-Clause License - see [LICENSE](LICENSE) file.
