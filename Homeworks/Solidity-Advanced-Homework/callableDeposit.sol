pragma solidity ^0.4.18;

contract CallableDeposit {
    address private owner;
    
    function CallableDeposit() public {
        owner = msg.sender;
    }
    
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function getBalance() public view isOwner returns(uint) {
        return this.balance;
    }
    
    function deposit() public payable {
        
    }
    
    function sendBalance(address addr) public isOwner {
        selfdestruct(addr);
    }
}

contract NoPayable {
    address private owner;
    
    function NoPayable() public {
        owner = msg.sender;
    }
    
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function getBalance() public view isOwner returns(uint) {
        return this.balance;
    }
    
    
}