// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract DataDao {
    string public dao_name;
    address public dao_owner;

    constructor (string memory name, address owner) {
        dao_name = name;
        dao_owner = owner;
    }



    function addMember(address member_address) public {
        // mint the nft to this address
    }

    function removeMember(address member_address) public {
        // only owner should call this function
        // burn the nft for the member_address
    }

    
}