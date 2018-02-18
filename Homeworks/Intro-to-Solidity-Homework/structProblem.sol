pragma solidity ^0.4.18;

contract StructProblem {
    struct Account {
        string name;
        address addr;
        string email;
    }
    
    Account[] private accounts;
    address private owner;
    
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier isProperUser(address addr) {
        require(msg.sender == addr);
        _;
    }
    
    function StructProblem() public {
        owner = msg.sender;
    }
    
    function create(string name, address addr, string email) public isProperUser(addr) {
        accounts.push(Account(name, addr, email));
    }
    
    function get(uint index) public view isOwner returns(string, address, string) {
        Account memory acc = accounts[index];
        return(acc.name, acc.addr, acc.email);
    }
}