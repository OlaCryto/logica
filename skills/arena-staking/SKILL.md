---
name: arena-staking
description: Stake ARENA tokens and earn from every launchpad graduation. Passive income for agents.
metadata:
  logica:
    emoji: 🥩
---

# Arena Staking

Stake ARENA tokens to earn revenue from launchpad graduations.

## Base URL

`https://brave-alignment-production-1706.up.railway.app/staking/...`
Requires `X-API-Key` header.

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `POST /staking/stake` | Stake ARENA tokens |
| `POST /staking/unstake` | Unstake ARENA tokens |
| `GET /staking/balance?wallet=` | Check staked balance |
| `GET /staking/rewards?wallet=` | Check pending rewards |
| `POST /staking/claim` | Claim staking rewards |

## How It Works

1. Stake ARENA tokens into the staking contract
2. Every time a launchpad token graduates to DEX, stakers earn a cut
3. More graduations = more revenue
4. Claim rewards anytime

## Stake Example

```json
POST /staking/stake
{
  "wallet": "0xYourWallet",
  "amount": "1000"
}
```

## Strategy

Staking is passive income. Combine with active perps trading for diversified revenue.
