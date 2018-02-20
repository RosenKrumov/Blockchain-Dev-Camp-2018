pragma solidity ^0.4.18;

contract CompanyShares {
    address private owner;
    uint private sharePrice;
    uint private dividend;
    mapping (address => uint) private sharesPerAddress;
    mapping (address => bool) private addressAllowedToWithdrawFunds;
    address[] private shareHolders;
    
    function CompanyShares(uint _initialSupply, uint _pricePerShare, uint _dividend) public {
        owner = msg.sender;
        sharesPerAddress[owner] = _initialSupply;
        sharePrice = _pricePerShare * 1 ether;
        dividend = _dividend * 1 ether;
    }
    
    function getPricePerShare() public view returns(uint) {
        return sharePrice / 1 ether;
    }
    
    function calculateTransactionWorth(uint amount) public view returns(uint) {
        return (amount * sharePrice) / 1 ether;
    }
    
    function buyShares(uint amount) public payable {
        require(sharesPerAddress[owner] >= amount);
        require(sharesPerAddress[msg.sender] + amount >= sharesPerAddress[msg.sender]);
        require(msg.value == amount * sharePrice);
        sharesPerAddress[owner] -= amount;
        sharesPerAddress[msg.sender] += amount;
        shareHolders.push(msg.sender);
    }
    
    function getShareHolders() public view returns(address[])
    {
        require(msg.sender == owner);
        return shareHolders;
    }
    
    function allowWithdraw(address addr) public {
        require(msg.sender == owner);
        addressAllowedToWithdrawFunds[addr] = true;
    }
    
    function depositEarnings() public payable {
        require(msg.sender == owner);
    }
    
    function getBalance() public view returns(uint) {
        require(msg.sender == owner);
        return this.balance / 1 ether;
    }
    
    function getNumberOfShares(address addr) public view returns(uint) {
        require(msg.sender == addr || msg.sender == owner);
        return sharesPerAddress[addr];
    }
    
    function withdraw() public {
        require(sharesPerAddress[msg.sender] > 0);
        require(this.balance >= sharesPerAddress[msg.sender] * dividend);
        require(addressAllowedToWithdrawFunds[msg.sender] == true);
        msg.sender.transfer(sharesPerAddress[msg.sender] * dividend);
        addressAllowedToWithdrawFunds[msg.sender] = false;
    }
}