# MasterChef
[Git Source](https://github.com/EthanOK/masterchef/blob/66ee9da5c8a4122f27d3c9f37cd6daa38e1ce310/src/MasterChef.sol)

**Inherits:**
Ownable


## State Variables
### sushi

```solidity
SushiToken public sushi;
```


### devaddr

```solidity
address public devaddr;
```


### bonusEndBlock

```solidity
uint256 public bonusEndBlock;
```


### sushiPerBlock

```solidity
uint256 public sushiPerBlock;
```


### BONUS_MULTIPLIER

```solidity
uint256 public constant BONUS_MULTIPLIER = 10;
```


### migrator

```solidity
IMigratorChef public migrator;
```


### poolInfo

```solidity
PoolInfo[] public poolInfo;
```


### userInfo

```solidity
mapping(uint256 => mapping(address => UserInfo)) public userInfo;
```


### totalAllocPoint

```solidity
uint256 public totalAllocPoint = 0;
```


### startBlock

```solidity
uint256 public startBlock;
```


## Functions
### constructor


```solidity
constructor(SushiToken _sushi, address _devaddr, uint256 _sushiPerBlock, uint256 _startBlock, uint256 _bonusEndBlock)
    Ownable(msg.sender);
```

### poolLength


```solidity
function poolLength() external view returns (uint256);
```

### add


```solidity
function add(uint256 _allocPoint, IERC20 _lpToken, bool _withUpdate) public onlyOwner;
```

### set


```solidity
function set(uint256 _pid, uint256 _allocPoint, bool _withUpdate) public onlyOwner;
```

### setMigrator


```solidity
function setMigrator(IMigratorChef _migrator) public onlyOwner;
```

### migrate


```solidity
function migrate(uint256 _pid) public;
```

### getMultiplier


```solidity
function getMultiplier(uint256 _from, uint256 _to) public view returns (uint256);
```

### pendingSushi


```solidity
function pendingSushi(uint256 _pid, address _user) external view returns (uint256);
```

### massUpdatePools


```solidity
function massUpdatePools() public;
```

### updatePool


```solidity
function updatePool(uint256 _pid) public;
```

### deposit


```solidity
function deposit(uint256 _pid, uint256 _amount) public;
```

### withdraw


```solidity
function withdraw(uint256 _pid, uint256 _amount) public;
```

### emergencyWithdraw


```solidity
function emergencyWithdraw(uint256 _pid) public;
```

### safeSushiTransfer


```solidity
function safeSushiTransfer(address _to, uint256 _amount) internal;
```

### dev


```solidity
function dev(address _devaddr) public;
```

## Events
### Deposit

```solidity
event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
```

### Withdraw

```solidity
event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
```

### EmergencyWithdraw

```solidity
event EmergencyWithdraw(address indexed user, uint256 indexed pid, uint256 amount);
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

