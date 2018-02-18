pragma solidity ^0.4.18;

contract SimpleToken {
    mapping (address => uint) public balanceOf;
    
    function SimpleToken(uint initialSupply) public {
        balanceOf[msg.sender] = initialSupply;
    }
    
    function transfer(address recipient, uint amount) public {
        require(balanceOf[msg.sender] >= amount);
        require(balanceOf[recipient] + amount >= balanceOf[recipient]);
        balanceOf[msg.sender] -= amount;
        balanceOf[recipient] += amount;
    }
}