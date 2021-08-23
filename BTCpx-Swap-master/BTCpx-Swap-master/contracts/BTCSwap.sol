// SPDX-License-Identifier: MIT

pragma solidity ^0.7.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/SafeERC20.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router01.sol";

contract BTCSwap is Ownable {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    IERC20 public WBTC;
    IERC20 public BTCpx;
    IERC20 public PRXY;
    address public treasury;

    address public constant V2_ROUTER = 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D;
    address public constant WETH = 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6; // Goerli WETH

    event BTCPrice(uint256);
    event PRXYPrice(uint256);
    event RewardAmount(uint256);
    event TreasuryUpdated(address);

    constructor(
        address _treasury,
        address _wbtc,
        address _btcpx,
        address _prxy
    ) {
        treasury = _treasury;
        WBTC = IERC20(_wbtc);
        BTCpx = IERC20(_btcpx);
        PRXY = IERC20(_prxy);
    }

    function swap(uint256 _amount) external {
        require(_amount > 0, "invalid amount");

        // Receive WBTC
        WBTC.safeTransferFrom(
            _msgSender(),
            address(this),
            _amount
        );

        // 0.1% of WBTC amount is deducted
        uint256 feeAmount = _amount.div(1e3);

        // Send 99.9% BTCpx to user
        BTCpx.safeTransferFrom(
            treasury,
            _msgSender(),
            _amount.sub(feeAmount)
        );

        address[] memory path = new address[](2);
        path[0] = address(WBTC);
        path[1] = WETH;
        uint256 btcPrice = getOutputAmount(1e8, path);
        emit BTCPrice(btcPrice);

        path[0] = address(PRXY);
        uint256 prxyPrice = getOutputAmount(1e18, path);
        emit PRXYPrice(prxyPrice);

        uint256 rewardAmount = feeAmount.mul(5).mul(btcPrice).mul(1e10).div(prxyPrice);

        // Send 0.5% in PRXY
        PRXY.safeTransferFrom(treasury, _msgSender(), rewardAmount);
        emit RewardAmount(rewardAmount);
    }

    function getOutputAmount(uint256 amountIn, address[] memory path) public view returns(uint256) {
        uint256[] memory amounts = IUniswapV2Router01(V2_ROUTER).getAmountsOut(amountIn, path);
        return amounts[amounts.length - 1];
    }

    function emergencyWithdrawETH() external onlyOwner {
        (bool success, ) = payable(_msgSender()).call{value: address(this).balance}("");
        require(success, "failed to withdraw eth");
    }

    function emergencyWithdrawERC20(IERC20 _token) external onlyOwner {
        _token.safeTransfer(_msgSender(), _token.balanceOf(address(this)));
    }

    function updateTreasury(address _treasury) external onlyOwner {
        require(treasury != _treasury, "same treasury");

        treasury = _treasury;

        emit TreasuryUpdated(_treasury);
    }
}
