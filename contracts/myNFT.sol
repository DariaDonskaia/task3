// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract myNFT is ERC721, Ownable  {
  using Counters for Counters.Counter;

  Counters.Counter private currentTokenId;
  string public baseTokenURI;
  uint256 private _tokenId;

  constructor() ERC721("myNFT", "MNFT") {
    baseTokenURI = "";
  }

  function setTokenId(uint256 tokenId) public{
    _tokenId = tokenId;
  }

  function getTokenId() public view returns (uint256) {
    return _tokenId;
  }

  function mintTo(address recipient, string memory _baseTokenURI) public onlyOwner {
    require(recipient != address(0), "Recipient don't be equal zero address");
    uint256 tokenId = currentTokenId.current();
    setBaseTokenURI(_baseTokenURI);
    currentTokenId.increment();
    uint256 newItemId = currentTokenId.current();
    _safeMint(recipient, newItemId);
    setTokenId(newItemId);
  }

  function _ownerOf(uint256 tokenId) public view returns (address) {
    return ownerOf(tokenId);
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return baseTokenURI;
  }

  function setBaseTokenURI(string memory _baseTokenURI) public {
    baseTokenURI = _baseTokenURI;
  }
}

contract myNFT1155 is ERC1155, Ownable  {

  using Counters for Counters.Counter;

  Counters.Counter private currentTokenId;
  string public baseTokenURI;
  uint256 private _tokenId;

  constructor(string memory uri_) ERC1155(uri_) {
    require(bytes(uri_).length != 0, "URI don't be empty");
    setBaseTokenURI(uri_);
  }

  function setTokenId(uint256 tokenId) public{
    _tokenId = tokenId;
  }

  function getTokenId() public view returns (uint256) {
    return _tokenId;
  }

  function mintTo(address recipient) public onlyOwner {
    require(recipient != address(0), "Recipient don't be equal zero address");
    uint256 tokenId = currentTokenId.current();

    currentTokenId.increment();
    uint256 newItemId = currentTokenId.current();
    _mint(recipient, newItemId, 1, "");
    setTokenId(newItemId);
  }

  function uri(uint256) public view virtual override returns (string memory) {
        return baseTokenURI;
  }

  function setBaseTokenURI(string memory _baseTokenURI) public {
    _setURI(_baseTokenURI);
    baseTokenURI = _baseTokenURI;
  }

}

