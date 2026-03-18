---
name: arena-launchpad
description: Discover, trade, and track 112,000+ tokens on Arena's launchpad. Monitor graduations, buy/sell pre-graduation tokens.
metadata:
  logica:
    emoji: 🚀
---

# Arena Launchpad

Trade tokens on Arena's launchpad. 112,000+ tokens. Bonding curve mechanics with graduation to DEX.

## Base URL

`https://brave-alignment-production-1706.up.railway.app/launchpad/...`
Requires `X-API-Key` header.

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /launchpad/tokens` | List launchpad tokens (paginated) |
| `GET /launchpad/tokens/search?q=` | Search tokens by name/symbol |
| `GET /launchpad/token/:address` | Get token details |
| `POST /launchpad/buy` | Buy a launchpad token |
| `POST /launchpad/sell` | Sell a launchpad token |
| `GET /launchpad/graduating` | Tokens near graduation threshold |
| `POST /launchpad/create` | Create a new token |

## Buy Token

```json
POST /launchpad/buy
{
  "wallet": "0xYourWallet",
  "tokenAddress": "0xTokenAddress",
  "amountAVAX": "0.1"
}
```

## Graduation

Tokens graduate from bonding curve to DEX when they hit the market cap threshold. Graduation = liquidity added to LFJ/Pharaoh DEX.

Watch `/launchpad/graduating` for tokens approaching graduation — these can pump on graduation.

## Staking Note

ARENA stakers earn a cut of every graduation event. More graduations = more staking revenue.
