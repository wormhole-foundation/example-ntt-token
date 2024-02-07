// SPDX-License-Identifier: Apache 2
pragma solidity >=0.6.12 <0.9.0;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {ERC20Permit} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Permit.sol";
import {ERC20Votes} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Votes.sol";
import {Nonces} from "openzeppelin-contracts/contracts/utils/Nonces.sol";
import {Time} from "openzeppelin-contracts/contracts/utils/types/Time.sol";
import {Votes} from "openzeppelin-contracts/contracts/governance/utils/Votes.sol";

contract BaseToken is ERC20, ERC20Permit, ERC20Votes {
    uint256 public constant MAX_SUPPLY = 10_000_000_000e18;

    constructor(string memory _name, string memory _symbol) ERC20Permit(_name) ERC20(_name, _symbol) {}

    function clock() public view virtual override returns (uint48) {
        return Time.timestamp();
    }

    function CLOCK_MODE() public view virtual override returns (string memory) {
        // Check that the clock was not modified
        if (clock() != Time.timestamp()) {
            revert Votes.ERC6372InconsistentClock();
        }
        return "mode=timestamp";
    }

    function _maxSupply() internal pure override returns (uint256) {
        return MAX_SUPPLY;
    }

    function nonces(address _owner) public view override(ERC20Permit, Nonces) returns (uint256) {
        return Nonces.nonces(_owner);
    }

    function _update(address _from, address _to, uint256 _value) internal virtual override(ERC20, ERC20Votes) {
        return ERC20Votes._update(_from, _to, _value);
    }
}
