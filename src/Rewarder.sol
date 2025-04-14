// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {IRewarder, IERC20} from "./interfaces/IRewarder.sol";

event OnSushiRewardLog(
    uint256 indexed pid, address indexed user, address indexed recipient, uint256 sushiAmount, uint256 newLpAmount
);

contract Rewarder is IRewarder {
    mapping(uint256 => mapping(address => uint256)) sushiRewards;

    function onSushiReward(uint256 pid, address user, address recipient, uint256 sushiAmount, uint256 newLpAmount)
        external
    {
        sushiRewards[pid][recipient] += sushiAmount;
        emit OnSushiRewardLog(pid, user, recipient, sushiAmount, newLpAmount);
    }

    function pendingTokens(uint256 pid, address user, uint256 sushiAmount)
        external
        view
        returns (IERC20[] memory, uint256[] memory)
    {}
}
