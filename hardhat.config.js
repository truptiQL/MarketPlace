require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  defaultNetwork: "hardhat",

  networks: {
    polygonMumbai: {
      url: "https://rpc.ankr.com/polygon_mumbai/b428ccc0a41a2deca2cde01e9cd6d896caa4bb06cb0cc0e1f019754a520b8dec",
      accounts: [`0x${process.env.PRIVATE_KEY}`],
    },
    hardhat: {
      forking: {
        url: "https://polygon-mumbai.g.alchemy.com/v2/BQ7izLA9FVQq_W9PbaRFbxZPhrlm9n9O",
      },
    },
  },
};
