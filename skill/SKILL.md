---
name: datadog
description: Query Datadog logs, metrics, and hosts using dd-cli. ONLY trigger when user mentions "Datadog" or "dd-cli" AND an observability signal (logs, metrics, hosts, errors, monitoring). Do NOT trigger on generic observability requests without Datadog context.
---

# Datadog Query Skill

Query Datadog logs, metrics, and infrastructure using the `dd-cli` command-line tool.

## Scope

This skill is for **read-only queries** of Datadog observability data.

**In scope:** Searching logs, listing hosts, querying metrics
**Out of scope:** Dashboards, alerts, monitors, configuration changes, synthetics

## When to Use This Skill

Use this skill IF AND ONLY IF the user mentions BOTH:
1. **"Datadog" or "dd-cli"** (explicit tool reference)
2. **An observability signal**: logs, metrics, hosts, errors, monitoring, traces

**Valid trigger examples:**
- "Check datadog logs for errors"
- "Show me datadog hosts in production"
- "Query datadog for service metrics"
- "Get error logs from datadog"
- "List datadog hosts that are down"

**NOT triggered by:**
- "Show me the logs" (no Datadog mentioned → check local files)
- "Check server status" (no Datadog mentioned → use host tools)
- "Monitor the application" (no Datadog mentioned → too generic)
- "Create a datadog dashboard" (out of scope)

**If ambiguous:** Ask "Are you asking about Datadog monitoring?"

## Execution Pattern

Follow this workflow for every request:

1. **Validate credentials** (once per conversation)
2. **Select appropriate command** (see decision tree)
3. **Execute via Bash tool** with proper error handling
4. **Process output** with jq
5. **Present summary** to user (not raw JSON)

## Credential Validation

Run validation ONCE at the start of each conversation:

```bash
dd-cli validate
```

**Expected output:** `{"valid":true}`

**If `{"valid":false}`:**
1. Stop execution immediately
2. Tell user: "Datadog API credentials are missing or invalid. Check DD_API_KEY and DD_APPLICATION_KEY environment variables."
3. Wait for user to fix credentials
4. Do NOT proceed with queries

**Do NOT re-validate on every command.**

**Required environment variables:**
- `DD_API_KEY` - Datadog API key
- `DD_APPLICATION_KEY` - Application key with scopes: `logs_read_data`, `hosts_read`

## Command Selection Decision Tree

Use this decision tree to select the correct command:

1. **Validate credentials?**
   → `dd-cli validate`

2. **List hosts/servers?**
   → `dd-cli --from 1h host list [filter]`

3. **Get specific host details?**
   → `dd-cli host get "<hostname>"`

4. **Search logs?**
   → `dd-cli --from <time> logs search --query "<query>" [--limit N]`

5. **Get metrics (CPU/memory)?**
   → `dd-cli raw --method GET --path "/api/v1/query" --query "..."`

If user request doesn't fit these categories, ask for clarification.

## Command Reference

### logs search

Search and retrieve log events with pagination.

**Single page (default):**
```bash
# Recent errors (fast, up to 1000 logs)
dd-cli --from 15m logs search --query "status:error" --limit 50

# Service logs from last hour
dd-cli --from 1h logs search --query "service:web"
```

**Multi-page (for >1000 logs):**
```bash
# Comprehensive search (slower, ALWAYS set --limit)
dd-cli --from 1d logs search --query "service:api" --auto-paginate --limit 5000
```

**Key options:**
- `-q, --query` - Search query (default: `*`)
- `-n, --limit` - Max logs to return (default: 1000 single page, unlimited with --auto-paginate)
- `--auto-paginate` - Fetch multiple pages (use ONLY when you need >1000 logs)
- `--page-size` - Logs per request (max: 1000)

**Output format:** Newline-delimited JSON (NDJSON) - one log per line

**Query syntax examples:**

| Pattern | Description |
|---------|-------------|
| `service:name` | Filter by service |
| `status:error` | Error logs only |
| `status:warn OR status:error` | Warnings and errors |
| `host:hostname` | Logs from specific host |
| `kube_namespace:default` | Kubernetes namespace |
| `@http.status_code:>=500` | HTTP 5xx errors |
| `*` | All logs (default) |

### host list

List active infrastructure hosts.

**Usage:**
```bash
# Active hosts in last hour (REQUIRED: --from flag)
dd-cli --from 1h host list

# Filter by environment
dd-cli --from 1h host list "env:production"

# Active hosts in last day
dd-cli --from 1d host list
```

**Note:** The `--from` flag is REQUIRED for this command.

### host get

Get details for a specific host.

**Usage:**
```bash
dd-cli host get "hostname.example.com"
```

### raw

Direct API access for metrics and advanced queries.

**Metrics query (uses Unix timestamps):**
```bash
dd-cli raw --method GET --path "/api/v1/query" \
  --query "from=<unix_start>&to=<unix_end>&query=avg%3Asystem.cpu.user%7B*%7D"
```

**Common metrics:**

| Metric | Description | Units |
|--------|-------------|-------|
| `system.cpu.user{*}` | CPU usage | 0-100% |
| `system.mem.used{*}` | Memory used | bytes |
| `system.load.1{*}` | Load average (1 min) | float |
| `kubernetes.cpu.usage.total{*}` | K8s CPU | nanocores |
| `kubernetes.memory.usage{*}` | K8s memory | bytes |

**Aggregation patterns:**
- `avg:metric{*}` - Average across all
- `max:metric{*}` - Maximum value
- `avg:metric{*}by{host}` - Per-host average
- `avg:metric{*}by{kube_namespace}` - Per-namespace average

**Note:** URL-encode metrics queries (e.g., `avg%3Asystem.cpu.user%7B*%7D`)

### validate

Validate API credentials.

**Usage:**
```bash
dd-cli validate
```

## Timestamp Formats

**Default: Use relative time for all commands**
```bash
--from 15m   # 15 minutes ago
--from 1h    # 1 hour ago
--from 1d    # 1 day ago
--from 1w    # 1 week ago
```

**Supported units:**
- Minutes: `m`, `min`, `mins`, `minute`, `minutes`
- Hours: `h`, `hr`, `hrs`, `hour`, `hours`
- Days: `d`, `day`, `days`
- Weeks: `w`, `week`, `weeks`
- Months: `mo`, `mos`, `mon`, `mons`, `month`, `months`

**The `--to` flag defaults to current time if not specified.**

**Exception: ISO 8601 format** (only when user provides specific dates/times)
```bash
--from 2026-02-15T14:00:00Z --to 2026-02-15T15:00:00Z
```

**Exception: Unix epoch** (only for `raw` metrics API)
```bash
from=1739628000&to=1739631600  # In query string
```

## Output Processing

Always pipe dd-cli output through jq for user-friendly formatting.

**Small result sets (<20 logs) - Show directly:**
```bash
dd-cli --from 30m logs search --query "status:error" --limit 10 | \
  jq -r '"[\(.attributes.timestamp)] \(.attributes.service): \(.attributes.message)"'
```

**Large result sets (>20 logs) - Summarize:**
```bash
# Count by service
dd-cli --from 1h logs search --query "*" --limit 200 | \
  jq -r '.attributes.service' | sort | uniq -c | sort -rn

# Count by status
dd-cli --from 1h logs search --query "*" --limit 200 | \
  jq -r '.attributes.status' | sort | uniq -c | sort -rn
```

**Host lists - Show key info:**
```bash
dd-cli --from 1h host list | \
  jq -r '.host_list[] | "\(.name) - UP: \(.up)"'
```

**Metrics - Convert units:**
- K8s CPU: nanocores ÷ 1,000,000 = millicores
- Memory: bytes ÷ 1,048,576 = MB
- Always explain converted values: "CPU: 45%" not raw nanocores

**Present summaries to users, not raw JSON dumps.**

## Error Handling

If a command fails:
1. Read the error message
2. Match against common errors below
3. Tell user the specific problem and solution
4. Do NOT retry automatically

**Common errors and solutions:**

| Error | Cause | Solution |
|-------|-------|----------|
| `command not found: dd-cli` | Tool not installed | Tell user: "dd-cli is not installed. Install from: [instructions]" |
| `{"valid":false}` | Invalid credentials | Tell user: "Datadog API keys are invalid. Check DD_API_KEY and DD_APPLICATION_KEY environment variables." |
| `error: --from flag is required` | Missing timestamp | Add `--from 1h` to the command |
| `invalid timestamp format` | Wrong format used | Use relative time (`--from 1h`) not Unix epoch |
| `401 Unauthorized` | Auth failure | Run `dd-cli validate` to confirm credentials |
| `API error` | Various API issues | Check error details and inform user |

**Do NOT retry failed commands automatically. Wait for user to fix the underlying issue.**

## Quick Command Patterns

| User Request | Command Template |
|--------------|------------------|
| Recent errors | `dd-cli --from 15m logs search --query "status:error" --limit 50` |
| Service logs | `dd-cli --from 1h logs search --query "service:<name>" --limit 100` |
| Active hosts | `dd-cli --from 1h host list` |
| Specific host | `dd-cli host get "<hostname>"` |
| K8s namespace logs | `dd-cli --from 30m logs search --query "kube_namespace:<name>" --limit 100` |
| Warnings + Errors | `dd-cli --from 1h logs search --query "status:warn OR status:error" --limit 100` |

## Best Practices

1. **Start with validation** - Run `dd-cli validate` once per conversation
2. **Use relative time** - `--from 1h` is simpler than absolute timestamps
3. **Shorter time ranges = faster** - Start with `--from 15m`, expand if needed
4. **Default to single-page** - Only use `--auto-paginate` when you need >1000 logs
5. **Always set --limit with --auto-paginate** - Prevents excessive data retrieval
6. **Process with jq** - Always format output for users
7. **Summarize large results** - Don't dump 1000 logs, show patterns/counts
