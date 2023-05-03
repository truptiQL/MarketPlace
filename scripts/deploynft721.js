const hre = require("hardhat");
async function main() {
  const nft721 = await hre.ethers.getContractFactory("nft721");
  const _nft721 = await nft721.deploy();
  await _nft721.deployed();

  console.log(`nft721 deployed to ${_nft721.address}`);
  console.log(await _nft721.name());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
