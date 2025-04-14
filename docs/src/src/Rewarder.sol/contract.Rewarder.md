# Rewarder
[Git Source](https://github.com/EthanOK/masterchef/blob/6f52a8531afe696666dfd399f752a276352b27de/src/Rewarder.sol)

**Inherits:**
[IRewarder](/src/interfaces/IRewarder.sol/interface.IRewarder.md)


## State Variables
### sushiRewards

```solidity
mapping(uint256 => mapping(address => uint256)) sushiRewards;
```


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

