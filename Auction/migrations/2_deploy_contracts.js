var Auction = artifacts.require("./Auction.sol");

module.exports = function (deployer) {
    deployer.deploy(Auction, 1000000000000000000);
};