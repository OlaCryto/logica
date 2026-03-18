<p align="center">
  <img src="assets/logica-logo.svg" alt="Logica" width="600">
</p>

<p align="center">
  <strong>The first autonomous AI trading agent framework built natively for Arena on Avalanche.</strong>
</p>

<p align="center">
  <a href="https://github.com/OlaCryto/logica"><img src="https://img.shields.io/badge/License-MIT-blue.svg?style=for-the-badge" alt="MIT License"></a>
  <a href="https://www.npmjs.com/package/logiqical"><img src="https://img.shields.io/badge/SDK-logiqical-red?style=for-the-badge" alt="SDK"></a>
  <a href="https://arena.social"><img src="https://img.shields.io/badge/Platform-Arena-purple?style=for-the-badge" alt="Arena"></a>
  <a href="https://www.avax.network"><img src="https://img.shields.io/badge/Chain-Avalanche-e84142?style=for-the-badge" alt="Avalanche"></a>
</p>

---

**Logica** is an autonomous AI agent that lives on [Arena](https://arena.social). It trades perpetual futures, buys tickets, enters chatrooms, snipes launchpad tokens, bridges assets, stakes ARENA — all autonomously. When Logica wakes up, the only world it knows is Arena.

Built on top of [OpenClaw](https://github.com/openclaw/openclaw) — the most powerful open-source AI agent framework — rebranded and rewired as Arena-native. Every OpenClaw capability (Telegram, WhatsApp, Discord, voice, browser, 52 skills) is preserved. We just added Arena as its home.

## What Makes Logica Different

Most AI agents are chatbots with a wallet. Logica is different:

- **Arena-native identity** — wakes up knowing Arena is its world
- **Trades perps autonomously** — 250+ markets via Hyperliquid, up to 50x leverage
- **Signals intelligence** — analyzes funding rates, whale orderbook depth, RSI, momentum before every trade
- **Social agent** — buys tickets, enters chatrooms, DMs, follows, posts threads on Arena
- **Economically sustainable** — earns through trading, staking rewards, and X402 micropayments
- **Full Logica power** — Telegram, WhatsApp, Discord, Slack, browser, voice, memory, 60 skills

## 8 Arena Modules

| Module | What it does |
|--------|-------------|
| **Perps** | 250+ perpetual futures markets, long/short, TP/SL, up to 50x leverage |
| **Signals** | Real-time market intelligence — funding rates, whale tracking, RSI, opportunity scanner |
| **Social** | Chat, DM, follow, threads, discover users on Arena Social |
| **Tickets** | Buy/sell Arena user tickets. Ticket = access to chatrooms |
| **Launchpad** | Discover & trade 112,000+ tokens. Graduation monitoring |
| **DEX** | Swap any token via LFJ + Pharaoh DEX aggregation |
| **Bridge** | Move assets from 15+ chains to Avalanche |
| **Staking** | Stake ARENA tokens, earn from every launchpad graduation |

Plus 52 original Logica skills (Spotify, GitHub, Notion, 1Password, weather, voice, browser, and more).

## Quick Start

```bash
# Clone
git clone https://github.com/OlaCryto/logica.git
cd logica

# Install dependencies
pnpm install

# Run the onboarding wizard
pnpm logica onboard
```

The wizard walks you through setting up:
1. Your AI provider (Anthropic, OpenAI, Google, etc.)
2. Your messaging channels (Telegram, WhatsApp, Discord, etc.)
3. Your Arena API key
4. Your first Arena skills

## Architecture

```
logica/
├── src/                  # Core agent runtime
│   ├── agents/           # Agent identity, system prompt, workspace
│   ├── gateway/          # Gateway server (control plane)
│   ├── channels/         # Messaging channel plugins
│   ├── config/           # Configuration management
│   └── daemon/           # Service management (systemd, launchd, schtasks)
├── skills/               # 60 skills (8 Arena + 52 general)
│   ├── arena-perps/      # Perpetual futures trading
│   ├── arena-signals/    # Market intelligence
│   ├── arena-social/     # Arena Social integration
│   ├── arena-tickets/    # Ticket buying/selling
│   ├── arena-launchpad/  # Token launchpad
│   ├── arena-dex/        # DEX swap aggregation
│   ├── arena-bridge/     # Cross-chain bridging
│   ├── arena-staking/    # ARENA staking
│   └── ...               # 52 original Logica skills
├── extensions/           # Channel plugins (Discord, Telegram, Slack, etc.)
├── apps/                 # Native apps (macOS, iOS, Android)
├── ui/                   # Web control UI
└── docs/                 # Documentation
```

## The Soul

When Logica boots, it reads these files to know who it is:

- **`SOUL.md`** — Trading rules, risk parameters, personality. "You are Logica. You live on Arena. You trade, you communicate, you survive."
- **`IDENTITY.md`** — Name, vibe, emoji, platform, chain
- **`BOOTSTRAP.md`** — First-run setup: register on Arena, fund wallet, set up perps, check signals
- **`AGENTS.md`** — Workspace rules, trading workflow, memory management

These files are fully customizable. Make the agent yours.

## Arena API Integration

Logica connects to Arena through the [Logiqical API](https://brave-alignment-production-1706.up.railway.app):

```
# Signals — check before every trade
GET /signals/summary?coin=BTC
GET /signals/scan?count=5

# Perps — execute trades
POST /perp/orders/place
POST /perp/orders/close-position

# Social — communicate
POST /social/chat/send
GET /social/chat/rooms

# Tickets — access chatrooms
POST /tickets/buy
GET /tickets/holdings?wallet=

# And 80+ more endpoints...
```

SDK: `npm install logiqical`
MCP Server: `npx logiqical-mcp-server`

## Contributing

This is an open-source project. Contributions welcome.

**Areas we need help with:**
- **Signal strategies** — better trading signals, backtesting, ML-based predictions
- **Agent competition** — leaderboards, tournaments, performance tracking
- **X402 integration** — agents paying other agents for signals via micropayments
- **New Arena skills** — as Arena ships new features
- **UI/branding** — the website, dashboard, agent explorer

### How to contribute

1. Fork the repo
2. Create a branch (`git checkout -b feature/my-feature`)
3. Make your changes
4. Submit a PR

## Vision

Logica is not just a trading bot. It's the beginning of **autonomous agents that earn, trade, and communicate on Arena**.

The roadmap:
- **Signal feedback loop** — agent learns which signals lead to winning trades
- **Agent leaderboard** — public P&L tracking, performance ranking
- **Investable agents** — buy an agent's ticket to get exposure to its trading performance
- **X402 signal marketplace** — agents sell signals to other agents via micropayments
- **Agent-to-agent commerce** — agents hire other agents for services

## Credits

- Built on [OpenClaw](https://github.com/openclaw/openclaw) — the best open-source AI agent framework
- Powered by [Arena](https://arena.social) — social trading platform on Avalanche
- Trading via [Hyperliquid](https://hyperliquid.xyz) through Arena's perps integration
- [Logiqical API](https://brave-alignment-production-1706.up.railway.app) — the infrastructure layer

## License

MIT — same as Logica. Use it, fork it, build on it.
