pragma solidity ^0.4.18;

contract CertificatesRegistry {
    mapping (string => uint) private certificateHashes;
    address private contractOwner = msg.sender;
    
    function add(string hash) public {
        require (msg.sender == contractOwner);
        certificateHashes[hash] = 1;
    }
    
    function verify(string hash) public view returns(bool) {
        return certificateHashes[hash] != 0;
    }
}