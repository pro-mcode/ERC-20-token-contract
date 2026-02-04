// SPDX-License-Identifier: SEE LICENSE IN LICENSE
// Tests for ADMNetwork token.
pragma solidity ^0.8.26;

import { Test } from "forge-std/Test.sol";
import { ADMNetwork } from "../src/ADMNetwork.sol";

// Basic minting and access-control tests.
contract ADMNetworkTest is Test {
    // Token under test.
    ADMNetwork private token;
    // Addresses used in tests.
    address private minter;
    address private maxwell;

    function setUp() public {
        // Deployer is the minter by default.
        minter = address(this);
        maxwell = address(0xBEEF);
        token = new ADMNetwork();
    }

    function testMintByMinterIncreasesSupplyAndBalance() public {
        // Mint as minter and verify balances.
        token.mint(maxwell, 100 ether);
        assertEq(token.totalSupply(), 100 ether);
        assertEq(token.balanceOf(maxwell), 100 ether);
    }

    function testMintByNonMinterReverts() public {
        // Non-minter should revert on mint.
        address outsider = address(0xCAFE);
        vm.prank(outsider);
        vm.expectRevert("ADMNetwork: not minter");
        token.mint(maxwell, 1 ether);
    }
}
