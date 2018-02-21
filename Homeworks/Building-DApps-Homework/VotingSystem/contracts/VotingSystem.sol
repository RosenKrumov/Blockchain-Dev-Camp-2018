pragma solidity ^0.4.18;

/**
 * The VotingSystem contract is a voting application.
 	Set of candidates is initialized.
 	After that votes for each one are submitted and stored in the blockchain
 */
contract VotingSystem {
	mapping(address => uint) votesForCandidate;
	address[] public candidates;

	function getCandidates() public view returns(address[]) {
		return candidates;
	}

	function addCandidate (address candidate) public returns(address[]) {
		candidates.push(candidate);
		return candidates;
	}

	function voteForCandidate (address candidate) public returns(uint) {
		require(validCandidate(candidate));
		votesForCandidate[candidate]++;
		return votesForCandidate[candidate];
	}
	
	function totalVotesForCandidate (address candidate) public view returns(uint) {
		require(validCandidate(candidate));
		return votesForCandidate[candidate];
	}

	function validCandidate (address candidate) private view returns(bool) {
		
		for(uint i = 0; i < candidates.length; i++) {
			if (candidates[i] == candidate) {
				return true;
			}
		}

		return false;
	}
}
