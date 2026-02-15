# dd-cli

A simple command-line tool to query the Datadog API and output JSON results.

## Building

```bash
zig build
```

## Usage

The tool requires both Datadog API key and Application key environment variables:

```bash
export DD_API_KEY="your_api_key_here"
export DD_APP_API_KEY="your_application_key_here"
export DD_SITE="datadoghq.com"  # Optional, defaults to datadoghq.com
```

### Basic Usage

Validate credentials:

```bash
./zig-out/bin/dd_cli --path "/api/v1/validate"
```

List active hosts:

```bash
./zig-out/bin/dd_cli --path "/api/v1/hosts"
```

Query metrics:

```bash
./zig-out/bin/dd_cli --path "/api/v1/query?query=avg:system.cpu.user{*}&from=$(date -u -v-1H +%s)&to=$(date -u +%s)"
```

### Specify a Different Datadog Domain

```bash
./zig-out/bin/dd_cli --url datadoghq.eu --path "/api/v1/query?query=avg:system.cpu.user{*}"
```

### Short Flags

```bash
./zig-out/bin/dd_cli -p "/api/v1/query?query=avg:system.cpu.user{*}"
./zig-out/bin/dd_cli -u datadoghq.eu -p "/api/v1/hosts"
```

## Options

- `-u, --url`: Datadog domain URL (default: `datadoghq.com`)
- `-p, --path`: API path to query (required)
- `-h, --help`: Display help message

## Valid Datadog Domains

The tool validates that the URL is a legitimate Datadog domain:
- `datadoghq.com`
- `datadoghq.eu`
- `ddog-gov.com`
- `*.datadoghq.com` (e.g., `api.datadoghq.com`, `us3.datadoghq.com`)

## Environment Variables

- `DD_API_KEY`: Your Datadog API key (required for authentication)
- `DD_APP_API_KEY`: Your Datadog Application key (required for read operations)
- `DD_SITE`: Datadog site domain (optional, defaults to `datadoghq.com`)
  - US1: `datadoghq.com`
  - EU: `datadoghq.eu`
  - US3: `us3.datadoghq.com`
  - US5: `us5.datadoghq.com`

**Note:** The tool automatically prepends `api.` to the domain, so you can use `datadoghq.com` and it will request from `api.datadoghq.com`.

## Requirements

- Zig 0.15.2 or later

## Testing

Run the test suite:

```bash
zig build test --summary all
```
