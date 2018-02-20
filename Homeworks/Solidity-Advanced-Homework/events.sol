pragma solidity ^0.4.18;

contract Events {
    event _showAddress(address);
    
    address private owner;
    
    function Events() public {
        owner = msg.sender;
    }
    
    function showAddress() public {
        _showAddress(owner);
    }
}