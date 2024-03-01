// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.24;

import { Intent } from "./type/Intent.sol";
import { Solver } from "./type/Solver.sol";

contract IntentCore {
    mapping(address => uint256) public nonce;

    function run(Intent[] calldata intents, address solver, bytes calldata data) public {
        unchecked {
            for (uint256 i; i < intents.length; i++) {
                Intent calldata intent = intents[i];
                intent.authenticate(nonce[intent.account]++);
                intent.inAsset.transferFrom(intent.account, solver, intent.inMax);
            }

            Solver.wrap(solver).solve(msg.sender, data);

            for (uint256 i; i < intents.length; i++) {
                Intent calldata intent = intents[i];
                intent.outAsset.transferFrom(solver, intent.account, intent.outMin);
            }
        }
    }
}
