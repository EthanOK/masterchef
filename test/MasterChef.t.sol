// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import {MasterChef} from "../src/MasterChef.sol";
import {SushiToken} from "../src/SushiToken.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

contract MasterChefTest is Test {
    address public owner = makeAddr("owner");
    address public dev = makeAddr("dev");

    address public alice = makeAddr("alice");
    address public bob = makeAddr("bob");
    address public carol = makeAddr("carol");

    MasterChef public masterchef;
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

        vm.stopPrank();
    }

    function test_Deposit() public {
        vm.roll(startBlock);

        console.log("start block", startBlock);

        vm.startPrank(alice);

        console.log("alice deposit blockNumber", block.number);

        uint256 amount = 100 * 1e18;
        lpToken.approve(address(masterchef), amount);
        masterchef.deposit(0, amount);

        vm.stopPrank();

        uint256 currentBlock = startBlock + 10;
        vm.roll(currentBlock);

        vm.startPrank(bob);

        console.log("bob deposit blockNumber", block.number);

        lpToken.approve(address(masterchef), amount * 3);
        masterchef.deposit(0, amount * 3);
        vm.stopPrank();

        currentBlock = startBlock + 50;

        vm.roll(currentBlock);
        vm.startPrank(carol);

        console.log("carol deposit blockNumber", block.number);

        lpToken.approve(address(masterchef), amount * 5);
        masterchef.deposit(0, amount * 5);
        vm.stopPrank();

        currentBlock = startBlock + 100;

        vm.roll(currentBlock);
        console.log("current block", currentBlock);

        uint256 pending_alice = masterchef.pendingSushi(0, alice);
        uint256 pending_bob = masterchef.pendingSushi(0, bob);
        uint256 pending_carol = masterchef.pendingSushi(0, carol);

        console.log("alice pending sushi", pending_alice / 1e18);
        console.log("bob pending sushi", pending_bob / 1e18);
        console.log("carol pending sushi", pending_carol / 1e18);
        console.log("sushiPerBlock * block", (currentBlock - startBlock) * sushiPerBlock / 1e18);
    }
}
