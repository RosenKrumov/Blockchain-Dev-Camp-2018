pragma solidity ^0.4.18;

contract FallbackExercise {
    address private owner;
    
    function FallbackExercise() public {
        owner = msg.sender;
    }
    
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function deposit() public payable {
        
    }
    
    function getBalance() public view isOwner returns(uint) {
        return this.balance;
    }
    
    function transfer(address addr, uint amount) public isOwner {
        require(amount <= this.balance);
        addr.transfer(amount);
    }
}

contract RecipientContract {
    address private owner;
    
    function RecipientContract() public {
        owner = msg.sender;
    }
    
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    
    function() public payable {
        
    }
    
    function getBalance() public view isOwner returns(uint) {
        return this.balance;
    }
}