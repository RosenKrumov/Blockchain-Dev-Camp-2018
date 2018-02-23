var Web3 = require('web3');
var solc = require('solc');
var fs = require('fs');

var web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

var code = fs.readFileSync('./contracts/VotingSystem.sol').toString();
var compiledCode = solc.compile(code);

var abiDefinition = JSON.parse(compiledCode.contracts[':VotingSystem'].interface);
var byteCode = compiledCode.contracts[':VotingSystem'].bytecode;

web3.eth.getAccounts().then(function(accounts) {
	var firstAccount = accounts[0];
	
	var VotingContract = new web3.eth.Contract(abiDefinition, firstAccount, {
		from: firstAccount,
		gasPrice: '300000000'
	});	

	VotingContract.deploy({
		data: '0x' + byteCode,
		arguments: []
	}).send({
		from: firstAccount,
		gas: 4712388
	}, function(err, txHash) {
		if(err) console.log("Error: " + err);
	}).then(function(contractInstance){

		for (var i = 0; i < accounts.length; i++) {
			contractInstance.methods.addCandidate(accounts[i]).send({
				from: firstAccount
			}, function(err, txHash) {
				if(err) console.log("Error: " + err);
			})
		}

		contractInstance.methods.getCandidates().call({
			from: firstAccount
		}).then((res) => {
			console.log(res[0]);
		})
	});
});
