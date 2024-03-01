// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { Intent } from "../type/Intent.sol";

interface ISolver {
    function solve(address caller, bytes calldata data) external returns (bytes4);
}
