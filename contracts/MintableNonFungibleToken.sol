pragma solidity 0.4.18;

import "./NonFungibleToken.sol";
import "zeppelin-solidity/contracts/math/SafeMath.sol";
import "zeppelin-solidity/contracts/ownership/Ownable.sol';

/**
 * @title MintableNonFungibleToken
 *
 * Superset of the ERC721 standard that allows for the minting
 * of non-fungible tokens.
 */
contract MintableNonFungibleToken is NonFungibleToken {
    using SafeMath for uint;

    event Mint(address indexed _to, uint256 indexed _tokenId);

    modifier onlyNonexistentToken(uint _tokenId) {
        require(tokenIdToOwner[_tokenId] == address(0));
        _;
    }

    function mint(address _owner, uint256 _tokenId, string _metadata, address _approvedAddress)
        public
        onlyOwner
        onlyNonexistentToken(_tokenId)
    {
        _setTokenOwner(_tokenId, _owner);
        _addTokenToOwnersList(_owner, _tokenId);
        _approve(_tokenId, _approvedAddress);
        _insertTokenMetadata(_tokenId, _metadata);

        numTokensTotal = numTokensTotal.add(1);

        Mint(_owner, _tokenId);
    }
}
