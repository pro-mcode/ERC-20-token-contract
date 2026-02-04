// SPDX-License-Identifier: SEE LICENSE IN LICENSE
// Simple ERC20 token with role-based minting.
pragma solidity ^0.8.26;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import { AccessControl } from "@openzeppelin/contracts/access/AccessControl.sol";

// Token contract with AccessControl to restrict minting.
contract ADMNetwork is ERC20, AccessControl {

    // Role identifier for accounts allowed to mint new tokens.
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");

    // Set token name/symbol and grant admin + minter roles to deployer.
    constructor() ERC20("ADMNetwork", "ADMN") {
       _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
       _grantRole(MINTER_ROLE, msg.sender);
    }

    // Mint new tokens to `to` if caller has the minter role.
    function mint(address to, uint256 amount) public {
        require(hasRole(MINTER_ROLE, msg.sender), "ADMNetwork: not minter");
        _mint(to, amount);
    }

    
}
