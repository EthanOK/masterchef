# IMasterChef
[Git Source](https://github.com/EthanOK/masterchef/blob/6f52a8531afe696666dfd399f752a276352b27de/src/interfaces/IMasterChef.sol)


## Functions
### poolInfo


```solidity
function poolInfo(uint256 pid) external view returns (IMasterChef.PoolInfo memory);
```

### totalAllocPoint


```solidity
function totalAllocPoint() external view returns (uint256);
```

### deposit


```solidity
function deposit(uint256 _pid, uint256 _amount) external;
```

## Structs
### UserInfo

```solidity
struct UserInfo {
    uint256 amount;
    uint256 rewardDebt;
}
```

### PoolInfo

```solidity
struct PoolInfo {
    IERC20 lpToken;
    uint256 allocPoint;
    uint256 lastRewardBlock;
    uint256 accSushiPerShare;
}
```

