# MasterChef

## update pool

```solidity
    // Update reward variables of the given pool to be up-to-date.
    function updatePool(uint256 _pid) public {
        PoolInfo storage pool = poolInfo[_pid];
        if (block.number <= pool.lastRewardBlock) {
            return;
        }
        uint256 lpSupply = pool.lpToken.balanceOf(address(this));
        if (lpSupply == 0) {
            pool.lastRewardBlock = block.number;
            return;
        }
        uint256 multiplier = getMultiplier(pool.lastRewardBlock, block.number);

        uint256 sushiReward = (multiplier * sushiPerBlock * pool.allocPoint) / (totalAllocPoint);

        sushi.mint(address(this), sushiReward);

        // TODO: Accumulative Rewards Per Token
        pool.accSushiPerShare = pool.accSushiPerShare + (sushiReward * 1e12 / lpSupply);

        pool.lastRewardBlock = block.number;
    }
```

## pending reward

```solidity
    function pendingSushi(uint256 _pid, address _user) external view returns (uint256) {
        PoolInfo memory pool = poolInfo[_pid];
        UserInfo memory user = userInfo[_pid][_user];
        uint256 accSushiPerShare = pool.accSushiPerShare;
        uint256 lpSupply = pool.lpToken.balanceOf(address(this));
        if (block.number > pool.lastRewardBlock && lpSupply != 0) {
            uint256 multiplier = getMultiplier(pool.lastRewardBlock, block.number);

            uint256 sushiReward = (multiplier * sushiPerBlock * pool.allocPoint) / (totalAllocPoint);

            accSushiPerShare = accSushiPerShare + (sushiReward * 1e12 / lpSupply);
        }

        // TODO: amount * accSushiPerShare  - rewardDebt
        uint256 pendingReward = (user.amount * accSushiPerShare) / 1e12 - user.rewardDebt;
    }
```
