// SPDX-License-Identifier: Apache 2
pragma solidity >=0.6.12 <0.9.0;

import {ERC20} from "openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";
import {ERC20Burnable} from "openzeppelin-contracts/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import {BaseToken} from "src/BaseToken.sol";
import {Ownable} from "openzeppelin-contracts/contracts/access/Ownable.sol";

contract PeerToken is BaseToken, ERC20Burnable, Ownable {
    error CallerNotMinter(address caller);
    error InvalidMinterZeroAddress();

    event NewMinter(address newMinter);

    address public minter;

    modifier onlyMinter() {
        if (msg.sender != minter) {
            revert CallerNotMinter(msg.sender);
        }
        _;
    }

    constructor(string memory _name, string memory _symbol, address _minter, address _owner)
        BaseToken(_name, _symbol)
        Ownable(_owner)
    {
        minter = _minter;
    }

    function mint(address _account, uint256 _amount) external onlyMinter {
        _mint(_account, _amount);
    }

    function setMinter(address newMinter) external onlyOwner {
        if (newMinter == address(0)) {
            revert InvalidMinterZeroAddress();
        }
        minter = newMinter;
        emit NewMinter(newMinter);
    }

    function _update(address _from, address _to, uint256 _value) internal override(ERC20, BaseToken) {
        return BaseToken._update(_from, _to, _value);
    }
}
