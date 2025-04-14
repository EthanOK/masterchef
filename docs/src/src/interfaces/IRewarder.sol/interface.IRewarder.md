# IRewarder
[Git Source](https://github.com/EthanOK/masterchef/blob/6f52a8531afe696666dfd399f752a276352b27de/src/interfaces/IRewarder.sol)


## Functions
### onSushiReward


```solidity
function onSushiReward(uint256 pid, address user, address recipient, uint256 sushiAmount, uint256 newLpAmount)
    external;
```

### pendingTokens


```solidity
function pendingTokens(uint256 pid, address user, uint256 sushiAmount)
    external
    view
    returns (IERC20[] memory, uint256[] memory);
```

