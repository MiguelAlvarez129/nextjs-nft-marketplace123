let RatherTokenContract = artifacts.require("RatherToken.sol");
let RatherNFT = artifacts.require("RatherNFT.sol");
let Marketplace = artifacts.require("Marketplace.sol");

module.exports = async function (deployer) {
  await deployer.deploy(RatherTokenContract)
  await deployer.deploy(RatherNFT)

  let ratherTokenDeployed = await artifacts.require("RatherToken.sol")
  let ratherNftDeployed = await artifacts.require("RatherNFT.sol")

  await deployer.deploy(Marketplace, ratherTokenDeployed.address, ratherNftDeployed.address)
};
