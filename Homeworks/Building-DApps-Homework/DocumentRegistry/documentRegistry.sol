pragma solidity ^0.4.18;

/**
 * The DocumentRegistry contract stores documents and verifies them on demand
 */
contract DocumentRegistry {
	mapping (string => uint256) documents;
	address contractOwner;

	function DocumentRegistry () public {
		contractOwner = msg.sender;
	}	

	function add (string hash) public returns (uint256 dateAdded) {
		require(msg.sender == contractOwner);
		dateAdded = block.timestamp;
		documents[hash] = dateAdded;
		return dateAdded;
	}


	function verify (string hash) public view returns(uint256 dateAdded) {
		return documents[hash];
	}
}
