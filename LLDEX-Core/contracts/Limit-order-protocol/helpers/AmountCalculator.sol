// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "../libraries/UncheckedAddress.sol";

/// @title A helper contract for calculations related to order amounts
contract AmountCalculator {
    using UncheckedAddress for address;

    /// @notice Calculates taker amount
    /// @return Result Floored taker amount
    function getTakerAmount(
        uint256 orderTakerAmount,
        uint256 orderMakerAmount,
        uint256 swapMakerAmount
    ) external pure returns (uint256) {
        return (swapMakerAmount * orderTakerAmount) / orderMakerAmount;
    }

    /// @notice Calculates maker amount
    /// @return Result Ceiled maker amount
    function getMakerAmount(
        uint256 orderTakerAmount,
        uint256 orderMakerAmount,
        uint256 swapTakerAmount
    ) external pure returns (uint256) {
        return
            (swapTakerAmount * orderMakerAmount + orderTakerAmount - 1) /
            orderTakerAmount;
    }

    /// @notice Performs an arbitrary call to target with data
    /// @return Result bytes transmuted to uint256
    function arbitraryStaticCall(address target, bytes memory data)
        external
        view
        returns (uint256)
    {
        bytes memory result = target.uncheckedFunctionStaticCall(
            data,
            "AC: arbitraryStaticCall"
        );
        return abi.decode(result, (uint256));
    }
}
