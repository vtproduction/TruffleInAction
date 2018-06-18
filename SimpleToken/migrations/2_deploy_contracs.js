var VenusToken = artifacts.require("VenusToken");

module.exports = function (deployer) {
    // Deploy the METoken contract as our only task
    deployer.deploy(VenusToken);
};