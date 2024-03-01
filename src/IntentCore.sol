// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.24;

import { Intent } from "./type/Intent.sol";
import { ISolver } from "./interfaces/ISolver.sol";

contract IntentCore {
    mapping(address => uint256) public nonce;

    function run(Intent[] calldata intents, address solver, bytes calldata data) public {
        uint256[] memory balances = new uint256[](intents.length);

        for (uint256 i; i < intents.length; i++) {
            Intent calldata intent = intents[i];

            intent.authenticate(nonce[intent.account]++, block.timestamp);

            balances[i] = intent.outAsset.balanceOf(intent.account);

            intent.inAsset.transferFrom(intent.account, solver, intent.inMax);
        }

        ISolver(solver).solve(intents, data);

        for (uint256 i; i < intents.length; i++) {
            Intent calldata intent = intents[i];

            if (intent.outAsset.balanceOf(intent.account) - balances[i] < intent.outMin) revert();
        }
    }
}
