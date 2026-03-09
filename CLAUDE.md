# dd-cli — Claude Instructions

## Build & Run

```bash
zig build                                          # debug build → zig-out/bin/dd-cli
zig build --release=fast --prefix ~/.local         # install to ~/.local/bin/dd-cli
zig build test --summary all                       # run all tests
zig build run -- list logs "error" --from 1h       # run without installing
```

Use `zig build --fork` when working with local package overrides.

## Project Structure

```
src/
├── main.zig       # CLI argument definitions (yazap) + subcommand dispatch
├── common.zig     # Context struct, initConfig, buildHeaders, buildUrl,
│                  # executeRequest, time parsing, JSON utilities, streaming
├── auth.zig       # OAuth2 PKCE login/logout, token file I/O
├── list.zig       # list verb handlers
├── aggregate.zig  # aggregate verb handlers
├── get.zig        # get verb handlers
├── validate.zig   # validate verb handler
├── raw.zig        # raw verb handler
└── api/
    ├── datadog_v1.zig  # generated v1 API types
    └── datadog_v2.zig  # generated v2 API types
```

## Architecture

### Context

`common.Context` is created once in `main()` by `initConfig()` and passed as `*const Context` to every handler. It holds credentials, domain, and time range.

**Auth priority** (in `initConfig`):
1. `DD_ACCESS_TOKEN` env var → `auth_type = .bearer`
2. Stored token file (`~/.config/dd-cli/token.json`) → `auth_type = .bearer` (auto-refreshes via `DD_CLIENT_ID` env var)
3. `DD_API_KEY` + `DD_APPLICATION_KEY` env vars → `auth_type = .api_key`

### Headers

`common.buildHeaders(arena_alloc, ctx, custom_headers)` dispatches on `ctx.auth_type`:
- `.bearer` → `Authorization: Bearer {token}` + `Accept: application/json`
- `.api_key` → `DD-API-KEY` + `DD-APPLICATION-KEY` + `Accept: application/json`

All handler call sites use this pattern — never construct auth headers manually.

### Auth commands

`auth login` and `auth logout` are handled **before** `initConfig` in `main()` since they don't require existing credentials. The `auth.zig` module owns all token file logic.

### URL building

- `buildUrl(allocator, domain, path, query_params)` — RFC 3986 encodes params, auto-prefixes `api.`
- `buildRawUrl(allocator, domain, path, query_string)` — no encoding, for the `raw` command

Datadog OAuth2 endpoints use `app.{domain}` (not `api.{domain}`), handled in `auth.zig`.

### Streaming / pagination

`streamLogsSearch` and `streamEventsSearch` in `common.zig` take pre-built `headers` and a URL base. They own their arena internally. Callers in `list.zig` build headers once and pass them in.

### Memory

- Arena allocators for request-scoped work: `var arena = std.heap.ArenaAllocator.init(ctx.allocator); defer arena.deinit();`
- `Context.deinit()` frees all owned fields; handlers never free the context
- `executeRequest` returns an owned `[]const u8` allocated from the passed allocator

## Key Conventions

- Zig 0.15.2 — use `std.ArrayList(u8).writer(allocator)` pattern for string building
- `std.Io.Writer.Allocating` for HTTP response bodies
- `std.json.parseFromSlice` / `std.json.fmt` for JSON; `std.json.Value` for dynamic parsing
- Time arguments: ISO 8601 strings internally; some APIs need Unix seconds/ms (use `parseIso8601ToUnix`)
- Valid Datadog domains are whitelisted in `isValidDatadogDomain`

## Dependencies

- `yazap` — argument parser
- `oauth2` (ibd1279/oauth2) — PKCE utilities, CallbackServer, token exchange; depends on `otel-zig`

Both are declared in `build.zig.zon` and wired to the exe module in `build.zig`.

## Adding a New Command

1. Add argument definition in `main.zig` under the appropriate verb command
2. Add handler function in the corresponding verb file (`list.zig`, `get.zig`, etc.)
3. Add dispatch case in `main.zig`
4. Use `common.buildHeaders(arena_alloc, ctx, &.{})` for auth headers — do not hardcode header names
