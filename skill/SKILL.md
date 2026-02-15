---
name: datadog
description: Query Datadog metrics and logs using the Datadog API. Use this skill when users want to check infrastructure metrics, query application logs, view error logs, list active hosts, search for available metrics, or monitor Kubernetes/Docker resources. Also use when users want to validate Datadog API credentials or check infrastructure health via Datadog.
---

# Datadog Query Skill

This skill enables querying Datadog metrics and logs via the Datadog API.

## Prerequisites

**Required CLI tool:**
- `dd-cli` (Datadog API client CLI)
- Verify installation: `dd-cli --version`

**Required environment variables** (prompt user if not set):
- `DD_API_KEY`: Datadog API key
- `DD_APPLICATION_KEY`: Datadog Application key
- `DD_SITE`: Datadog site (default: `datadoghq.com` if not set)

## Quick Start

### 0. Check Environment Variables (Without Exposing Keys)

```bash
# Safely check if variables are set without displaying the keys
echo "DD_API_KEY: ${DD_API_KEY:+set}" && echo "DD_APPLICATION_KEY: ${DD_APPLICATION_KEY:+set}" && echo "DD_SITE: ${DD_SITE:-datadoghq.com}"
```

Expected output if properly configured:
```
DD_API_KEY: set
DD_APPLICATION_KEY: set
DD_SITE: datadoghq.com
```

If any variable shows empty instead of "set", you need to export it.

### 1. Validate API Access

```bash
dd-cli validate | jq .
```

Expected response: `{"valid": true}`

### 2. Query Metrics

Get time-series data for the specified time range (Unix timestamps):

```bash
# Set time range (last hour by default)
FROM=$(date -u -v-1H +%s 2>/dev/null || date -u -d '1 hour ago' +%s)
TO=$(date -u +%s)

# Query metric (URL encode the query parameter)
QUERY=$(printf '%s' "avg:system.cpu.user{*}" | jq -sRr @uri)
dd-cli raw GET "/api/v1/query?from=${FROM}&to=${TO}&query=${QUERY}" | jq .
```

**Common metric queries:**
- `avg:system.cpu.user{*}` - CPU usage across all hosts (0-100%)
- `avg:system.mem.used{*}` - Memory usage (bytes)
- `avg:system.disk.used{*}` - Disk usage (bytes)
- `avg:system.load.1{*}` - 1-minute load average
- `avg:kubernetes.cpu.usage.total{*}` - Kubernetes CPU (nanocores)
- `avg:kubernetes.memory.usage{*}` - Kubernetes memory (bytes)
- `avg:docker.cpu.usage{*}` - Docker container CPU

**Tag filters:**
- `{env:production}` - Filter by environment
- `{project:violet}` - Filter by project
- `{kube_namespace:default}` - Filter by K8s namespace
- `{host:hostname}` - Filter by specific host
- `{pod_name:mypod}` - Filter by pod name

**Aggregations:**
- `avg:metric{*}` - Average across all
- `sum:metric{*}` - Sum across all
- `max:metric{*}` / `min:metric{*}` - Max/min values
- `avg:metric{*}by{host}` - Average per host
- `avg:metric{*}by{kube_namespace}` - Average per namespace
- `avg:metric{*}by{pod_name}` - Average per pod

**Rollup functions (for time windows):**
- `.rollup(avg, 300)` - 5-minute average windows
- `.rollup(avg, 900)` - 15-minute average windows
- `.rollup(max, 3600)` - 1-hour maximum windows
- Example: `avg:system.cpu.user{*}by{host}.rollup(avg,900)`

### 3. Query Logs

Search logs with time range (ISO 8601 format):

```bash
# Set time range (last 15 minutes by default)
FROM=$(date -u -v-15M +%Y-%m-%dT%H:%M:%S.000Z 2>/dev/null || date -u -d '15 minutes ago' +%Y-%m-%dT%H:%M:%S.000Z)
TO=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)

# Query logs (basic JSON output)
dd-cli --from "${FROM}" --to "${TO}" logs search -q "*" -n 10 | jq .
```

**Better formatted output with summary:**
```bash
# Get logs with a formatted summary
FROM=$(date -u -v-1H +%Y-%m-%dT%H:%M:%S.000Z 2>/dev/null || date -u -d '1 hour ago' +%Y-%m-%dT%H:%M:%S.000Z)
TO=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)

dd-cli --from "${FROM}" --to "${TO}" logs search -q "service:myapp" -n 50 | jq -r '
"=== LOG SUMMARY ===\n" +
"Total entries: \(.data | length)\n" +
"Time range: Last hour\n" +
"\n=== LOG TYPES ===\n" +
(.data | group_by(.attributes.status) | .[] |
  "\(. | length) \(.[0].attributes.status) messages") +
"\n\n=== RECENT ERRORS (if any) ===\n" +
(.data | map(select(.attributes.status == "error" or .attributes.status == "warning")) | .[:5] | .[] |
  "[\(.attributes.timestamp)] [\(.attributes.status | ascii_upcase)] \(.attributes.host // "no-host")\n  \(.attributes.message[:150])...\n"
)'
```

**Common log queries:**
- `*` - All logs
- `status:error` - Error logs only
- `status:warn OR status:error` - Warnings and errors
- `env:production` - Logs from production environment
- `service:myapp` - Logs from specific service
- `host:*toolbox*` - Logs from hosts matching pattern
- `kube_namespace:default` - Logs from K8s namespace
- `@http.status_code:>=400` - HTTP errors (4xx/5xx)

**Limit and pagination:**
- Use `-n` to control results (default: 1000 without `--auto-paginate`, unlimited with)
- Use `--auto-paginate` to fetch all matching logs across multiple pages
- Use `--page-size` to control logs per API request (max: 1000)

### 4. List Hosts

Get active infrastructure hosts:

```bash
FROM=$(date -u -v-1H +%Y-%m-%dT%H:%M:%S.000Z 2>/dev/null || date -u -d '1 hour ago' +%Y-%m-%dT%H:%M:%S.000Z)

dd-cli --from "${FROM}" host list | jq .
```

**Filter by tags:**
```bash
dd-cli --from "${FROM}" host list "env:production" | jq .
```

### 5. Search Metrics

Find available metrics by pattern:

```bash
# Search for Kubernetes metrics
QUERY=$(printf '%s' "metrics:kubernetes" | jq -sRr @uri)
dd-cli raw GET "/api/v1/search?q=${QUERY}" | jq .

# Search for system metrics
QUERY=$(printf '%s' "metrics:system" | jq -sRr @uri)
dd-cli raw GET "/api/v1/search?q=${QUERY}" | jq .
```

### 6. List Monitors

View all configured monitors:

```bash
dd-cli raw GET /api/v1/monitor | jq .
```

### 7. List Dashboards

View all configured dashboards:

```bash
dd-cli raw GET /api/v1/dashboard | jq .
```

## Common Workflows

### Check Infrastructure Health

```bash
# 1. Validate credentials
dd-cli validate | jq -r '.valid // "Authentication failed"'

# 2. List active hosts
FROM=$(date -u -v-1H +%Y-%m-%dT%H:%M:%S.000Z 2>/dev/null || date -u -d '1 hour ago' +%Y-%m-%dT%H:%M:%S.000Z)
dd-cli --from "${FROM}" host list | jq '.host_list[] | {name: .name, up: .up, tags: .tags_by_source}'

# 3. Check recent errors
FROM=$(date -u -v-15M +%Y-%m-%dT%H:%M:%S.000Z 2>/dev/null || date -u -d '15 minutes ago' +%Y-%m-%dT%H:%M:%S.000Z)
TO=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)
dd-cli --from "${FROM}" --to "${TO}" logs search -q "status:error" -n 10 | jq '.data[] | {timestamp: .attributes.timestamp, status: .attributes.status, message: .attributes.message}'
```

### Monitor System Metrics with Statistics

```bash
# CPU usage by host with min/avg/max/current
FROM=$(date -u -v-1H +%s 2>/dev/null || date -u -d '1 hour ago' +%s)
TO=$(date -u +%s)

echo -e "=== SYSTEM METRICS SUMMARY (Last Hour) ===\n"
echo -e "CPU Usage by Host:\nHost\tMin%\tAvg%\tMax%\tCurrent%"
QUERY=$(printf '%s' "avg:system.cpu.user{*}by{host}" | jq -sRr @uri)
dd-cli raw GET "/api/v1/query?from=${FROM}&to=${TO}&query=${QUERY}" | jq -r '.series[]? | select(.pointlist | length > 0) | {host: .scope, points: .pointlist | map(.[1] // 0)} | {host: .host, min: (.points | min), avg: (.points | add / length), max: (.points | max), current: .points[-1]} | "\(.host)\t\(.min | floor)\t\(.avg | floor)\t\(.max | floor)\t\(.current | floor)"' | column -t -s $'\t'
```

### Monitor Kubernetes Resources with Percentiles

```bash
FROM=$(date -u -v-30M +%s 2>/dev/null || date -u -d '30 minutes ago' +%s)
TO=$(date -u +%s)

# Top K8s pods by CPU (millicores) - filtered and sorted
echo -e "=== TOP KUBERNETES PODS BY CPU (Last 30 min) ===\nPod\tMin(m)\tAvg(m)\tMax(m)\tCurrent(m)"
QUERY=$(printf '%s' "avg:kubernetes.cpu.usage.total{*}by{pod_name}" | jq -sRr @uri)
dd-cli raw GET "/api/v1/query?from=${FROM}&to=${TO}&query=${QUERY}" | jq -r '.series[]? | select(.pointlist | length > 0) | {pod: (.scope | sub("pod_name:"; "")), points: .pointlist | map((.[1] // 0) / 1000000)} | {pod: .pod, min: (.points | min), avg: (.points | add / length), max: (.points | max), current: .points[-1]} | select(.avg > 10) | "\(.pod)\t\(.min | floor)\t\(.avg | floor)\t\(.max | floor)\t\(.current | floor)"' | sort -t$'\t' -k3 -rn | column -t -s $'\t' | head -20

# Memory usage by pod (MB)
echo -e "\n=== KUBERNETES POD MEMORY (Last 30 min) ===\nPod\tMin(MB)\tAvg(MB)\tMax(MB)"
QUERY=$(printf '%s' "avg:kubernetes.memory.usage{*}by{pod_name}" | jq -sRr @uri)
dd-cli raw GET "/api/v1/query?from=${FROM}&to=${TO}&query=${QUERY}" | jq -r '.series[]? | select(.pointlist | length > 0) | {pod: (.scope | sub("pod_name:"; "")), points: .pointlist | map((.[1] // 0) / 1048576)} | {pod: .pod, min: (.points | min), avg: (.points | add / length), max: (.points | max)} | "\(.pod)\t\(.min | floor)\t\(.avg | floor)\t\(.max | floor)"' | sort -t$'\t' -k3 -rn | column -t -s $'\t' | head -15
```

### Analyze Resource Usage by Namespace

```bash
FROM=$(date -u -v-1H +%s 2>/dev/null || date -u -d '1 hour ago' +%s)
TO=$(date -u +%s)

# CPU usage aggregated by namespace
echo -e "=== POD CPU BY NAMESPACE (Last Hour) ===\nNamespace\tMin(m)\tAvg(m)\tMax(m)"
QUERY=$(printf '%s' "sum:kubernetes.cpu.usage.total{*}by{kube_namespace}" | jq -sRr @uri)
dd-cli raw GET "/api/v1/query?from=${FROM}&to=${TO}&query=${QUERY}" | jq -r '.series[]? | select(.pointlist | length > 0) | {ns: (.scope | sub("kube_namespace:"; "")), points: .pointlist | map((.[1] // 0) / 1000000)} | {ns: .ns, min: (.points | min), avg: (.points | add / length), max: (.points | max)} | "\(.ns)\t\(.min | floor)\t\(.avg | floor)\t\(.max | floor)"' | sort -t$'\t' -k3 -rn | column -t -s $'\t'
```

### System Load with Percentiles

```bash
FROM=$(date -u -v-1H +%s 2>/dev/null || date -u -d '1 hour ago' +%s)
TO=$(date -u +%s)

# System load (1-min avg) with p95/p99
echo -e "=== SYSTEM LOAD (1-min avg) BY HOST ===\nHost\tMin\tAvg\tMax\tP95\tP99"
QUERY=$(printf '%s' "avg:system.load.1{*}by{host}" | jq -sRr @uri)
dd-cli raw GET "/api/v1/query?from=${FROM}&to=${TO}&query=${QUERY}" | jq -r '.series[]? | select(.pointlist | length > 0) | {host: (.scope | sub("host:"; "")), points: (.pointlist | map(.[1] // 0) | sort)} | {host: .host, min: (.points | min), avg: (.points | add / length), max: (.points | max), p95: .points[((.points | length) * 0.95) | floor], p99: .points[((.points | length) * 0.99) | floor]} | "\(.host)\t\(.min | . * 100 | floor / 100)\t\(.avg | . * 100 | floor / 100)\t\(.max | . * 100 | floor / 100)\t\(.p95 | . * 100 | floor / 100)\t\(.p99 | . * 100 | floor / 100)"' | column -t -s $'\t'
```

### Long-term Trends with Rollup

```bash
# 6-hour CPU trend with 15-minute windows
FROM=$(date -u -v-6H +%s 2>/dev/null || date -u -d '6 hours ago' +%s)
TO=$(date -u +%s)

echo -e "=== KUBERNETES NODE CPU (6h, 15min rollup) ===\nNode\tMin%\tAvg%\tMax%"
QUERY=$(printf '%s' "avg:kubernetes.cpu.usage.total{kube_cluster_name:*}by{host}.rollup(avg,900)" | jq -sRr @uri)
dd-cli raw GET "/api/v1/query?from=${FROM}&to=${TO}&query=${QUERY}" | jq -r '.series[]? | select(.pointlist | length > 0) | {node: (.scope | sub("host:"; "")), points: .pointlist | map((.[1] // 0) / 1000000)} | {node: .node, min: (.points | min), avg: (.points | add / length), max: (.points | max)} | "\(.node)\t\(.min | floor)\t\(.avg | floor)\t\(.max | floor)"' | column -t -s $'\t'
```

### Debug Application Issues

```bash
# 1. Find error patterns
FROM=$(date -u -v-1H +%Y-%m-%dT%H:%M:%S.000Z 2>/dev/null || date -u -d '1 hour ago' +%Y-%m-%dT%H:%M:%S.000Z)
TO=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)

dd-cli --from "${FROM}" --to "${TO}" logs search -q "status:error service:myapp" -n 50 | jq '.data[] | {time: .attributes.timestamp, host: .attributes.host, message: .attributes.message}'

# 2. Check service metrics
FROM=$(date -u -v-1H +%s 2>/dev/null || date -u -d '1 hour ago' +%s)
TO=$(date -u +%s)

QUERY=$(printf '%s' "avg:trace.http.request.duration{service:myapp}" | jq -sRr @uri)
dd-cli raw GET "/api/v1/query?from=${FROM}&to=${TO}&query=${QUERY}" | jq '.series[0].pointlist[-10:]'
```

### Analyze Log Distribution Across Infrastructure

```bash
# Get comprehensive log distribution summary
FROM=$(date -u -v-30M +%Y-%m-%dT%H:%M:%S.000Z 2>/dev/null || date -u -d '30 minutes ago' +%Y-%m-%dT%H:%M:%S.000Z)
TO=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)

dd-cli --from "${FROM}" --to "${TO}" logs search -q "*" -n 100 | jq -r '"=== LOG SUMMARY (Last 30 min) ===", "Total logs: \(.data | length)", "", "=== TOP SERVICES ===", (.data | group_by(.attributes.service) | map({service: .[0].attributes.service, count: length}) | sort_by(-.count) | .[0:10] | .[] | "  \(.count)\t\(.service)"), "", "=== TOP HOSTS ===", (.data | group_by(.attributes.host) | map({host: .[0].attributes.host, count: length}) | sort_by(-.count) | .[0:5] | .[] | "  \(.count)\t\(.host)")'
```

### Analyze Kubernetes Errors by Namespace

```bash
# Find and group K8s errors by namespace
FROM=$(date -u -v-1H +%Y-%m-%dT%H:%M:%S.000Z 2>/dev/null || date -u -d '1 hour ago' +%Y-%m-%dT%H:%M:%S.000Z)
TO=$(date -u +%Y-%m-%dT%H:%M:%S.000Z)

dd-cli --from "${FROM}" --to "${TO}" logs search -q "status:error OR status:warning kube_namespace:*" -n 50 | jq -r '"=== ERRORS & WARNINGS (Last Hour) ===", "Total: \(.data | length)", "", "=== BY NAMESPACE ===", (.data | group_by(.attributes.tags[] | select(startswith("kube_namespace:")) | split(":")[1]) | map({namespace: (.[0].attributes.tags[] | select(startswith("kube_namespace:")) | split(":")[1]), count: length}) | sort_by(-.count) | .[] | "  \(.count)\t\(.namespace)"), "", "=== RECENT ERRORS ===", (.data | .[0:5] | .[] | "[\(.attributes.timestamp)] \(.attributes.service // "no-service") on \(.attributes.host // "no-host")", "  Status: \(.attributes.status)", "  Message: \(.attributes.message[:120])...", "---")'
```

## Advanced jq Filters for Metrics

These jq filters help process metric query results into statistical summaries:

### Basic Statistics (Min/Avg/Max/Current)

```bash
# CPU usage by host with statistics
jq -r '.series[]? | select(.pointlist | length > 0) | {host: (.scope | sub("host:"; "")), points: .pointlist | map(.[1] // 0)} | {host: .host, min: (.points | min), avg: (.points | add / length), max: (.points | max), current: .points[-1]} | "\(.host)\t\(.min | floor)\t\(.avg | floor)\t\(.max | floor)\t\(.current | floor)"' | column -t -s $'\t'
```

### Unit Conversions

```bash
# Convert bytes to GB
jq -r '.series[]? | {host: .scope, points: .pointlist | map((.[1] // 0) / 1073741824)}'

# Convert bytes to MB
jq -r '.series[]? | {host: .scope, points: .pointlist | map((.[1] // 0) / 1048576)}'

# Convert nanocores to millicores (for K8s CPU)
jq -r '.series[]? | {pod: .scope, points: .pointlist | map((.[1] // 0) / 1000000)}'
```

### Calculate Percentiles

```bash
# Calculate p95 and p99 from time series
jq -r '.series[]? | select(.pointlist | length > 0) | {host: .scope, points: (.pointlist | map(.[1] // 0) | sort)} | {host: .host, p95: .points[((.points | length) * 0.95) | floor], p99: .points[((.points | length) * 0.99) | floor]} | "\(.host)\t\(.p95 | floor)\t\(.p99 | floor)"'
```

### Filter and Sort by Value

```bash
# Filter metrics above threshold and sort by average descending
jq -r '.series[]? | select(.pointlist | length > 0) | {name: .scope, avg: (.pointlist | map(.[1] // 0) | add / length)} | select(.avg > 100) | "\(.avg | floor)\t\(.name)"' | sort -rn

# Top N metrics by current value
jq -r '.series[]? | {name: .scope, current: .pointlist[-1][1]} | "\(.current | floor)\t\(.name)"' | sort -rn | head -10
```

### Complete Summary Table

```bash
# Full statistics table with formatting
jq -r '"Host\tMin%\tAvg%\tMax%\tCurrent%", ("-" * 80), (.series[]? | select(.pointlist | length > 0) | {host: (.scope | sub("host:"; "")), points: .pointlist | map(.[1] // 0)} | {host: .host, min: (.points | min), avg: (.points | add / length), max: (.points | max), current: .points[-1]} | "\(.host)\t\(.min | floor)\t\(.avg | floor)\t\(.max | floor)\t\(.current | floor)")' | column -t -s $'\t'
```

## Advanced jq Filters for Logs

These jq filters help process log query results into useful summaries:

### Aggregate by Service and Host
```bash
# Top services by log volume
jq -r '"=== TOP SERVICES ===", (.data | group_by(.attributes.service) | map({service: .[0].attributes.service, count: length}) | sort_by(-.count) | .[0:10] | .[] | "  \(.count)\t\(.service)")'

# Top hosts by log volume
jq -r '"=== TOP HOSTS ===", (.data | group_by(.attributes.host) | map({host: .[0].attributes.host, count: length}) | sort_by(-.count) | .[0:10] | .[] | "  \(.count)\t\(.host)")'

# Combined summary
jq -r '"=== LOG SUMMARY ===", "Total logs: \(.data | length)", "", "=== TOP SERVICES ===", (.data | group_by(.attributes.service) | map({service: .[0].attributes.service, count: length}) | sort_by(-.count) | .[0:10] | .[] | "  \(.count)\t\(.service)"), "", "=== TOP HOSTS ===", (.data | group_by(.attributes.host) | map({host: .[0].attributes.host, count: length}) | sort_by(-.count) | .[0:5] | .[] | "  \(.count)\t\(.host)")'
```

### Group Errors by Kubernetes Namespace
```bash
# Errors grouped by K8s namespace
jq -r '"=== ERRORS BY NAMESPACE ===", (.data | group_by(.attributes.tags[] | select(startswith("kube_namespace:")) | split(":")[1]) | map({namespace: (.[0].attributes.tags[] | select(startswith("kube_namespace:")) | split(":")[1]), count: length}) | sort_by(-.count) | .[] | "  \(.count)\t\(.namespace)")'
```

### Find Unique Error Patterns
```bash
# Extract and count unique error message patterns
jq -r '"=== UNIQUE ERROR PATTERNS ===", (.data | [.[].attributes.message] | map(split(" ") | .[0:8] | join(" ")) | group_by(.) | map({pattern: .[0], count: length}) | sort_by(-.count) | .[0:10] | .[] | "  [\(.count)x] \(.pattern)...")'
```

### Group by Kubernetes Pods and Containers
```bash
# Logs by pod
jq -r '"=== BY POD ===", (.data | map(select(.attributes.tags // [] | map(select(startswith("pod_name:"))) | length > 0)) | group_by(.attributes.tags[] | select(startswith("pod_name:")) | split(":")[1]) | map({pod: (.[0].attributes.tags[] | select(startswith("pod_name:")) | split(":")[1]), count: length}) | sort_by(-.count) | .[0:15] | .[] | "  \(.count)\t\(.pod)")'

# Logs by container
jq -r '"=== BY CONTAINER ===", (.data | map(select(.attributes.tags // [] | map(select(startswith("container_name:"))) | length > 0)) | group_by(.attributes.tags[] | select(startswith("container_name:")) | split(":")[1]) | map({container: (.[0].attributes.tags[] | select(startswith("container_name:")) | split(":")[1]), count: length}) | sort_by(-.count) | .[0:10] | .[] | "  \(.count)\t\(.container)")'
```

### Filter and Format Specific Fields
```bash
# Extract just timestamps and messages
jq -r '.data[] | "[\(.attributes.timestamp)] \(.attributes.message)"'

# Get logs from specific service with formatted output
jq -r '.data | map(select(.attributes.service == "myapp")) | .[] | "[\(.attributes.timestamp)] [\(.attributes.status)] \(.attributes.message[:100])"'

# Count logs by status
jq -r '"=== BY STATUS ===", (.data | group_by(.attributes.status) | .[] | "  \(. | length)\t\(.[0].attributes.status)")'
```

## Tips

**General:**
- **Time ranges**: Use shorter ranges (15m-1h) for faster queries and recent data
- **Date commands**: Script handles both macOS (`-v`) and Linux (`-d`) date formats
- **Error handling**: Check HTTP status codes; 403 = auth issue, 400 = invalid query
- **Variable safety**: Use `${VAR:+set}` to check if environment variables are set without exposing the values

**Logs:**
- **Pagination**: For logs, use `page.limit` and `page.cursor` for large result sets
- **Tag filtering**: Narrow queries with tags to reduce noise and improve performance
- **jq formatting**: Pipe to `jq .` for pretty output, or use specific selectors for focused data
  - Group by status: `jq '.data | group_by(.attributes.status)'`
  - Filter errors: `jq '.data | map(select(.attributes.status == "error"))'`
  - Count logs: `jq '.data | length'`
  - Extract messages: `jq -r '.data[] | .attributes.message'`

**Metrics:**
- **Rollup windows**: Use `.rollup(avg, SECONDS)` for aggregating over time windows (300=5min, 900=15min, 3600=1hr)
- **Unit conversions**:
  - K8s CPU: nanocores → millicores (divide by 1,000,000)
  - Memory: bytes → MB (divide by 1,048,576), bytes → GB (divide by 1,073,741,824)
- **Percentiles**: Calculate from sorted pointlist: `p95 = points[(length * 0.95) | floor]`
- **Filtering**: Use `select(.avg > THRESHOLD)` to filter time series by calculated values
- **Sorting**: Pipe jq output to `sort -t$'\t' -k3 -rn` to sort by 3rd column numerically descending
- **Top N**: Combine sort with `head -N` to get top results
- **Null handling**: Always use `.[1] // 0` when accessing pointlist values to handle nulls

## Troubleshooting

**Authentication failed:**
```bash
# Check environment variables (safe - doesn't expose keys)
echo "DD_API_KEY: ${DD_API_KEY:+set}" && echo "DD_APPLICATION_KEY: ${DD_APPLICATION_KEY:+set}" && echo "DD_SITE: ${DD_SITE:-datadoghq.com}"

# If you need to see partial keys for debugging (shows first 10 chars only)
echo "DD_API_KEY: ${DD_API_KEY:0:10}..."
echo "DD_APPLICATION_KEY: ${DD_APPLICATION_KEY:0:10}..."

# Validate credentials
dd-cli validate
```

**No data returned:**
- Verify time range is recent and contains data
- Check tag filters match your infrastructure
- Try broader queries first (e.g., `{*}` instead of specific tags)
- Use metric search to verify metric names

**Query timeout:**
- Reduce time range
- Add more specific tag filters
- Lower page limit for log queries

## API Reference

- **Docs**: https://docs.datadoghq.com/api/latest/
- **Metrics API**: https://docs.datadoghq.com/api/latest/metrics/
- **Logs API**: https://docs.datadoghq.com/api/latest/logs/
- **Query syntax**: https://docs.datadoghq.com/dashboards/querying/
