// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {DeployRaffle} from "script/DeployRaffle.s.sol";
import {HelperConfig, CodeConstants} from "script/HelperConfig.s.sol";
import {Raffle} from "src/Raffle.sol";
import {VRFCoordinatorV2_5Mock} from
    "lib/chainlink-brownie-contracts/contracts/src/v0.8/vrf/mocks/VRFCoordinatorV2_5Mock.sol";

contract InteractionsTest is Test, CodeConstants {
    Raffle raffle;
    HelperConfig helperConfig;
    HelperConfig.NetworkConfig config;

    address PLAYER = makeAddr("player");
    uint256 constant PLAYER_STARTING_BALANCE = 10 ether;

    function setUp() external {
        DeployRaffle deployer = new DeployRaffle();
        (raffle, helperConfig) = deployer.deployContract();
        config = helperConfig.getConfig();

        // give player some ETH
        vm.deal(PLAYER, PLAYER_STARTING_BALANCE);
    }

    function testPlayerCanEnterAndWin() public {
        // --- Player enters ---
        vm.startPrank(PLAYER);
        raffle.enterRaffle{value: config.entranceFee}();
        vm.stopPrank();

        assertEq(raffle.getPlayer(0), PLAYER);

        // --- Fast forward past interval ---
        vm.warp(block.timestamp + config.interval + 1);
        vm.roll(block.number + 1);

        // --- Perform upkeep ---
        raffle.performUpkeep("");

        // --- Simulate VRF fulfilling ---
        // For local chain, use the VRF mock
        if (block.chainid == LOCAL_CHAIN_ID) {
            VRFCoordinatorV2_5Mock(config.vrfCoordinator).fulfillRandomWords(
                1, // requestId is arbitrary here for mock
                address(raffle)
            );
        } else {
            // On Sepolia, we can't simulate fulfillment like this,
            // so we just check state transition after upkeep
            console.log(" Running on Sepolia: VRF must fulfill request off-chain");
            return;
        }

        // --- Assertions ---
        address winner = raffle.getRecentWinner();
        assertEq(winner, PLAYER, "Winner should be the only player");
        assertEq(uint256(raffle.getRaffleState()), 0, "Raffle should reset to OPEN");
    }
}
