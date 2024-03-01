// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

type Solver is address;

using { solve } for Solver global;

function solve(Solver self, address initiator, bytes calldata data) {
    assembly {
        mstore(0x00, 0xf6a58e2400000000000000000000000000000000000000000000000000000000)

        mstore(0x04, initiator)

        calldatacopy(0x24, data.offset, data.length)

        if iszero(call(gas(), self, 0x00, 0x00, add(0x24, data.length), 0x00, 0x04)) {
            revert(0x00, 0x00)
        }
    }
}
