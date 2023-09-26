// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "./DataDao.sol";

contract DaoFactory {
    DataDao[] public dataDaoArray;

    event DAOCreated(string indexed name, address indexed owner, string dao_nft_symbol);

    function createNewDataDao(string memory name, string memory dao_nft_symbol) public {
        DataDao dataDao = new DataDao(name, msg.sender, dao_nft_symbol);
        dataDaoArray.push(dataDao);
        emit DAOCreated(name, msg.sender, dao_nft_symbol);
    }
    
}