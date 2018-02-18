pragma solidity ^0.4.18;

contract SimpleStorage {
    uint private storedData;
    
    function set(uint value) public {
        storedData = value;
    }
    
    function get() public view returns(uint) {
        return storedData;
    }
}