// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/SpokeToken.sol";

contract DeployHub is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address ntt_manager = address(0);
        vm.startBroadcast(deployerPrivateKey);

        SpokeToken t = new SpokeToken("test_ntt", "TEST_NTT", ntt_manager, msg.sender);

        vm.stopBroadcast();
    }
}
