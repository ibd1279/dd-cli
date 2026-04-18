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
├── auth.zig       # Token file I/O (loadStoredToken, isTokenExpired)
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

`common.Context` is created once in `main()` by `initConfig()` and passed as `*const Context` to every handler. It holds credentials, domain, time range, and `io: std.Io` for all I/O operations. Use `ctx.io` anywhere file, time, or network I/O is needed.

`initConfig(io, allocator, domain_arg, from_arg, to_arg, verbose, env)` takes a `common.EnvVars` struct (populated from `std.process.Init.environ_map` in `main()`) rather than reading env vars directly — this makes the function testable without real env state.

`main()` takes `std.process.Init` (Zig 0.16.0 entry point) which provides `init.io`, `init.gpa`, `init.minimal.args`, and `init.environ_map`.

**Auth priority** (in `initConfig`):
1. `DD_ACCESS_TOKEN` env var → `auth_type = .bearer`
2. Stored token file (`~/.config/dd-cli/token.json`) → `auth_type = .bearer` (no auto-refresh; expired tokens fall through)
3. `DD_API_KEY` + `DD_APPLICATION_KEY` env vars → `auth_type = .api_key`

### Headers

`common.buildHeaders(arena_alloc, ctx, custom_headers)` dispatches on `ctx.auth_type`:
- `.bearer` → `Authorization: Bearer {token}` + `Accept: application/json`
- `.api_key` → `DD-API-KEY` + `DD-APPLICATION-KEY` + `Accept: application/json`

All handler call sites use this pattern — never construct auth headers manually.

### Auth commands

There is no interactive login command. `auth.zig` owns token file logic (`~/.config/dd-cli/token.json`) and exposes `loadStoredToken(io, allocator)` and `isTokenExpired(expires_at, now)`. Token refresh is not performed — expired tokens fall through to API key auth.

### URL building

- `buildUrl(allocator, domain, path, query_params)` — RFC 3986 encodes params, auto-prefixes `api.`
- `buildRawUrl(allocator, domain, path, query_string)` — no encoding, for the `raw` command

Datadog OAuth2 endpoints use `app.{domain}` (not `api.{domain}`), handled in `auth.zig`.

### Streaming / pagination

`streamLogsSearch`, `streamSpansSearch`, and `streamEventsSearch` in `list.zig` / `common.zig` all delegate to `common.runPaginatedStream(io, allocator, url_base, headers, limit, auto_paginate, label, ctx)`. The `ctx` argument is an anonymous struct that implements `buildBody(arena_alloc, cursor)` — this is the only caller-specific piece; the page loop, error handling, and cursor management are shared.

For simple one-shot GET requests, use `common.getJson(ctx, arena_alloc, path, query_params)` which builds headers, builds the URL, logs if verbose, and calls `executeRequest`.

### Memory

- Arena allocators for request-scoped work: `var arena = std.heap.ArenaAllocator.init(ctx.allocator); defer arena.deinit();`
- `Context.deinit()` frees all owned fields; handlers never free the context
- `executeRequest` returns an owned `[]const u8` allocated from the passed allocator

## Key Conventions

- Zig 0.16.0 — `std.ArrayList(u8).writer(allocator)` for string building; `io: std.Io` threads through Context and all I/O operations
- `std.Io.Writer.Allocating` for HTTP response bodies
- `std.json.parseFromSlice` / `std.json.fmt` for JSON; `std.json.Value` for dynamic parsing
- Time arguments: ISO 8601 strings internally; some APIs need Unix seconds/ms (use `parseIso8601ToUnix`)
- Valid Datadog domains are whitelisted in `isValidDatadogDomain`

## Dependencies

- `yazap` (0.7.0) — argument parser

Declared in `build.zig.zon` and wired to the exe module in `build.zig`.

## Adding a New Command

1. Add argument definition in `main.zig` under the appropriate verb command
2. Add handler function in the corresponding verb file (`list.zig`, `get.zig`, etc.)
3. Add dispatch case in `main.zig`
4. Use `common.buildHeaders(arena_alloc, ctx, &.{})` for auth headers — do not hardcode header names
