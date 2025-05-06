# Multichain Token Contracts

This repository contains smart contracts for implementing multichain token deployments using two different models: Hub and Spoke, and Burn and Mint.

## Contracts

### HubToken

`HubToken` is designed for the Hub and Spoke model. It represents the central token on the hub chain where the total supply is maintained.

### PeerToken

`PeerToken` is a flexible contract that can be deployed as either a spoke token in the Hub and Spoke model or as a token in the Burn and Mint model.

## Read more about deployment models

[Deployment Models](https://docs.wormhole.com/wormhole/native-token-transfers/overview/deployment-models) 

## Usage

### Hub and Spoke Model

1. Deploy `HubToken` on the main chain (Hub chain).
2. Deploy `PeerToken` on each spoke chain.
3. Configure the minter address in each `PeerToken` to control minting permissions.

### Burn and Mint Model

1. Deploy `PeerToken` contracts on all participating chains.
2. Configure the minter address in each `PeerToken` to control minting permissions.

## Deployment

To deploy these contracts, you can use Forge. Here's an example of how to deploy the PeerToken contract using forge:

[Install Foundry](https://book.getfoundry.sh/getting-started/installation)

```bash
forge create --broadcast --rpc-url <SEPOLIA_RPC_URL> --private-key <PRIVATE_KEY> src/PeerToken.sol:PeerToken --constructor-args "TestBurnToken" "TBT" <MINTER_ADDRESS> <OWNER_ADDRESS>
```

## Mint Tokens
After deployment, you can mint tokens using the cast send command from Foundry:

```bash
cast send $TOKEN_ADDRESS \
  "mint(address,uint256)" \
  $RECIPIENT_ADDRESS \
  $AMOUNT_IN_WEI \  
  --private-key $ETH_PRIVATE_KEY \
  --rpc-url $YOUR_RPC_URL
```

For 1000 tokens with 18 decimals, use AMOUNT_IN_WEI = 1000000000000000000000
