// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { IERC165 } from "./IERC165.sol";

interface IERC6909 is IERC165 {
    event Transfer(
        address caller, address indexed sender, address indexed receiver, uint256 indexed id, uint256 amount
    );
    event OperatorSet(address indexed owner, address indexed spender, bool approved);
    event Approval(address indexed owner, address indexed spender, uint256 indexed id, uint256 amount);

    function balanceOf(address owner, uint256 id) external view returns (uint256 amount);
    function allowance(address owner, address spender, uint256 id) external view returns (uint256 amount);
    function isOperator(address owner, address spender) external view returns (bool approved);
    function transfer(address receiver, uint256 id, uint256 amount) external returns (bool);
    function transferFrom(address sender, address receiver, uint256 id, uint256 amount) external returns (bool);
    function approve(address spender, uint256 id, uint256 amount) external returns (bool);
    function setOperator(address spender, bool approved) external returns (bool);
}
