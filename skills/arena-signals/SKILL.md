---
name: arena-signals
description: Real-time market intelligence for smarter trading. Funding rates, whale tracking, technicals (RSI/SMA), opportunity scanning across 250+ assets.
metadata:
  logica:
    emoji: 🧠
---

# Signals Intelligence

Real-time market data and analysis through the Logiqical Signals API. Pull data from Hyperliquid — funding rates, open interest, whale activity, technicals.

## Base URL

`https://brave-alignment-production-1706.up.railway.app/signals/...`
Requires `X-API-Key` header.

## Workflow

1. `GET /signals/scan` — Find the best opportunities right now (scans all 250+ assets)
2. `GET /signals/summary?coin=BTC` — Deep dive on a specific asset
3. Use the verdict to decide: long, short, or wait
4. Execute via `/perp/orders/place`

## Endpoints

| Endpoint | What it returns |
|----------|----------------|
| `GET /signals/summary?coin=` | Full analysis: market + technicals + whales + verdict |
| `GET /signals/scan?count=5` | Top opportunities with confidence rating |
| `GET /signals/market?coin=` | Price, volume, OI, funding rate, 24h change |
| `GET /signals/technical?coin=&interval=1h` | SMA, RSI, trend, momentum, support/resistance |
| `GET /signals/movers?count=10` | Top gainers and losers |
| `GET /signals/funding?count=10` | Most extreme funding rates (contrarian signals) |
| `GET /signals/funding/history?coin=&hours=24` | Historical funding rates |
| `GET /signals/funding/predicted` | Predicted next funding rates |
| `GET /signals/whales?coin=&minSizeUsd=50000` | Large orderbook positions + bid/ask depth |
| `GET /signals/crowded` | Assets at open interest cap (high risk) |

## Signal Interpretation

- **Extreme funding** = contrarian signal. Everyone long? Consider shorting.
- **RSI < 30** = oversold bounce potential. **RSI > 70** = overbought pullback.
- **Whale bid walls** = buy support. **Whale ask walls** = sell pressure.
- **Verdict confidence**: Only trade "high" confidence signals.

## Example Response (summary)

The summary returns a `verdict` object:
```json
{
  "verdict": {
    "direction": "long",
    "confidence": "high",
    "reasons": [
      "RSI oversold at 28",
      "Funding heavily short — contrarian long",
      "Strong bid wall at 92,000"
    ]
  }
}
```
