pragma solidity ^0.4.18;

contract MainContract {
    address internal owner;
    
    function MainContract() public {
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
}

contract ToBeTerminated is MainContract {
    function terminate() public isOwner {
        selfdestruct(msg.sender);
    }
}

