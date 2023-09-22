pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract RatherToken is ERC20 {
    address private _owner;
    constructor() ERC20 ("RatherToken", "RTN") {
        _owner = msg.sender;
        _mint(_owner, 10000 * (10 ** decimals()));
    } 

    function owner() public view virtual returns (address) {
        return _owner;
    } 

    function mintNewBidder(address to) public {
        _mint(to , 100 * (10 ** decimals()));
    } 
}