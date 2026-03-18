---
summary: "CLI reference for `logica voicecall` (voice-call plugin command surface)"
read_when:
  - You use the voice-call plugin and want the CLI entry points
  - You want quick examples for `voicecall call|continue|status|tail|expose`
title: "voicecall"
---

# `logica voicecall`

`voicecall` is a plugin-provided command. It only appears if the voice-call plugin is installed and enabled.

Primary doc:

- Voice-call plugin: [Voice Call](/plugins/voice-call)

## Common commands

```bash
logica voicecall status --call-id <id>
logica voicecall call --to "+15555550123" --message "Hello" --mode notify
logica voicecall continue --call-id <id> --message "Any questions?"
logica voicecall end --call-id <id>
```

## Exposing webhooks (Tailscale)

```bash
logica voicecall expose --mode serve
logica voicecall expose --mode funnel
logica voicecall unexpose
```

Security note: only expose the webhook endpoint to networks you trust. Prefer Tailscale Serve over Funnel when possible.
