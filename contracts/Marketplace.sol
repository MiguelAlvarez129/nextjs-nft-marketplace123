pragma solidity ^0.8.0;

import "./RatherToken.sol";
import "./RatherNFT.sol";

contract Marketplace {

  RatherToken public ratherToken;
  RatherNFT public ratherNft;
  constructor(address ratherTokenAddress, address ratherNftAddress) {
    ratherToken = RatherToken(ratherTokenAddress);
    ratherNft = RatherNFT(ratherNftAddress);
  }

  function settleTransaction(address bidder, bytes memory bidderSignature, bytes32 bidderHash, address owner, bytes memory ownerSignature, bytes32 ownerHash, uint256 amount, uint8 nftId) public returns (bool result){
    bytes32 bidderSignedHash = getSignedEthHash(bidderHash);
    address bidderAddress = recover(bidderSignedHash, bidderSignature);
    require(bidderAddress == bidder, "Invalid Bidder Signature");
    bytes32 ownerSignedHash = getSignedEthHash(ownerHash);
    address ownerAddress = recover(ownerSignedHash,ownerSignature);
    require(ownerAddress == owner, "Invalid owner Signature");
    ratherToken.transferFrom(bidder, owner, amount);
    ratherNft.transferFrom(owner, bidder, nftId);
    return true;
  }

  function getSignedEthHash( bytes32 _hash ) public pure returns (bytes32) {
    return keccak256(abi.encodePacked("\x19Ethereum Signed Message:\n32", _hash));
  }

  function recover(bytes32 _hash, bytes memory _sig) public pure returns (address){
    (bytes32 r, bytes32 s, uint8 v) = _split(_sig);
    return ecrecover(_hash, v, r, s);
  }


  function _split(bytes memory _sign) internal pure returns (bytes32 r, bytes32 s, uint8 v){
    require(_sign.length == 65, "invalid signature length");

    assembly {
      r := mload(add(_sign, 32))
      s := mload(add(_sign, 64))
      v := byte(0, mload(add(_sign, 96)))
    }
  }
}