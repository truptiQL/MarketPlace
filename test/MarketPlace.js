const { expect } = require("chai");
const hre = require("hardhat");
const { ethers } = require("hardhat");
const chai = require("chai");

describe("MarketPlace", async function () {
    beforeEach(async function () {
        /// @dev deploying code 
        const MarketPlace = await hre.ethers.getContractFactory("MarketPlace");
        const marketplace = await MarketPlace.deploy();
        await marketplace.deployed();
    });

    describe("RegisterERC1155 Token", function () {
        it("should be ", async function() {
            expect().to.eql();
        })
    })
})