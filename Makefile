SHELL := /bin/bash

# Load environment variables from .env if present.
ifneq (,$(wildcard .env))
include .env
export
endif

VERIFY_FLAGS :=
ifneq (,$(ETHERSCAN_API_KEY))
VERIFY_FLAGS = --verify --etherscan-api-key $(ETHERSCAN_API_KEY)
endif

.PHONY: anvil deploy-anvil deploy-sepolia mint

# Start a local Anvil node.
anvil:
	anvil

# Deploy to local Anvil (requires PRIVATE_KEY).
deploy-anvil:
	@if [ -z "$(ANVIL_PRIVATE_KEY)" ]; then echo "ANVIL_PRIVATE_KEY is required"; exit 1; fi
	forge script script/ADMNetwork.s.sol:DeployADMNetwork \
		--rpc-url $(ANVIL_RPC_URL) \
		--private-key $(ANVIL_PRIVATE_KEY) \
		--broadcast

# Deploy to Sepolia (requires SEPOLIA_RPC_URL and PRIVATE_KEY).
deploy-sepolia:
	@if [ -z "$(SEPOLIA_RPC_URL)" ]; then echo "SEPOLIA_RPC_URL is required"; exit 1; fi
	@if [ -z "$(SEPOLIA_PRIVATE_KEY)" ]; then echo "SEPOLIA_PRIVATE_KEY is required"; exit 1; fi
	forge script script/ADMNetwork.s.sol:DeployADMNetwork \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--private-key $(SEPOLIA_PRIVATE_KEY) \
		$(VERIFY_FLAGS) \
		--broadcast

# Mint tokens on Sepolia.
mint:
	@if [ -z "$(TOKEN_ADDRESS)" ]; then echo "TOKEN_ADDRESS is required"; exit 1; fi
	@if [ -z "$(MINT_TO)" ]; then echo "MINT_TO is required"; exit 1; fi
	@if [ -z "$(MINT_AMOUNT)" ]; then echo "MINT_AMOUNT is required"; exit 1; fi
	@if [ -z "$(SEPOLIA_RPC_URL)" ]; then echo "SEPOLIA_RPC_URL is required"; exit 1; fi
	@if [ -z "$(SEPOLIA_PRIVATE_KEY)" ]; then echo "SEPOLIA_PRIVATE_KEY is required"; exit 1; fi
	cast send $(TOKEN_ADDRESS) \
		"mint(address,uint256)" \
		$(MINT_TO) $(MINT_AMOUNT) \
		--rpc-url $(SEPOLIA_RPC_URL) \
		--private-key $(SEPOLIA_PRIVATE_KEY)
	
