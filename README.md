# dd-cli

A simple command-line tool to query the Datadog API and output JSON results.

## Building

```bash
zig build
```

## Usage

The tool requires the `DD_APP_API_KEY` environment variable to be set with your Datadog API key.

```bash
export DD_APP_API_KEY="your_api_key_here"
```

### Basic Usage

Query a Datadog endpoint (defaults to `datadoghq.com`):

```bash
./zig-out/bin/dd_cli --path "/api/v1/query?query=avg:system.cpu.user{*}"
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

- `DD_APP_API_KEY`: Your Datadog API key (required)

## Requirements

- Zig 0.15.2 or later

## Testing

Run the test suite:

```bash
zig build test --summary all
```
