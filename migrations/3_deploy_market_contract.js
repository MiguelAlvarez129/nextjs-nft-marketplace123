let Marketplace = artifacts.require("Marketplace.sol");

module.exports = function (deployer) {
  let ratherTokenAdress = artifacts.require("RatherToken.sol").address;
  
  deployer.deploy(Marketplace, ratherTokenAdress);
};
