pragma solidity ^0.4.18;

contract EventsWithIndexedParameters {
    event _showInformation(string indexed name, string indexed email);
    
    function showInformation(string name, string email) public {
        _showInformation(name, email);
    }
}