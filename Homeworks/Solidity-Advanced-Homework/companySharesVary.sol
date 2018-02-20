pragma solidity ^0.4.18;

contract CompanyShares {
    address private owner;
    uint private sharePrice;
    uint private dividend;
    uint private sharePriceChangeStep = 2 ether;
    uint private dividendPriceChangeStep = 1 ether;
    mapping (address => uint) private sharesPerAddress;
    mapping (address => bool) private addressAllowedToWithdrawFunds;
    address[] private shareHolders;
    
    function CompanyShares(uint _initialSupply, uint _pricePerShare, uint _dividend) public {
        owner = msg.sender;
        sharesPerAddress[owner] = _initialSupply;
        sharePrice = _pricePerShare * 1 ether;
        dividend = _dividend * 1 ether;
    }
    
    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }
    
    modifier isOwnerOrAddressHolder(address addr) {
        require(msg.sender == addr || msg.sender == owner);
        _;
    }
    
    modifier checkOverflow(uint baseNum, uint amount) {
        require(baseNum + amount >= baseNum);
        _;
    }
    
    modifier checkIfDecreasePossible(uint baseNum, uint amount) {
        require(baseNum >= amount);
        _;
    }
    
    modifier hasEnoughRemainingShares(uint amount) {
        require(sharesPerAddress[owner] >= amount);
        _;
    }
    
    modifier addressSendsEnoughMoney(uint amount) {
        require(msg.value == amount * sharePrice);
        _;
    }
    
    modifier userHasShares() {
        require(sharesPerAddress[msg.sender] > 0);
        _;
    }
    
    modifier hasEnoughMoneyForDividend() {
        require(this.balance >= sharesPerAddress[msg.sender] * dividend);
        _;
    }
    
    modifier userAllowedToWithdraw() {
        require(addressAllowedToWithdrawFunds[msg.sender] == true);
        _;
    }
    
    function getPricePerShare() public view returns(uint) {
        return sharePrice / 1 ether;
    }
    
    function getDividendPrice() public view returns(uint) {
        return dividend / 1 ether;
    }
    
    function calculateTransactionWorth(uint amount) public view returns(uint) {
        return (amount * sharePrice) / 1 ether;
    }
    
    function buyShares(uint amount) public payable 
        checkOverflow(sharesPerAddress[msg.sender], amount) 
        hasEnoughRemainingShares(amount) 
        addressSendsEnoughMoney(amount) {
            
        sharesPerAddress[owner] -= amount;
        sharesPerAddress[msg.sender] += amount;
        shareHolders.push(msg.sender);
        increaseSharePrice(sharePriceChangeStep);
        increaseDividendPrice(dividendPriceChangeStep);
    }
    
    function getShareHolders() public view isOwner returns(address[])
    {
        return shareHolders;
    }
    
    function allowWithdraw(address addr) public isOwner {
        addressAllowedToWithdrawFunds[addr] = true;
    }
    
    function depositEarnings() public payable isOwner {
        
    }
    
    function getBalance() public view isOwner returns(uint) {
        return this.balance / 1 ether;
    }
    
    function getNumberOfShares(address addr) public view isOwnerOrAddressHolder(addr) returns(uint) {
        return sharesPerAddress[addr];
    }
    
    function withdraw() public userHasShares hasEnoughMoneyForDividend userAllowedToWithdraw {
        msg.sender.transfer(sharesPerAddress[msg.sender] * dividend);
        addressAllowedToWithdrawFunds[msg.sender] = false;
        decreaseSharePrice(sharePriceChangeStep);
        decreaseDividendPrice(dividendPriceChangeStep);
    }
    
    function increaseSharePrice (uint amount) private checkOverflow(sharePrice, amount) {
        sharePrice += amount;
    }
    
    function decreaseSharePrice (uint amount) private checkIfDecreasePossible(sharePrice, amount) {
        sharePrice -= amount;
    }
    
    function increaseDividendPrice (uint amount) private checkOverflow(dividend, amount) {
        dividend += amount;
    }
    
    function decreaseDividendPrice (uint amount) private checkIfDecreasePossible(dividend, amount) {
        dividend -= amount;
    }
}