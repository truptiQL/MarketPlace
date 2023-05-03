// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "hardhat/console.sol";

contract nft1155 is ERC1155 {
    constructor() ERC1155("trupti") {}

    function mint(address to, uint256 id, uint256 amount) external payable {
        _mint(to, id, amount, "");
    }

    function SafeTransferFrom(address from, address to, uint256  _tokenid, uint256 _noOfAssets, bytes calldata data) public {
        console.log("from", from);
        console.log("to", to);
        safeTransferFrom(from, to, _tokenid, _noOfAssets, data);

    }
}
