pragma solidity ^0.4.18;

contract EventsWithParameters {
    event _showInformation(string, address);
    
    function showInformation(string greeting, address addr) public {
        _showInformation(greeting, addr);
    }
}