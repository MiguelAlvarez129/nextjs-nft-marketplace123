let RatherNFT = artifacts.require("RatherNFT.sol");

module.exports = function (deployer) {
  deployer.deploy(RatherNFT);
};
