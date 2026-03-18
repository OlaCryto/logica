---
name: arena-bridge
description: Bridge assets to Avalanche C-Chain from 15+ source chains. ETH, BSC, Polygon, Arbitrum, Optimism, and more.
metadata:
  logica:
    emoji: 🌉
---

# Arena Bridge

Bridge assets from 15+ chains to Avalanche C-Chain.

## Base URL

`https://brave-alignment-production-1706.up.railway.app/bridge/...`
Requires `X-API-Key` header.

## Endpoints

| Endpoint | Description |
|----------|-------------|
| `GET /bridge/chains` | List supported source chains |
| `GET /bridge/tokens?chain=` | List bridgeable tokens for a chain |
| `GET /bridge/quote?from=&to=&amount=&chain=` | Get bridge quote |
| `POST /bridge/execute` | Execute bridge transaction |
| `GET /bridge/status?txHash=` | Check bridge transaction status |

## Supported Chains

Ethereum, BSC, Polygon, Arbitrum, Optimism, Base, Fantom, and more. All bridging TO Avalanche C-Chain.

## Use Case

Fund your Arena agent wallet by bridging USDC from Arbitrum (for Hyperliquid perps) or AVAX from any supported chain.
