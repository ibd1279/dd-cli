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

Set environment variables for authentication:

```bash
export DD_API_KEY="your_api_key"
export DD_APPLICATION_KEY="your_application_key"
export DD_SITE="datadoghq.com"  # Optional: datadoghq.eu, us3.datadoghq.com, etc.
```

## Commands

### validate

Verify API credentials:

```bash
dd-cli validate
dd-cli --domain datadoghq.eu validate
```

### host list

List hosts with optional filters:

```bash
# All hosts
dd-cli host list

# Filter by tags
dd-cli host list "env:prod"
dd-cli host list "env:prod,role:web"

# With time range (ISO 8601)
dd-cli --from "2024-01-15T00:00:00Z" --to "2024-01-15T23:59:59Z" host list
```

### host get

Get specific host details:

```bash
dd-cli host get "i-abc123"
dd-cli host get "server.example.com"
```

### logs search

Search and retrieve log events with optional pagination:

```bash
# Basic search - returns first page (up to 1000 logs by default)
dd-cli logs search --query "service:web"

# Search with time range
dd-cli --from "2024-01-15T10:00:00Z" --to "2024-01-15T11:00:00Z" \
  logs search --query "status:error"

# Single page with explicit limit
dd-cli logs search --query "*" --limit 100

# Multiple pages up to 5000 total logs
dd-cli logs search --query "*" --auto-paginate --limit 5000

# Get all logs matching query (use with caution!)
dd-cli logs search --query "status:error" --auto-paginate

# Search specific indexes
dd-cli logs search --query "*" --indexes "main,staging"

# Sort order (default: -timestamp for newest first)
dd-cli logs search --query "*" --sort "timestamp"  # Oldest first

# Pipe to jq for filtering
dd-cli logs search --query "@http.status_code:>=500" | jq -r '.attributes.message'

# Real-time log monitoring pattern
dd-cli logs search --query "*" --auto-paginate | grep "ERROR"

# Extract specific fields
dd-cli logs search --query "service:api" | \
  jq -r '[.attributes.timestamp, .attributes.service, .attributes.message] | @tsv'
```

**Options:**
- `-q, --query`: Search query string (default: `*` for all logs)
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
- `--from`: Start time in ISO 8601 format (YYYY-MM-DDTHH:MM:SSZ)
- `--to`: End time in ISO 8601 format

**Domain priority:** `--domain` flag > `DD_SITE` env > `datadoghq.com`

## Examples

```bash
# Quick validation
dd-cli validate

# Production hosts from last 24 hours
dd-cli --from $(date -u -v-24H +%Y-%m-%dT%H:%M:%SZ) host list "env:prod"

# Get host details
dd-cli host get "web-server-01"

# Custom API query with jq
dd-cli host list "env:prod" | jq '.host_list[] | {name: .name, up: .up}'

# Search logs from the last hour
dd-cli --from $(date -u -v-1H +%Y-%m-%dT%H:%M:%SZ) \
  logs search --query "service:web AND status:error"

# Monitor logs in real-time with grep
dd-cli logs search --query "service:api" --auto-paginate | grep -i "timeout"

# Extract error messages from logs
dd-cli logs search --query "status:error" --limit 100 | \
  jq -r '.attributes.message' | sort | uniq -c | sort -rn

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

## Requirements

- Zig 0.15.2 or later

## API Reference

- [Datadog API Documentation](https://docs.datadoghq.com/api/)
- [Hosts API](https://docs.datadoghq.com/api/latest/hosts/)
- [Logs API](https://docs.datadoghq.com/api/latest/logs/)
- [Log Search Syntax](https://docs.datadoghq.com/logs/explorer/search_syntax/)
- [Authentication](https://docs.datadoghq.com/api/latest/authentication/)

## License

BSD 3-Clause License - see [LICENSE](LICENSE) file.
