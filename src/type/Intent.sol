// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.24;

import {Asset} from "./Asset.sol";

struct Intent {
    address account;
    Asset inAsset;
    Asset outAsset;
    uint256 inMax;
    uint256 outMin;
    uint64 deadline;
    uint8 v;
    bytes32 r;
    bytes32 s;
}

using { authenticate, hashWith } for Intent global;

function authenticate(Intent calldata intent, uint256 nonce, uint256 timestamp) pure {
    if (intent.account != ecrecover(intent.hashWith(nonce), intent.v, intent.r, intent.s)) revert();
    if (intent.deadline < timestamp) revert();
}

function hashWith(Intent calldata intent, uint256 nonce) pure returns (bytes32) {
    return keccak256(abi.encode(nonce, intent.inAsset, intent.outAsset, intent.inMax, intent.outMin, intent.deadline));
}
