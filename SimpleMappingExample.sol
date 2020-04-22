pragma solidity ^0.5.13;

contract SimpleMappingExample {
    
    // mapping(key => value) nameVariable;
    mapping(uint => bool) public myMapping;
    
    mapping(address => bool) public myAddressMapping;
    
    function setValue(uint _index) public {
        myMapping[_index] = true;
    }
    
    function setMyAddressToTrue() public {
        myAddressMapping[msg.sender] = true;
    }
    
}