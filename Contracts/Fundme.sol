// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";


contract FundMe{

    uint256 public minValueUsd = 5e18;
    address[] public funders;  
    mapping (address funders => uint256 ammount) addressToAmountFunded;

    function fund() public payable  {

        require(getConversionRate(msg.value) > minValueUsd,"didnt sent rnough eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    function getPrice() public view returns(uint256) {

        //0x694AA1769357215DE4FAC081bf1f309aDC325306
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (/*uint80 rountInt*/, int256 price,/* uint256 storedAt*/, /*uint256 timeStamp*/, /*uint80 answeredInRound */) = priceFeed.latestRoundData();
        //price of eth in usd
        //returns 2000.00000000
        //doesnt work well with decimals hence we added 1e10 i.e. 10**10 or 10,000,000,000
        return uint256(price*1e10);
    }
    function getConversionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();  
        uint256 ethAmountInUsd = (ethPrice*ethAmount) / 1e18;
        return ethAmountInUsd;
    }

    function getVersion() public view returns(uint256){
        return AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306).version();
    } 


}