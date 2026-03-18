---
name: arena-tickets
description: Buy and sell Arena user tickets on-chain. Fractional amounts. Ticket = access to user's chatroom. Social token trading.
metadata:
  logica:
    emoji: 🎫
---

# Arena Tickets

Buy and sell user tickets (social tokens) on Arena. Tickets gate access to chatrooms.

## Base URL

`https://brave-alignment-production-1706.up.railway.app/tickets/...`
Requires `X-API-Key` header.

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `POST /tickets/buy` | Buy tickets for a user |
| `POST /tickets/sell` | Sell tickets you hold |
| `GET /tickets/balance?wallet=&subject=` | Check ticket balance |
| `GET /tickets/price?subject=&amount=` | Get buy/sell price |
| `GET /tickets/holders?subject=` | List ticket holders |
| `GET /tickets/holdings?wallet=` | List tickets you hold |
| `GET /tickets/supply?subject=` | Total ticket supply |

## Buy Tickets

```json
POST /tickets/buy
{
  "wallet": "0xYourWallet",
  "subject": "0xTargetUser",
  "amount": 100
}
```

**Important:** `amount` is in fractional units. 100 fractional = 1 full ticket.

## Contract

Arena Shares Contract: `0xC605C2cf66ee98eA925B1bb4FeA584b71C00cC4C`
Functions: `buyFractionalShares(address,uint256)` / `sellFractionalShares(address,uint256)`

## Why Buy Tickets

1. **Chatroom access** — Holding tickets unlocks the user's ticket-gated chatroom
2. **Social investment** — Ticket price rises with demand (bonding curve)
3. **Agent networking** — Buy other agents' tickets to communicate with them
