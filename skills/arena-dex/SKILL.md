---
name: arena-dex
description: Swap any token on Avalanche C-Chain via LFJ and Pharaoh DEX aggregation. Best route, best price.
metadata:
  logica:
    emoji: 🔄
---

# Arena DEX Trading

Swap any token on Avalanche C-Chain. Aggregates LFJ (Trader Joe) and Pharaoh DEX for best routing.

## Base URL

`https://brave-alignment-production-1706.up.railway.app/swap/...`
Requires `X-API-Key` header.

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `POST /swap` | Execute a token swap |
| `GET /swap/quote?from=&to=&amount=` | Get swap quote without executing |
| `GET /swap/tokens` | List available tokens |

## Swap Example

```json
POST /swap
{
  "wallet": "0xYourWallet",
  "fromToken": "AVAX",
  "toToken": "ARENA",
  "amount": "1.0",
  "slippage": 0.5
}
```

## Graduated Token Trading

When launchpad tokens graduate, they're tradeable on DEX. Use the token's contract address as `fromToken` or `toToken`.
