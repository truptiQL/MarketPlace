const hre = require("hardhat");
async function main() {
  const token20 = await hre.ethers.getContractFactory("token20");
  const _token20 = await token20.deploy();
  await _token20.deployed();

  console.log(`token20 deployed to ${_token20.address}`);
  console.log(await _token20.name());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
