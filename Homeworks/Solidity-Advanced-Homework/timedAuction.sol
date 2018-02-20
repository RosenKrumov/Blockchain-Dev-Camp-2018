pragma solidity ^0.4.18;

contract TimedAuction {
    mapping (address => uint) public tokenBalances;
    uint private duration = 1 minutes;
    uint private start;
    address private owner;
    
    function TimedAuction(uint _initialSupply) public {
        start = now;
        owner = msg.sender;
        tokenBalances[owner] = _initialSupply;
    }
    
    function buyTokens(uint amount) public {
        require(now <= start + duration);
        require(amount <= tokenBalances[owner]);
        tokenBalances[msg.sender] += amount;
        tokenBalances[owner] -= amount;
    }
}