---
name: arena-perps
description: Trade 250+ perpetual futures markets via Arena's Hyperliquid integration. Long/short, leverage up to 50x, TP/SL, market and limit orders.
metadata:
  logica:
    emoji: 📈
---

# Arena Perpetual Trading

Trade perpetual futures through Arena's API on Hyperliquid. 250+ markets, up to 50x leverage.

## Base URL

All endpoints use Arena's API: `https://api.starsarena.com`
Agent endpoints: `/agents/perp/...` with `x-api-key` header.

Or use Logiqical proxy: `https://brave-alignment-production-1706.up.railway.app/perp/...`

## Setup Flow

1. `POST /agents/perp/register` — Create API wallet (`{"provider": "HYPERLIQUID"}`)
2. Complete 5-step auth flow (accept terms, approve agent, set referrer, approve builder fee, enable HIP-3)
3. Deposit USDC to Hyperliquid on Arbitrum (address: `0x2Df1c51E09aECF9cacB7bc98cB1742757f163dF7`)
4. `POST /agents/perp/leverage/update` — Set leverage before first trade

## Trading Endpoints

| Action | Method | Endpoint |
|--------|--------|----------|
| Get markets | GET | `/agents/perp/trading-pairs` |
| Place order | POST | `/agents/perp/orders/place` |
| Cancel order | POST | `/agents/perp/orders/cancel` |
| Modify order | POST | `/agents/perp/orders/modify` |
| Close position | POST | `/agents/perp/orders/close-position` |
| Get orders | GET | `/agents/perp/orders` |
| Get executions | GET | `/agents/perp/trade-executions` |
| Update leverage | POST | `/agents/perp/leverage/update` |

## Order Params

```json
{
  "provider": "HYPERLIQUID",
  "symbol": "BTC",
  "direction": "long",
  "orderType": "market",
  "leverageType": "cross",
  "size": 0.001,
  "marginAmount": 50,
  "assetId": "0",
  "initialMarginAssetId": "USDC",
  "leverage": 20,
  "price": 95000
}
```

**Key fields:** symbol (from trading-pairs), direction (long/short), orderType (market/limit), size, leverage, price.

Attach TP/SL with `takeProfitOrders` and `stopLossOrders` arrays.

## Rate Limits

- Place orders: 120/hour
- Cancel: 240/hour
- GET requests: 100/minute
- Global: 1000/hour

## Best Practices

1. Always check `/signals/summary` before trading
2. Set stop-losses on every position
3. Never risk more than 5% per trade
4. Use `/agents/perp/trading-pairs` to get correct symbol, assetId, and precision
