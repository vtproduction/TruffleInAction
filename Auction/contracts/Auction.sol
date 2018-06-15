pragma solidity ^0.4.17;

contract Auction {
    address owner;
    bool ended;
    address highestBidder;
    uint256 highestBid;
    mapping(address => uint256) userBiddedValue;

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
        userBiddedValue[msg.sender] += msg.value;
        emit newHighestBid(msg.value);
    }

    function withdraw() public returns (uint256) {
        if(!ended) return 0;
        uint256 amount = userBiddedValue[msg.sender];
        if (amount > 0) {
            userBiddedValue[msg.sender] = 0;
            if (!msg.sender.send(amount)) {
                userBiddedValue[msg.sender] = amount;
            }
        } 
        return amount;
    }

    function endBid() public onlyOwner {
        ended = true;
        userBiddedValue[highestBidder] -= highestBid;
        emit auctionEnded(highestBid, highestBidder);
    }

    function getCurrentHighestBid() public constant returns (uint256, address) {
        return (highestBid, highestBidder);
    }

}