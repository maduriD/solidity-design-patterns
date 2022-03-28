// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.9;

contract WithdrawalPattern {
    address private owner;
    address payable[] internal investors;
    mapping(address => uint256) internal balances;
    mapping(address => bool) internal investorMap;

    constructor() {
        owner = msg.sender;
    }

    function registerInvestor(address payable _investor) public isOwner {
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

    function badWithdrawalpattern() public isOwner {
        for (uint i=0; i < investors.length; i++ ) {
            uint amount = calculateDividend(investors[i]);
            balances[investors[i]] = 0;
            investors[i].transfer(amount);
        }
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