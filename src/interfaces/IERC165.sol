// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

interface IERC165 {
    function supportsInterface(bytes4 interfaceId) external view returns (bool supported);
}
