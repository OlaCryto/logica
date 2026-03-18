---
title: "TOOLS.md Template"
summary: "Workspace template for Arena API tools reference"
read_when:
  - Bootstrapping a workspace manually
  - Agent needs to learn API endpoints
---

# TOOLS.md - Arena API Reference

## IMPORTANT: How to use the Arena API

**Always use `curl.exe` (NOT `curl`) for API calls on Windows.** On Windows, `curl` is aliased to PowerShell's Invoke-WebRequest which breaks headers. `curl.exe` is the real curl. On Linux/macOS, `curl` is fine.

Never use `logica` CLI commands for Arena operations — they don't exist.

## API Base URL
```
https://brave-alignment-production-1706.up.railway.app
```

## Step 1: Register (one time)
```bash
curl.exe "https://brave-alignment-production-1706.up.railway.app/register?wallet=0xYOUR_WALLET&name=YOUR_NAME"
```
This returns your API key. **Save it to a file called `api-key.txt` in your workspace immediately.**

## Step 2: Learn all endpoints
Every module has an agent-instructions page. Read them to learn the full API:

```bash
# Signals — market intelligence, scanning, funding rates, whales
curl.exe "https://brave-alignment-production-1706.up.railway.app/signals/agent-instructions"

# Perps — perpetual futures trading
curl.exe "https://brave-alignment-production-1706.up.railway.app/perp/agent-instructions"

# DEX — token swaps on Avalanche
curl.exe "https://brave-alignment-production-1706.up.railway.app/dex/agent-instructions"

# Launchpad — bonding curve token trading
curl.exe "https://brave-alignment-production-1706.up.railway.app/launchpad/agent-instructions"

# Bridge — cross-chain transfers
curl.exe "https://brave-alignment-production-1706.up.railway.app/bridge/agent-instructions"

# Social — Arena chat, DMs, threads, follows
curl.exe "https://brave-alignment-production-1706.up.railway.app/social/agent-instructions"

# Tickets — buy/sell user tickets for chat access
curl.exe "https://brave-alignment-production-1706.up.railway.app/tickets/agent-instructions"
```

## Step 3: Use the API

**ALL endpoints require your API key** as a header: `x-api-key: YOUR_KEY`

Example:
```bash
curl.exe -H "x-api-key: YOUR_KEY" "https://brave-alignment-production-1706.up.railway.app/signals/scan?count=5"
```

## On First Boot Checklist

1. Read ARENA_IDENTITY.md for your wallet and credentials
2. Register with the Logiqical API and save your API key
3. Link your Arena API key: POST /perp/setup
4. Read /signals/agent-instructions to learn signals
5. Scan for opportunities: GET /signals/scan?count=5
6. Read /perp/agent-instructions when ready to trade

## Rules

1. **Always use curl.exe on Windows** — never bare `curl` (PowerShell alias) or `logica` CLI commands
2. **Always include x-api-key header** on every request (except /register and agent-instructions pages)
3. **Read the agent-instructions pages** — they have complete docs for every endpoint
4. **Save your API key** to api-key.txt so you don't lose it between sessions
5. **Check signals before every trade** — scan first, then decide
