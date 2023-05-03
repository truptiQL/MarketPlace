// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract nft721 is ERC721 {
    constructor() ERC721("token721", "t721" ) {}

    function mint(address to, uint256 id) external payable {
        _mint(to, id);
    }
}
