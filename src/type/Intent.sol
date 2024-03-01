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

using { authenticate } for Intent global;

function authenticate(Intent calldata intent, uint256 nonce) view {
    assembly {
        mstore(0x00, nonce)

        calldatacopy(0x20, intent, 0xa0)

        let digest := keccak256(0x00, 0xc0)

        mstore(0x00, digest)

        calldatacopy(0x20, add(intent, 0xc0), 0x60)

        let success := staticcall(gas(), 0x02, 0x00, 0x80, 0x00, 0x20)

        success := and(success, eq(mload(0x00), intent))

        success := and(success, eq(timestamp(), calldataload(add(intent, 0x00a0))))

        if iszero(success) { revert(0x00, 0x00) }
    }
}
