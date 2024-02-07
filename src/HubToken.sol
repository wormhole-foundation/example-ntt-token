// SPDX-License-Identifier: Apache 2
pragma solidity >=0.6.12 <0.9.0;

import {BaseToken} from "src/BaseToken.sol";

contract HubToken is BaseToken {
    constructor(string memory _name, string memory _symbol) BaseToken(_name, _symbol) {
        _mint(msg.sender, MAX_SUPPLY);
    }
}
