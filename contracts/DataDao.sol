// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract DataDao is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private currentTokenId;

    string public dao_name;
    address public dao_owner;
    string public baseTokenUri;
    ERC721 dao_nft;

    constructor (string memory name, address owner, string memory dao_nft_symbol) ERC721(name, dao_nft_symbol) {
        dao_name = name;
        dao_owner = owner;
        baseTokenUri = "";
        dao_nft = ERC721(address(this));
    }

    modifier checkMember(address member_address) {
        uint tokenCount = dao_nft.balanceOf(member_address);
        require (tokenCount == 0, "Cannot claim DAO NFT twice");
        _;
    }

    function addMember() public checkMember(msg.sender) returns (uint256) {
        // mint the nft to this address
        currentTokenId.increment();
        uint256 tokenId = currentTokenId.current();
        _safeMint(msg.sender, tokenId);
        return tokenId;
    }

    function removeMember(address member_address) public {
        // only owner should call this function
        // burn the nft for the member_address
    }

    function setBaseTokenUri(string memory _baseTokenUri) public {
        baseTokenUri = _baseTokenUri;
    }

    function _baseUri() public view returns (string memory) {
        return baseTokenUri;
    }
}