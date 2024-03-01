// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity 0.8.24;

type Asset is address;

using { transferFrom } for Asset global;

function transferFrom(Asset self, address sender, address receiver, uint256 amount) {
    assembly {
        let fmp := mload(0x40)

        mstore(0x00, 0x23b872dd00000000000000000000000000000000000000000000000000000000)
        mstore(0x04, sender)
        mstore(0x24, receiver)
        mstore(0x44, amount)

        let success := call(gas(), self, 0x00, 0x00, 0x64, 0x00, 0x20)

        success := and(success, or(iszero(returndatasize()), eq(mload(0x00), 0x01)))

        if iszero(success) { revert(0x00, 0x00) }

        mstore(0x40, fmp)
        mstore(0x80, 0x00)
    }
}
