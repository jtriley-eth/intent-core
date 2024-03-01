// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { IERC165 } from "./IERC165.sol";

interface IERC721 is IERC165 {
    event Transfer(address indexed sender, address indexed receiver, uint256 indexed id);
    event Approval(address indexed owner, address indexed spender, uint256 indexed id);
    event ApprovalForAll(address indexed owner, address indexed spender, bool approved);

    function balanceOf(address owner) external view returns (uint256);
    function ownerOf(uint256 id) external view returns (address);
    function getApproved(uint256 id) external view returns (address);
    function isApprovedForAll(address owner, address spender) external view returns (bool);
    function transferFrom(address sender, address receiver, uint256 id) external payable;
    function safeTransferFrom(address sender, address receiver, uint256 id) external payable;
    function safeTransferFrom(address sender, address receiver, uint256 id, bytes calldata data) external payable;
    function approve(address spender, uint256 id) external payable;
    function setApprovalForAll(address spender, bool approved) external;
}
