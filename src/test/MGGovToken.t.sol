//SPDX-License-Identifier:Unlicensed
pragma solidity 0.6.12;

import "forge-std/Test.sol";
import "../MGGovToken.sol";

contract TestMockGovToken is Test {
    MockGovToken _token;
    address testAddr = 0x32F9E0cEBEc2a3Ef03F337ACD0e6560da8EC07c0;

    function setUp() public {
        _token = new MockGovToken();
    }

    function testMintWithOwner() external {
        _token.mint(testAddr, 10000000);
        assertEq(_token.balanceOf(testAddr), 10000000);
    }

    function testFailMintNotOwner() external {
        vm.prank(testAddr);
        _token.mint(testAddr, 10000000);
        vm.expectRevert();
    }

    function testBurnWithOwner() external {
        _token.mint(testAddr, 2000000);
        _token.burn(testAddr, 1000000);
        assertEq(_token.balanceOf(testAddr), 1000000);
    }

    function testFailBurnNotOwner() external {
        vm.prank(testAddr);
        _token.mint(testAddr, 2000000);
        _token.burn(testAddr, 1000000);
    }

    function testDelegates() view external returns(address) {
        return _token.delegates(testAddr);
    }

    function testDelegate() external {
        _token.delegate(testAddr);
    }

    function testFailGetPriorVotes() external {
        _token.getPriorVotes(testAddr, 100);
    }

}