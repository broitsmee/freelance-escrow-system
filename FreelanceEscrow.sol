// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract FreelanceEscrow {
    address public client;
    address public freelancer;
    address public arbiter;
    uint256 public amount;
    
    enum EscrowStatus { Pending, Funded, Released, Disputed, Refunded }
    EscrowStatus public status;

    modifier onlyClient() {
        require(msg.sender == client, "Only client can call this");
        _;
    }

    modifier onlyArbiter() {
        require(msg.sender == arbiter, "Only arbiter can call this");
        _;
    }

    constructor(address _freelancer, address _arbiter) payable {
        require(_freelancer != address(0), "Invalid freelancer address");
        require(_freelancer != msg.sender, "Client cannot be the freelancer");
        
        client = msg.sender;
        freelancer = _freelancer;
        arbiter = _arbiter;
        amount = msg.value;
        status = EscrowStatus.Funded;
    }

    function releaseFunds() external onlyClient {
        require(status == EscrowStatus.Funded, "Funds not available or already released");
        status = EscrowStatus.Released;
        
        payable(freelancer).transfer(amount);
    }

    function raiseDispute() external {
        require(msg.sender == client || msg.sender == freelancer, "Not authorized");
        require(status == EscrowStatus.Funded, "Cannot dispute");
        status = EscrowStatus.Disputed;
    }

    function refundClient() external onlyArbiter {
        require(status == EscrowStatus.Disputed, "Contract is not in dispute");
        status = EscrowStatus.Refunded;
        
        payable(client).transfer(amount);
    }
}
