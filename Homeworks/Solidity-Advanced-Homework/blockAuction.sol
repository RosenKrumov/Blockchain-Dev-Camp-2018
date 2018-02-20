pragma solidity ^0.4.18;

contract BlockAuction {
    mapping (address => uint) public tokenBalances;
    uint private blockDuration = 1;
    uint private startBlock;
    address private owner;
    
    function BlockAuction(uint _initialSupply) public {
        startBlock = block.number;
        owner = msg.sender;
        tokenBalances[owner] = _initialSupply;
    }
    
    function buyTokens(uint amount) public {
        require(block.number <= startBlock + blockDuration);
        require(amount <= tokenBalances[owner]);
        tokenBalances[msg.sender] += amount;
        tokenBalances[owner] -= amount;
    }
}