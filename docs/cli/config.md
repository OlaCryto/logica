---
summary: "CLI reference for `logica config` (get/set/unset config values)"
read_when:
  - You want to read or edit config non-interactively
title: "config"
---

# `logica config`

Config helpers: get/set/unset values by path. Run without a subcommand to open
the configure wizard (same as `logica configure`).

## Examples

```bash
logica config get browser.executablePath
logica config set browser.executablePath "/usr/bin/google-chrome"
logica config set agents.defaults.heartbeat.every "2h"
logica config set agents.list[0].tools.exec.node "node-id-or-name"
logica config unset tools.web.search.apiKey
```

## Paths

Paths use dot or bracket notation:

```bash
logica config get agents.defaults.workspace
logica config get agents.list[0].id
```

Use the agent list index to target a specific agent:

```bash
logica config get agents.list
logica config set agents.list[1].tools.exec.node "node-id-or-name"
```

## Values

Values are parsed as JSON5 when possible; otherwise they are treated as strings.
Use `--json` to require JSON5 parsing.

```bash
logica config set agents.defaults.heartbeat.every "0m"
logica config set gateway.port 19001 --json
logica config set channels.whatsapp.groups '["*"]' --json
```

Restart the gateway after edits.
