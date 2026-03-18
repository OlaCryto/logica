---
summary: "Uninstall Logica completely (CLI, service, state, workspace)"
read_when:
  - You want to remove Logica from a machine
  - The gateway service is still running after uninstall
title: "Uninstall"
---

# Uninstall

Two paths:

- **Easy path** if `logica` is still installed.
- **Manual service removal** if the CLI is gone but the service is still running.

## Easy path (CLI still installed)

Recommended: use the built-in uninstaller:

```bash
logica uninstall
```

Non-interactive (automation / npx):

```bash
logica uninstall --all --yes --non-interactive
npx -y logica uninstall --all --yes --non-interactive
```

Manual steps (same result):

1. Stop the gateway service:

```bash
logica gateway stop
```

2. Uninstall the gateway service (launchd/systemd/schtasks):

```bash
logica gateway uninstall
```

3. Delete state + config:

```bash
rm -rf "${LOGICA_STATE_DIR:-$HOME/.logica}"
```

If you set `LOGICA_CONFIG_PATH` to a custom location outside the state dir, delete that file too.

4. Delete your workspace (optional, removes agent files):

```bash
rm -rf ~/.logica/workspace
```

5. Remove the CLI install (pick the one you used):

```bash
npm rm -g logica
pnpm remove -g logica
bun remove -g logica
```

6. If you installed the macOS app:

```bash
rm -rf /Applications/Logica.app
```

Notes:

- If you used profiles (`--profile` / `LOGICA_PROFILE`), repeat step 3 for each state dir (defaults are `~/.logica-<profile>`).
- In remote mode, the state dir lives on the **gateway host**, so run steps 1-4 there too.

## Manual service removal (CLI not installed)

Use this if the gateway service keeps running but `logica` is missing.

### macOS (launchd)

Default label is `bot.molt.gateway` (or `bot.molt.<profile>`; legacy `com.logica.*` may still exist):

```bash
launchctl bootout gui/$UID/bot.molt.gateway
rm -f ~/Library/LaunchAgents/bot.molt.gateway.plist
```

If you used a profile, replace the label and plist name with `bot.molt.<profile>`. Remove any legacy `com.logica.*` plists if present.

### Linux (systemd user unit)

Default unit name is `logica-gateway.service` (or `logica-gateway-<profile>.service`):

```bash
systemctl --user disable --now logica-gateway.service
rm -f ~/.config/systemd/user/logica-gateway.service
systemctl --user daemon-reload
```

### Windows (Scheduled Task)

Default task name is `Logica Gateway` (or `Logica Gateway (<profile>)`).
The task script lives under your state dir.

```powershell
schtasks /Delete /F /TN "Logica Gateway"
Remove-Item -Force "$env:USERPROFILE\.logica\gateway.cmd"
```

If you used a profile, delete the matching task name and `~\.logica-<profile>\gateway.cmd`.

## Normal install vs source checkout

### Normal install (install.sh / npm / pnpm / bun)

If you used `https://logica.ai/install.sh` or `install.ps1`, the CLI was installed with `npm install -g logica@latest`.
Remove it with `npm rm -g logica` (or `pnpm remove -g` / `bun remove -g` if you installed that way).

### Source checkout (git clone)

If you run from a repo checkout (`git clone` + `logica ...` / `bun run logica ...`):

1. Uninstall the gateway service **before** deleting the repo (use the easy path above or manual service removal).
2. Delete the repo directory.
3. Remove state + workspace as shown above.
