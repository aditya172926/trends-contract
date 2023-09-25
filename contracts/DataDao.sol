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

    event memberAdded(address indexed member, uint256 tokenId);
    event memberRemoved(address indexed member, uint256 tokenId);
    event addedBaseUri(string baseUri);

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

    modifier checkOwner(address _owner) {
        require(_owner == dao_owner, "Only owner can perform this txn.");
        _;
    }

    function addMember() public checkMember(msg.sender) returns (uint256) {
        // mint the nft to this address
        currentTokenId.increment();
        uint256 tokenId = currentTokenId.current();
        _safeMint(msg.sender, tokenId);
        emit memberAdded(msg.sender, tokenId);
        return tokenId;
    }

    function removeMember(address member_address, uint256 tokenId) public checkOwner(msg.sender) {
        // only owner should call this function
        // burn the nft for the member_address
        uint256 tokenCount = dao_nft.balanceOf(member_address);
        require(tokenCount > 0, "Member does not exists");
        _burn(tokenId);
        emit memberRemoved(member_address, tokenId);
    }

    function setBaseTokenUri(string memory _baseTokenUri) public {
        baseTokenUri = _baseTokenUri;
    }

    function _baseUri() public view returns (string memory) {
        return baseTokenUri;
    }
}