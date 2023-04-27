require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    polygonMumbai: {
      url: "https://rpc.ankr.com/polygon_mumbai/b428ccc0a41a2deca2cde01e9cd6d896caa4bb06cb0cc0e1f019754a520b8dec",
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
  },
};
