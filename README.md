# dd-cli

A command-line tool to query the Datadog API with subcommands for common operations.

## Building

```bash
zig build
```

## Environment Variables

The tool requires Datadog API credentials:

```bash
export DD_API_KEY="your_api_key_here"
export DD_APP_API_KEY="your_application_key_here"
export DD_SITE="datadoghq.com"  # Optional, defaults to datadoghq.com
```

**Supported Datadog Sites:**
- US1: `datadoghq.com` (default)
- EU: `datadoghq.eu`
- US3: `us3.datadoghq.com`
- US5: `us5.datadoghq.com`
- US1-FED: `ddog-gov.com`

**Note:** The tool automatically prepends `api.` to the domain, so you can use `datadoghq.com` and it will request from `api.datadoghq.com`.

## Commands

### `validate` - Validate API Credentials

Verify that your API keys are valid and working.

```bash
# Validate with default domain
./zig-out/bin/dd_cli validate

# Validate with specific domain
./zig-out/bin/dd_cli validate --domain datadoghq.eu
```

**Response:**
```json
{"valid": true}
```

### `host` - Host Infrastructure Management

Manage and query host information from Datadog.

#### `host list` - List/Search Hosts

List all hosts or search with filters.

```bash
# List all hosts
./zig-out/bin/dd_cli host list

# Filter by environment
./zig-out/bin/dd_cli host list "env:prod"

# Complex filter with multiple tags
./zig-out/bin/dd_cli host list "env:prod,role:elasticsearch"

# With time range (using global flags)
./zig-out/bin/dd_cli --from "2024-01-15T00:00:00Z" --to "2024-01-15T23:59:59Z" host list

# Different domain
./zig-out/bin/dd_cli --domain datadoghq.eu host list
```

**Filter Syntax:**
- Single tag: `env:prod`
- Multiple tags (AND): `env:prod,role:db`
- The filter is automatically URL-encoded

#### `host get` - Get Specific Host

Retrieve detailed information about a specific host.

```bash
# Get host by ID
./zig-out/bin/dd_cli host get "i-abc123"

# Get host by name
./zig-out/bin/dd_cli host get "server.example.com"

# Different domain
./zig-out/bin/dd_cli --domain datadoghq.eu host get "i-abc123"
```

**Note:** Host names are automatically URL-encoded for safety.

### `raw` - Low-Level API Access

Direct access to any Datadog API endpoint with full control over HTTP method, headers, and query strings.

**Key Feature:** The `raw` command accepts pre-formatted strings **without any encoding or parsing**. You are responsible for proper formatting.

```bash
# Simple GET request
./zig-out/bin/dd_cli raw --path /api/v1/validate

# GET with pre-formatted query string (no encoding)
./zig-out/bin/dd_cli raw --path /api/v1/hosts --query "filter=env%3Aprod&count=10"

# POST request with JSON body
./zig-out/bin/dd_cli raw --path /api/v1/series \
  --method POST \
  --header "Content-Type:application/json" \
  --data '{"series":[{"metric":"test.metric","points":[[1707955200,1]]}]}'

# Multiple custom headers
./zig-out/bin/dd_cli raw --path /api/v1/validate \
  --header "X-Custom-Header:Value1" \
  --header "X-Another-Header:Value2"

# Different HTTP methods
./zig-out/bin/dd_cli raw --path /api/v1/hosts --method GET
./zig-out/bin/dd_cli raw --path /api/v1/hosts --method PUT --data '{"key":"value"}'

# Different domain
./zig-out/bin/dd_cli --domain datadoghq.eu raw --path /api/v1/validate
```

**Options:**
- `-p, --path` (required): API path (e.g., `/api/v1/hosts`)
- `-X, --method` (optional): HTTP method (default: GET)
- `-q, --query` (optional): Pre-formatted query string (not URL encoded)
- `-H, --header` (repeatable): Custom header in `Name:Value` format
- `--data` (optional): Request body

**Important:** Headers are split on the **first colon only**, so you can include colons in the value (e.g., `Authorization:Bearer tok:en:123`).

## Global Options

All commands support global flags that apply across subcommands:

### Domain Selection

```bash
# Override domain for any command
./zig-out/bin/dd_cli --domain datadoghq.eu validate
./zig-out/bin/dd_cli -d us3.datadoghq.com host list
```

**Domain Resolution Priority:**
1. `--domain` flag (highest priority)
2. `DD_SITE` environment variable
3. `datadoghq.com` (default)

### Date Range Filtering

Use `--from` and `--to` to filter results by time range (ISO 8601 format):

```bash
# List hosts active in the last hour
./zig-out/bin/dd_cli --from $(date -u -v-1H +%Y-%m-%dT%H:%M:%SZ) --to $(date -u +%Y-%m-%dT%H:%M:%SZ) host list

# List hosts on a specific date (macOS)
./zig-out/bin/dd_cli \
  --from "2024-01-15T00:00:00Z" \
  --to "2024-01-15T23:59:59Z" \
  host list "env:prod"

# Using date command for easier date manipulation (Linux)
FROM=$(date -u -d "2024-01-01 00:00:00" +%Y-%m-%dT%H:%M:%SZ)
TO=$(date -u -d "2024-01-31 23:59:59" +%Y-%m-%dT%H:%M:%SZ)
./zig-out/bin/dd_cli --from "$FROM" --to "$TO" host list

# Last 24 hours (macOS)
./zig-out/bin/dd_cli --from $(date -u -v-24H +%Y-%m-%dT%H:%M:%SZ) host list

# Last 24 hours (Linux)
./zig-out/bin/dd_cli --from $(date -u -d '24 hours ago' +%Y-%m-%dT%H:%M:%SZ) host list
```

**Time Format:**
- Use ISO 8601 format: `YYYY-MM-DDTHH:MM:SSZ` (UTC timezone)
- Example: `2024-01-15T10:30:00Z`
- Unix timestamps are also accepted but ISO 8601 is recommended

**Notes:**
- Date range parameters are automatically added to API requests when provided
- Commands that don't use date ranges simply ignore these flags
- Both `--from` and `--to` are optional and can be used independently

## Examples

### Basic Workflow

```bash
# 1. Validate credentials
./zig-out/bin/dd_cli validate

# 2. List all hosts
./zig-out/bin/dd_cli host list

# 3. Filter for production hosts
./zig-out/bin/dd_cli host list "env:prod"

# 4. Filter with date range (last 24 hours)
./zig-out/bin/dd_cli --from $(date -u -v-24H +%Y-%m-%dT%H:%M:%SZ) host list "env:prod"

# 5. Get details for specific host
./zig-out/bin/dd_cli host get "i-abc123"
```

### Advanced Usage

```bash
# Time-based queries with global flags (ISO 8601)
./zig-out/bin/dd_cli \
  --from "$(date -u -v-1H +%Y-%m-%dT%H:%M:%SZ)" \
  --to "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  host list "env:staging"

# Specific date range
./zig-out/bin/dd_cli \
  --from "2024-01-15T09:00:00Z" \
  --to "2024-01-15T17:00:00Z" \
  host list "env:production"

# Custom API request with raw command (note: raw command ignores global date flags)
# For raw command, you can use ISO 8601 or Unix timestamps in the query string
./zig-out/bin/dd_cli raw \
  --path /api/v1/query \
  --query "query=avg:system.cpu.user{*}&from=$(date -u -v-1H +%s)&to=$(date -u +%s)"

# POST metrics data
./zig-out/bin/dd_cli raw \
  --path /api/v1/series \
  --method POST \
  --header "Content-Type:application/json" \
  --data '{
    "series": [{
      "metric": "custom.metric",
      "points": [['"$(date +%s)"', 42]],
      "type": "gauge",
      "tags": ["env:prod"]
    }]
  }'

# Query with jq for JSON processing
./zig-out/bin/dd_cli host list "env:prod" | jq '.host_list[] | {name: .name, up: .up}'
```

## Design Philosophy

### Two-Tier Command Design

**Friendly Commands** (`validate`, `host`):
- Accept natural inputs
- Automatically URL-encode parameters
- Follow Datadog API conventions
- Designed for common use cases

**Raw Command** (`raw`):
- Accepts pre-formatted strings as-is
- No parsing or encoding
- Full control for advanced users
- Minimal wrapper around HTTP client

This design provides convenience for common operations while maintaining flexibility for advanced use cases.

## Testing

Run the test suite:

```bash
zig build test --summary all
```

## Requirements

- Zig 0.15.2 or later

## Migration from v1.0

If you were using the old flat command structure:

```bash
# Old (v1.0)
dd_cli --path /api/v1/validate

# New (v2.0)
dd_cli raw --path /api/v1/validate
# or use the convenience command:
dd_cli validate
```

The old `--url` flag is now `--domain` and is a global option.

## API Reference

For detailed Datadog API documentation, see:
- [Datadog API Documentation](https://docs.datadoghq.com/api/)
- [Hosts API](https://docs.datadoghq.com/api/latest/hosts/)
- [Validate API Key](https://docs.datadoghq.com/api/latest/authentication/#validate-api-key)

## License

This project is licensed under the BSD 3-Clause License - see the [LICENSE](LICENSE) file for details.
