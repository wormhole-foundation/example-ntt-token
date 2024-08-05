// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Script} from "forge-std/Script.sol";
import "../src/PeerToken.sol";

// example script to mint tokens after for example a token deployment with forge
contract MintPeerTokens is Script {
    function run() public {
        uint256 minterPrivateKey = vm.envUint("ETH_MINT_PRIVATE_KEY"); // private key from Metamask needs '0x' to be prefixed
        address tokenAddr = 0x742d35Cc6634C0532925a3b844Bc454e4438f44e;  // Replace with your token contract address
        address recipient = 0x5aAeb6053F3E94C9b9A09f33669435E7Ef1BeAed;  // Replace with the recipient address
        uint256 amount = 1000 * 10 ** 18;      // Adjust the amount to mint

        vm.startBroadcast(minterPrivateKey);

        PeerToken t = PeerToken(tokenAddr);
        t.mint(recipient, amount);

        vm.stopBroadcast();
    }
}