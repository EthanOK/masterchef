# SushiToken
[Git Source](https://github.com/EthanOK/masterchef/blob/6f52a8531afe696666dfd399f752a276352b27de/src/SushiToken.sol)

**Inherits:**
ERC20, Ownable


## State Variables
### _delegates
A record of each accounts delegate


```solidity
mapping(address => address) internal _delegates;
```


### checkpoints
A record of votes checkpoints for each account, by index


```solidity
mapping(address => mapping(uint32 => Checkpoint)) public checkpoints;
```


### numCheckpoints
The number of checkpoints for each account


```solidity
mapping(address => uint32) public numCheckpoints;
```


### DOMAIN_TYPEHASH
The EIP-712 typehash for the contract's domain


```solidity
bytes32 public constant DOMAIN_TYPEHASH =
    keccak256("EIP712Domain(string name,uint256 chainId,address verifyingContract)");
```


### DELEGATION_TYPEHASH
The EIP-712 typehash for the delegation struct used by the contract


```solidity
bytes32 public constant DELEGATION_TYPEHASH = keccak256("Delegation(address delegatee,uint256 nonce,uint256 expiry)");
```


### nonces
A record of states for signing / validating signatures


```solidity
mapping(address => uint256) public nonces;
```


## Functions
### mint

Creates `_amount` token to `_to`. Must only be called by the owner (MasterChef).


```solidity
function mint(address _to, uint256 _amount) public onlyOwner;
```

### delegates

Delegate votes from `msg.sender` to `delegatee`


```solidity
function delegates(address delegator) external view returns (address);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`delegator`|`address`|The address to get delegatee for|


### delegate

Delegate votes from `msg.sender` to `delegatee`


```solidity
function delegate(address delegatee) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`delegatee`|`address`|The address to delegate votes to|


### delegateBySig

Delegates votes from signatory to `delegatee`


```solidity
function delegateBySig(address delegatee, uint256 nonce, uint256 expiry, uint8 v, bytes32 r, bytes32 s) external;
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`delegatee`|`address`|The address to delegate votes to|
|`nonce`|`uint256`|The contract state required to match the signature|
|`expiry`|`uint256`|The time at which to expire the signature|
|`v`|`uint8`|The recovery byte of the signature|
|`r`|`bytes32`|Half of the ECDSA signature pair|
|`s`|`bytes32`|Half of the ECDSA signature pair|


### getCurrentVotes

Gets the current votes balance for `account`


```solidity
function getCurrentVotes(address account) external view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address to get votes balance|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The number of current votes for `account`|


### getPriorVotes

Determine the prior number of votes for an account as of a block number

*Block number must be a finalized block or else this function will revert to prevent misinformation.*


```solidity
function getPriorVotes(address account, uint256 blockNumber) external view returns (uint256);
```
**Parameters**

|Name|Type|Description|
|----|----|-----------|
|`account`|`address`|The address of the account to check|
|`blockNumber`|`uint256`|The block number to get the vote balance at|

**Returns**

|Name|Type|Description|
|----|----|-----------|
|`<none>`|`uint256`|The number of votes the account had as of the given block|


### _delegate


```solidity
function _delegate(address delegator, address delegatee) internal;
```

### _moveDelegates


```solidity
function _moveDelegates(address srcRep, address dstRep, uint256 amount) internal;
```

### _writeCheckpoint


```solidity
function _writeCheckpoint(address delegatee, uint32 nCheckpoints, uint256 oldVotes, uint256 newVotes) internal;
```

### safe32


```solidity
function safe32(uint256 n, string memory errorMessage) internal pure returns (uint32);
```

### getChainId


```solidity
function getChainId() internal view returns (uint256);
```

## Events
### DelegateChanged
An event thats emitted when an account changes its delegate


```solidity
event DelegateChanged(address indexed delegator, address indexed fromDelegate, address indexed toDelegate);
```

### DelegateVotesChanged
An event thats emitted when a delegate account's vote balance changes


```solidity
event DelegateVotesChanged(address indexed delegate, uint256 previousBalance, uint256 newBalance);
```

## Structs
### Checkpoint
A checkpoint for marking number of votes from a given block


```solidity
struct Checkpoint {
    uint32 fromBlock;
    uint256 votes;
}
```

