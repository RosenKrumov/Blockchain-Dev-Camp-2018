pragma solidity ^0.4.18;

contract ArrayOfFacts {
    string[] private facts;
    address private contractOwner = msg.sender;
    
    function add(string newFact) public {
        require(msg.sender == contractOwner);
        facts.push(newFact);
    }
    
    function count() public view returns (uint) {
        return facts.length;
    }
    
    function getFact(uint index) public view returns (string) {
        return facts[index];
    }
}