# ADMNetwork ERC-20 Token

This repo contains a simple ERC-20 token (`ADMN`) built with Foundry, plus scripts and Makefile targets for local and Sepolia deployments.

## Prerequisites

- [Foundry](https://book.getfoundry.sh/)

## Quick Start

### Build

```shell
forge build
```

### Test

```shell
forge test
```

### Start Anvil (Local Node)

```shell
make anvil
```

### Deploy to Anvil

```shell
make deploy-anvil ANVIL_PRIVATE_KEY=0x...
```

### Deploy to Sepolia

```shell
make deploy-sepolia SEPOLIA_RPC_URL=https://... SEPOLIA_PRIVATE_KEY=0x...
```

### Mint Tokens (Sepolia)

```shell
make mint TOKEN_ADDRESS=0x... MINT_TO=0x... MINT_AMOUNT=1000000000000000000
```

## Environment Variables

You can also put these in a `.env` file (auto-loaded by the Makefile).

```shell
ANVIL_RPC_URL=http://127.0.0.1:8545
ANVIL_PRIVATE_KEY=0x...
SEPOLIA_RPC_URL=https://...
SEPOLIA_PRIVATE_KEY=0x...
ETHERSCAN_API_KEY=your_key_here
```

## Deployment Output

After deployment, the latest address is written to:

- `deployments/latest.json`

## Notes

- Default token symbol is `ADMN`.
- Decimals is `18`.

## Foundry Reference

### Format

```shell
forge fmt
```

### Gas Snapshots

```shell
forge snapshot
```

### Cast

```shell
cast <subcommand>
```

### Help

```shell
forge --help
anvil --help
cast --help
```
