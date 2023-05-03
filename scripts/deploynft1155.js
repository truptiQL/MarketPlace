const hre = require("hardhat");
async function main() {
  const nft1155 = await hre.ethers.getContractFactory("nft1155");
  const _nft1155 = await nft1155.deploy();
  await _nft1155.deployed();

  console.log(`nft1155 deployed to ${_nft1155.address}`);
  console.log(await _nft1155.uri(1));
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
