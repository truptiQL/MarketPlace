const hre = require("hardhat");
async function main() {
  const MarketPlace = await hre.ethers.getContractFactory("MarketPlace");
  const marketplace = await MarketPlace.deploy();
  await marketplace.deployed();

  console.log(`MarketPlace deployed to ${marketplace.address}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
