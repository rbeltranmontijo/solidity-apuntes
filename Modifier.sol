pragma solidity ^0.5.11;
import "./Owned.sol";

contract InheritanceModifierExample is Owned {
    
    mapping(address => uint) public tokenBalance;
    
    constructor() public {
        tokenBalance[owner] = 100;
    }
  
    uint tokenPrice = 1 ether;
    
    function createNewToken() public onlyOwner {
        tokenBalance[owner]++;
    }
    
    function burnToken() public onlyOwner {
        require(tokenBalance[owner] != 0, "Balance en cero");
        tokenBalance[owner]--;
    }
    
    function purchaseToken() public payable {
        require((tokenBalance[owner] * tokenPrice) / msg.value > 0, "No hay suficientes tokens");
        tokenBalance[owner] -= msg.value / tokenPrice;
        tokenBalance[msg.sender] += msg.value / tokenPrice;
    }
}