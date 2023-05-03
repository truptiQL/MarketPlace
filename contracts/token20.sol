// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;
import "hardhat/console.sol";

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract token20 is  ERC20 {
    constructor() ERC20("token20" , "t20"){    }

    function mint(address account, uint256 amount) public {
        _mint(account, amount);
    }

    function Approve(address acc, uint256 amount) public{
        approve(acc, amount);
    }

    function TransferFrom(address from, address to, uint256 amount )public {
        transferFrom(from, to, amount);
        
    }
}