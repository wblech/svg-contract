pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "base64-sol/base64.sol";

contract SVGNFT is ERC721URIStorage{
	using Counters for Counters.Counter;
	event CreateSVGNFT(uint256 indexed tokenId, string tokenURI);

	Counters.Counter private _tokenIdCounter;

	constructor() ERC721("SVG NFT", "svgNFT") {

	}

	function create(string memory _svg) public {
		uint256 tokenId = _tokenIdCounter.current();
		_safeMint(msg.sender, tokenId);
		string memory imageURI = svgToImageURI(_svg);
		string memory tokenURI = formatTokenURI(imageURI);
		_setTokenURI(tokenId, tokenURI);
		_tokenIdCounter.increment();
		emit CreateSVGNFT(tokenId, tokenURI);
	}

	function svgToImageURI(string memory _svg) public pure returns (string memory) {
		//data:image/svg+xml;base64,
		string memory baseURL = "data:image/svg+xml;base64,";
		string memory svgBase64Encoded = Base64.encode(bytes(string(abi.encodePacked(_svg))));
		string memory imageURI = string(abi.encodePacked(baseURL, svgBase64Encoded));
		return imageURI;
	}

	function formatTokenURI(string memory imageURI) public pure returns (string memory) {
		string memory baseURL = "data:application/json;base64,";
		return string(abi.encodePacked(
			baseURL,
			Base64.encode(
				bytes(
					abi.encodePacked(
						'{"name": "SVG NFT",',
						'"description": "An NFT based on SVG!",',
						'"attributes": "", "image": "', imageURI,
						'"} '
					)
				)
			)
		));
	}
}


