// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

contract WithdrawalPattern {
    address private owner;
    address[] internal investors;
    mapping(address => uint256) internal balances;
    mapping(address => bool) internal investorMap; // its always good to use maps for a quick lookup

    constructor() {
        owner = msg.sender;
    }

    function registerInvestor(address _investor) public isOwner {
        require(_investor != address(0));
        investors.push(_investor);
        investorMap[_investor] = true;
    }

    function calculateDividend(address _investor) internal returns (uint256) {
        // calculate the dividends accrued by investor
    }

    function withdrawDividend() public isInvestor {
        uint amount = calculateDividend(msg.sender);
        require (amount > 0, "No dividends to claim");
        balances[msg.sender] = 0;
        payable(msg.sender).transfer(amount);
    }

    modifier isOwner() {
        require(msg.sender == owner, "Sender is not owner");
        _;
    }

    modifier isInvestor() {
        require(investorMap[msg.sender] == true, "Msg sender is not an investor");
        _;
    }

}