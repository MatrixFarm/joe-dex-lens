// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "openzeppelin/proxy/transparent/TransparentUpgradeableProxy.sol";
import "openzeppelin/proxy/transparent/ProxyAdmin.sol";

import "src/JoeDexLens.sol";

contract Deploy is Script {
    address private constant LB_FACTORY = 0x640801a6983c109805E928dc7d9794080C21C88E; // _FACTORY_V2_1
    address private constant LB_LEGACY_FACTORY = 0xdD693b9F810D0AEE1b3B74C50D3c363cE45CEC0C; // _LEGACY_FACTORY_V2
    address private constant JOE_FACTORY = 0x0000000000000000000000000000000000000000; // _FACTORY_V1
    address private constant WNATIVE = 0x21be370D5312f44cB42ce377BC9b8a0cEF1A4C83; // wFTM
    address private constant NATIVE_USD_AGGREGATOR = 0xf4766552D15AE4d256Ad41B6cf2933482B0680dc; // Chainlink Aggregator

    function run() public {
        vm.createSelectFork(vm.rpcUrl("fantom"));
        uint256 deployerPrivateKey = vm.envUint("DEPLOY_PRIVATE_KEY");

        // Start broadcasting the transaction to the network.
        vm.startBroadcast(deployerPrivateKey);

        ProxyAdmin proxyAdmin = new ProxyAdmin();
        JoeDexLens implementation = new JoeDexLens(
            ILBFactory(LB_FACTORY),
            ILBLegacyFactory(LB_LEGACY_FACTORY),
            IJoeFactory(JOE_FACTORY),
            WNATIVE
        );

        TransparentUpgradeableProxy lens = new TransparentUpgradeableProxy(
            address(implementation),
            address(proxyAdmin),
            abi.encodeWithSelector(JoeDexLens.initialize.selector, NATIVE_USD_AGGREGATOR)
        );

        // Stop broadcasting the transaction to the network.
        vm.stopBroadcast();

        // Log the addresses for the deployed contracts.
        console.log("proxyAdmin: ", address(proxyAdmin));
        console.log("implementation: ", address(implementation));
        console.log("lens (proxy): ", address(lens));
    }
}
