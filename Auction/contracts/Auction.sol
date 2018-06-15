pragma solidity ^0.4.17;

contract Auction {
    address owner;
    bool ended;
    address public highestBidder;
    uint256 public highestBid;

    constructor (uint256 _initialBid) public {
        owner = msg.sender;
        highestBid = _initialBid;
        highestBidder = owner;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier notAllowOwner() {
        require(msg.sender != owner);
        _;
    }

    modifier auctionNotEndYet() {
        require(!ended);
        _;
    } 

    event auctionEnded(uint256 _highestBid, address _winner);
    event newHighestBid(uint256 _highestBid);

    function bid() public payable auctionNotEndYet notAllowOwner{
        require(msg.value > highestBid, "Your bid value is too low!");
        highestBid = msg.value;
        highestBidder = msg.sender;
        emit newHighestBid(msg.value);
    }

    function endBid() public onlyOwner {
        ended = true;
        emit auctionEnded(highestBid, highestBidder);
    }

    function getCurrentHighestBid() public constant returns (uint256, address) {
        return (highestBid, highestBidder);
    }

}