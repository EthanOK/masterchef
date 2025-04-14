// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MasterChef} from "../src/MasterChef.sol";
import {MasterChefV2, IMasterChef} from "../src/MasterChefV2.sol";
import {Rewarder} from "../src/Rewarder.sol";
import {SushiToken} from "../src/SushiToken.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract MasterChefV2Test is Test {
    address public owner = makeAddr("owner");
    address public dev = makeAddr("dev");

    address public alice = makeAddr("alice");
    address public bob = makeAddr("bob");
    address public carol = makeAddr("carol");

    MasterChef public masterchef;
    MasterChefV2 public masterchefV2;
    SushiToken public sushi;
    ERC20Mock public lpToken;

    uint256 sushiPerBlock = 100 * 1e18;
    uint256 startBlock = 100;
    uint256 bonusEndBlock = 100;

    function setUp() public {
        lpToken = new ERC20Mock();

        lpToken.mint(alice, 1000 * 1e18);
        lpToken.mint(bob, 1000 * 1e18);
        lpToken.mint(carol, 1000 * 1e18);

        vm.startPrank(owner);

        sushi = new SushiToken();

        masterchef = new MasterChef(sushi, dev, 100 * 1e18, startBlock, bonusEndBlock);

        sushi.transferOwnership(address(masterchef));

        masterchef.add(100, lpToken, false);

        uint256 MASTER_PID = 0;

        masterchefV2 = new MasterChefV2(IMasterChef(address(masterchef)), sushi, MASTER_PID);

        Rewarder rewarder = new Rewarder();

        masterchefV2.add(100, lpToken, rewarder);

        vm.stopPrank();

        deal(address(sushi), address(masterchefV2), 100_000 * 1e18);
    }

    function test_Deposit() public {
        (uint256 amount_, int256 rewardDebt_) = (0, 0);
        vm.roll(startBlock);

        console.log("start block", startBlock);

        vm.startPrank(alice);

        console.log("alice deposit blockNumber", block.number);

        uint256 amount = 100 * 1e18;
        lpToken.approve(address(masterchefV2), amount);
        masterchefV2.deposit(0, amount, alice);
        (amount_, rewardDebt_) = masterchefV2.userInfo(0, alice);
        console.log("alice amount", amount_ / 1e18);
        console.log("alice rewardDebt", rewardDebt_ / 1e18);

        vm.stopPrank();

        uint256 currentBlock = startBlock + 10;
        vm.roll(currentBlock);

        vm.startPrank(bob);
        lpToken.approve(address(masterchefV2), amount);
        masterchefV2.deposit(0, amount, bob);
        (amount_, rewardDebt_) = masterchefV2.userInfo(0, alice);
        console.log("bob amount", amount_ / 1e18);
        console.log("bob rewardDebt", rewardDebt_ / 1e18);

        vm.stopPrank();

        currentBlock = startBlock + 50;
        vm.roll(currentBlock);

        vm.startPrank(alice);
        lpToken.approve(address(masterchefV2), amount);
        masterchefV2.deposit(0, amount, alice);
        (amount_, rewardDebt_) = masterchefV2.userInfo(0, alice);
        console.log("alice amount", amount_ / 1e18);
        console.log("alice rewardDebt", rewardDebt_ / 1e18);
        vm.stopPrank();

        currentBlock = startBlock + 50;
        vm.roll(currentBlock);

        console.log("current block", currentBlock);

        uint256 pending_alice = masterchefV2.pendingSushi(0, alice);
        uint256 pending_bob = masterchefV2.pendingSushi(0, bob);

        console.log("alice pending sushi", pending_alice / 1e18);
        console.log("bob pending sushi", pending_bob / 1e18);

        vm.startPrank(alice);

        console.log("alice withdraw ");

        masterchefV2.withdraw(0, 120 * 1e18, alice);
        (amount_, rewardDebt_) = masterchefV2.userInfo(0, alice);
        console.log("alice amount", amount_ / 1e18);
        console.log("alice rewardDebt", rewardDebt_ / 1e18);

        pending_alice = masterchefV2.pendingSushi(0, alice);
        console.log("alice pending sushi", pending_alice / 1e18);

        vm.stopPrank();
    }
}
