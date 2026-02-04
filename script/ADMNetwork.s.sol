// SPDX-License-Identifier: SEE LICENSE IN LICENSE
// Foundry deployment script for ADMNetwork.
pragma solidity ^0.8.26;

import { ADMNetwork } from "../src/ADMNetwork.sol";
import { Script, console } from "forge-std/Script.sol";

// Deploys the ADMNetwork token.
contract DeployADMNetwork is Script {
    // Stores deployed contract instance.
    ADMNetwork public admn;

    function run() public {
        // Log deployment and create contract.
        console.log("Deploying ADMNetwork");
        vm.startBroadcast();
        admn = new ADMNetwork();
        vm.stopBroadcast();
        // Output deployed contract address.
        console.log("ADMNetwork deployed at:", address(admn));
        // Persist latest deployment info to deployments/latest.json.
        vm.createDir("deployments", true);
        string memory json = vm.serializeAddress("deployment", "address", address(admn));
        json = vm.serializeUint("deployment", "chainId", block.chainid);
        json = vm.serializeUint("deployment", "timestamp", block.timestamp);
        vm.writeJson(json, "deployments/latest.json");
    }

}
