// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract Sunday_Coin is ERC20, Ownable {
    // Event to log withdrawals
    event Withdrawal(uint amount, uint when);

    // Constructor to initialize the contract with an initial supply
    constructor(uint256 initialSupply) ERC20("Sunday_Coin", "SDYC") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply); // Mint initial supply to the owner
    }

    // Function to mint new tokens (only owner can do this)
    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }

    // Function to burn tokens (any holder can burn their tokens)
    function burn(uint256 amount) public {
        _burn(msg.sender, amount);
    }

    // Function to withdraw funds (only owner can do this)
    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No funds to withdraw");

        emit Withdrawal(balance, block.timestamp); // Log the withdrawal event

        payable(owner()).transfer(balance); // Transfer the contract balance to the owner
    }

    // Fallback function to accept ETH deposits
    receive() external payable {}
}
