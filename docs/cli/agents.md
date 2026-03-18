---
summary: "CLI reference for `logica agents` (list/add/delete/set identity)"
read_when:
  - You want multiple isolated agents (workspaces + routing + auth)
title: "agents"
---

# `logica agents`

Manage isolated agents (workspaces + auth + routing).

Related:

- Multi-agent routing: [Multi-Agent Routing](/concepts/multi-agent)
- Agent workspace: [Agent workspace](/concepts/agent-workspace)

## Examples

```bash
logica agents list
logica agents add work --workspace ~/.logica/workspace-work
logica agents set-identity --workspace ~/.logica/workspace --from-identity
logica agents set-identity --agent main --avatar avatars/logica.png
logica agents delete work
```

## Identity files

Each agent workspace can include an `IDENTITY.md` at the workspace root:

- Example path: `~/.logica/workspace/IDENTITY.md`
- `set-identity --from-identity` reads from the workspace root (or an explicit `--identity-file`)

Avatar paths resolve relative to the workspace root.

## Set identity

`set-identity` writes fields into `agents.list[].identity`:

- `name`
- `theme`
- `emoji`
- `avatar` (workspace-relative path, http(s) URL, or data URI)

Load from `IDENTITY.md`:

```bash
logica agents set-identity --workspace ~/.logica/workspace --from-identity
```

Override fields explicitly:

```bash
logica agents set-identity --agent main --name "Logica" --emoji "🦞" --avatar avatars/logica.png
```

Config sample:

```json5
{
  agents: {
    list: [
      {
        id: "main",
        identity: {
          name: "Logica",
          theme: "space lobster",
          emoji: "🦞",
          avatar: "avatars/logica.png",
        },
      },
    ],
  },
}
```
