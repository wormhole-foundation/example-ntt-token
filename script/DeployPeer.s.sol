// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script, console} from "forge-std/Script.sol";
import "../src/PeerToken.sol";

contract DeployPeer is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address ntt_manager = address(0);
        vm.startBroadcast(deployerPrivateKey);

        PeerToken t = new PeerToken("test_ntt", "TEST_NTT", ntt_manager, msg.sender);

        vm.stopBroadcast();
    }
}

contract SetPeerMinter is Script {
    function setUp() public {}

    function run() public {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        address tokenAddr = 0xa88085E6370a551Cc046fB6B1E3fB9BE23Ac3a21;
        address minterAddr = 0x081d4762aE9D4D51525b8db81865a1691FFA55Ed;

        vm.startBroadcast(deployerPrivateKey);

        // setMinter to the Manager proxy on the spoke/burn chain
        PeerToken t = PeerToken(tokenAddr);
        t.setMinter(minterAddr);

        vm.stopBroadcast();
    }
}
