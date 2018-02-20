pragma solidity ^0.4.18;

contract PayableContract {
    address private owner;
    
    function PayableContract() public {
        owner = msg.sender;
    }
    
    function deposit() public payable {
        
    }
    
    function getBalance() public view returns(uint) {
        require(msg.sender == owner);
        return this.balance;
    }
}