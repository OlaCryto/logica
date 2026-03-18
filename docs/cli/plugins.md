---
summary: "CLI reference for `logica plugins` (list, install, enable/disable, doctor)"
read_when:
  - You want to install or manage in-process Gateway plugins
  - You want to debug plugin load failures
title: "plugins"
---

# `logica plugins`

Manage Gateway plugins/extensions (loaded in-process).

Related:

- Plugin system: [Plugins](/tools/plugin)
- Plugin manifest + schema: [Plugin manifest](/plugins/manifest)
- Security hardening: [Security](/gateway/security)

## Commands

```bash
logica plugins list
logica plugins info <id>
logica plugins enable <id>
logica plugins disable <id>
logica plugins doctor
logica plugins update <id>
logica plugins update --all
```

Bundled plugins ship with Logica but start disabled. Use `plugins enable` to
activate them.

All plugins must ship a `logica.plugin.json` file with an inline JSON Schema
(`configSchema`, even if empty). Missing/invalid manifests or schemas prevent
the plugin from loading and fail config validation.

### Install

```bash
logica plugins install <path-or-spec>
```

Security note: treat plugin installs like running code. Prefer pinned versions.

Supported archives: `.zip`, `.tgz`, `.tar.gz`, `.tar`.

Use `--link` to avoid copying a local directory (adds to `plugins.load.paths`):

```bash
logica plugins install -l ./my-plugin
```

### Update

```bash
logica plugins update <id>
logica plugins update --all
logica plugins update <id> --dry-run
```

Updates only apply to plugins installed from npm (tracked in `plugins.installs`).
