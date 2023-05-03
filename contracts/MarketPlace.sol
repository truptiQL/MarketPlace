// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "hardhat/console.sol";
import "./token20.sol";
import "./nft1155.sol";
import "./nft721.sol";

contract MarketPlace {
    struct TokenDetails {
        address addOfContract;
        bool isERC1155;
        uint256 tokenId;
        uint256 noOfAssets;
        uint256 price;
        address addOfERC20;
        string payment;
        address owner;
    }

    mapping(uint256 => bool) private isRegistered;
    mapping(uint256 => TokenDetails) private registeredToken;
    mapping(uint256 => address) registeredTokenOwner;
    uint256 public balance;
    address public immutable marketplace = address(this);

    TokenDetails private tokenDetail;

    event TokenRegistered(uint256 _tokenId, address owner);
    event buyToken(uint256 _tokenId, address buyer);

    /// It is for ERC1155 token

    function registerERC1155Token(
        address _addOf1155Contract,
        uint256 _tokenId,
        uint256 _noOfAsset,
        uint256 _price,
        address _addOfERC20,
        string calldata _payment
    ) public returns (bool) {
        nft1155 token1155 = nft1155(_addOf1155Contract);
        tokenDetail.tokenId = _tokenId;
        balance = token1155.balanceOf(msg.sender, _tokenId);

        require(balance >= _noOfAsset, "Not having required number of assets");

        tokenDetail.addOfContract = _addOf1155Contract;
        tokenDetail.tokenId = _tokenId;
        tokenDetail.noOfAssets = _noOfAsset;
        tokenDetail.price = _price;
        tokenDetail.addOfERC20 = _addOfERC20;
        tokenDetail.isERC1155 = true;
        tokenDetail.owner = msg.sender;

        tokenDetail.payment = _payment;

        isRegistered[_tokenId] = true;

        registeredToken[_tokenId] = tokenDetail;

        emit TokenRegistered(_tokenId, _addOf1155Contract);
        return true;
    }

    /// for 721 token
    function registerERC721Token(
        address _addOf721Contract,
        uint256 _tokenId,
        uint256 _price,
        address _addOfERC20,
        string calldata _payment
    ) public returns (bool) {
        nft721 token721 = nft721(_addOf721Contract);
        require(token721.ownerOf(_tokenId) == msg.sender);

        tokenDetail.addOfContract = _addOf721Contract;
        tokenDetail.tokenId = _tokenId;
        tokenDetail.noOfAssets = 1;
        tokenDetail.price = _price;
        tokenDetail.addOfERC20 = _addOfERC20;
        tokenDetail.isERC1155 = false;
        tokenDetail.owner = msg.sender;

        /// _payment can be WETH or ETH
        tokenDetail.payment = _payment;

        isRegistered[_tokenId] = true;

        // token721.approve(address(this), _tokenId);
        registeredToken[_tokenId] = tokenDetail;

        emit TokenRegistered(_tokenId, msg.sender);
        return true;
    }

    ///  payToken address of token from which payment will be done
    /// @param _token20 using which erc20 token user want to buy
    /// @param _tokenid  which specific token buyer wants to buy
    /// @param _price  How much price buyer is ready to give for all tokens he wants to buy
    /// @param  _noOfAssets Number of tokens to be purchased
    function buy(
        address _token20,
        uint256 _tokenid,
        uint256 _noOfAssets,
        uint256 _price
    ) public payable returns (bool) {
        require(isRegistered[_tokenid], "token is not registered");
        require(_noOfAssets <= registeredToken[_tokenid].noOfAssets);
        uint256 pricePerToken = _price / _noOfAssets;
        require(
            registeredToken[_tokenid].price <= pricePerToken,
            "Not a acceptable price"
        );

        token20 Token20;
        if (_token20 != address(0)) {
            Token20 = token20(_token20);
            require(
                _token20 == registeredToken[_tokenid].addOfERC20,
                "Different address"
            );
        } else {
            // Mumbai WETH address
            Token20 = token20(0xA6FA4fB5f76172d178d61B04b0ecd319C5d1C0aa);
        }
        address seller = registeredToken[_tokenid].owner;

        if (registeredToken[_tokenid].isERC1155) {
            nft1155 sellerToken = nft1155(
                registeredToken[_tokenid].addOfContract
            );

            sellerToken.SafeTransferFrom(
                seller,
                msg.sender,
                _tokenid,
                _noOfAssets,
                ""
            );
        } else {
            nft721 sellerToken = nft721(
                registeredToken[_tokenid].addOfContract
            );
            sellerToken.safeTransferFrom(seller, msg.sender, _tokenid);
        }
        Token20.TransferFrom(msg.sender, seller, _price);

        if (registeredToken[_tokenid].noOfAssets - _noOfAssets == 0) {
            isRegistered[_tokenid] = false;
        } else {
            registeredToken[_tokenid].noOfAssets -= _noOfAssets;
        }

        emit buyToken(_tokenid, msg.sender);
        return true;
    }
}
