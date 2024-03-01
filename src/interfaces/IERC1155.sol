// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import { IERC165 } from "./IERC165.sol";

interface ERC1155 is IERC165 {
    event TransferSingle(
        address indexed spender, address indexed sender, address indexed receiver, uint256 id, uint256 amount
    );
    event TransferBatch(
        address indexed spender, address indexed sender, address indexed receiver, uint256[] ids, uint256[] amounts
    );
    event ApprovalForAll(address indexed owner, address indexed spender, bool _approved);
    event URI(string uri, uint256 indexed id);

    function safeTransferFrom(address sender, address receiver, uint256 id, uint256 amount, bytes calldata data)
        external;
    function safeBatchTransferFrom(
        address sender,
        address receiver,
        uint256[] calldata ids,
        uint256[] calldata amounts,
        bytes calldata data
    ) external;
    function balanceOf(address owner, uint256 id) external view returns (uint256);
    function balanceOfBatch(address[] calldata owners, uint256[] calldata ids)
        external
        view
        returns (uint256[] memory);
    function setApprovalForAll(address spender, bool _approved) external;
    function isApprovedForAll(address owner, address spender) external view returns (bool);
}
