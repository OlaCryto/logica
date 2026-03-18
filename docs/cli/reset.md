---
summary: "CLI reference for `logica reset` (reset local state/config)"
read_when:
  - You want to wipe local state while keeping the CLI installed
  - You want a dry-run of what would be removed
title: "reset"
---

# `logica reset`

Reset local config/state (keeps the CLI installed).

```bash
logica reset
logica reset --dry-run
logica reset --scope config+creds+sessions --yes --non-interactive
```
