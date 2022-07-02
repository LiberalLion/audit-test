//SPDX-License-Identifier:Unlicensed
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "../MockAccessControl.sol";

contract TestMinion is Test {
    Minion _min;
    address constant owner = 0xb4c79daB8f259C7Aee6E5b2Aa729821864227e84;


    function setUp() public {
        _min = new Minion();
    }

    function testFailPwnForContract() external {
        _min.pwn();
    }

    function testFailPwnForEOA(uint96 amount) external {
        vm.prank(address(0));
        vm.assume(amount > 0.2 ether);
        _min.pwn();
    }
    
    function testFailExternalCall() external {
        (, bytes memory d) = address(_min).call(abi.encodeWithSignature("pwn()"));
        emit log_bytes(d);
        vm.expectRevert(d);
    }

    function testFailRetrieveForOwner() external {
        vm.prank(owner);
        _min.retrieve();
    }

    function testFailRetrieveForSomeone () external {
        vm.prank(address(0));
        _min.retrieve();
    }

    function testVerify() external view returns(bool) {
        return _min.verify(owner);
    }

    function testFailVerifyAccountZero() external view returns(bool) {
        return _min.verify(address(0));
    }

    function testTimeVal() external {
        assertEq(_min.timeVal(), block.timestamp);
    }
}