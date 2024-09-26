// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;

    uint256 public minValueUsd = 5e18;
    address[] public funders;  
    mapping (address funders => uint256 ammount) addressToAmountFunded;

    function fund() public payable  {

        require(msg.value.getConversionRate() > minValueUsd,"didnt sent rnough eth");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] = addressToAmountFunded[msg.sender] + msg.value;
    }

    


}