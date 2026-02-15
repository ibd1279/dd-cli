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
export DD_APP_API_KEY="your_application_key"
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
- [Authentication](https://docs.datadoghq.com/api/latest/authentication/)

## License

BSD 3-Clause License - see [LICENSE](LICENSE) file.
