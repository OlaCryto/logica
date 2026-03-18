---
summary: "CLI reference for `logica browser` (profiles, tabs, actions, extension relay)"
read_when:
  - You use `logica browser` and want examples for common tasks
  - You want to control a browser running on another machine via a node host
  - You want to use the Chrome extension relay (attach/detach via toolbar button)
title: "browser"
---

# `logica browser`

Manage Logica’s browser control server and run browser actions (tabs, snapshots, screenshots, navigation, clicks, typing).

Related:

- Browser tool + API: [Browser tool](/tools/browser)
- Chrome extension relay: [Chrome extension](/tools/chrome-extension)

## Common flags

- `--url <gatewayWsUrl>`: Gateway WebSocket URL (defaults to config).
- `--token <token>`: Gateway token (if required).
- `--timeout <ms>`: request timeout (ms).
- `--browser-profile <name>`: choose a browser profile (default from config).
- `--json`: machine-readable output (where supported).

## Quick start (local)

```bash
logica browser --browser-profile chrome tabs
logica browser --browser-profile logica start
logica browser --browser-profile logica open https://example.com
logica browser --browser-profile logica snapshot
```

## Profiles

Profiles are named browser routing configs. In practice:

- `logica`: launches/attaches to a dedicated Logica-managed Chrome instance (isolated user data dir).
- `chrome`: controls your existing Chrome tab(s) via the Chrome extension relay.

```bash
logica browser profiles
logica browser create-profile --name work --color "#FF5A36"
logica browser delete-profile --name work
```

Use a specific profile:

```bash
logica browser --browser-profile work tabs
```

## Tabs

```bash
logica browser tabs
logica browser open https://docs.logica.ai
logica browser focus <targetId>
logica browser close <targetId>
```

## Snapshot / screenshot / actions

Snapshot:

```bash
logica browser snapshot
```

Screenshot:

```bash
logica browser screenshot
```

Navigate/click/type (ref-based UI automation):

```bash
logica browser navigate https://example.com
logica browser click <ref>
logica browser type <ref> "hello"
```

## Chrome extension relay (attach via toolbar button)

This mode lets the agent control an existing Chrome tab that you attach manually (it does not auto-attach).

Install the unpacked extension to a stable path:

```bash
logica browser extension install
logica browser extension path
```

Then Chrome → `chrome://extensions` → enable “Developer mode” → “Load unpacked” → select the printed folder.

Full guide: [Chrome extension](/tools/chrome-extension)

## Remote browser control (node host proxy)

If the Gateway runs on a different machine than the browser, run a **node host** on the machine that has Chrome/Brave/Edge/Chromium. The Gateway will proxy browser actions to that node (no separate browser control server required).

Use `gateway.nodes.browser.mode` to control auto-routing and `gateway.nodes.browser.node` to pin a specific node if multiple are connected.

Security + remote setup: [Browser tool](/tools/browser), [Remote access](/gateway/remote), [Tailscale](/gateway/tailscale), [Security](/gateway/security)
