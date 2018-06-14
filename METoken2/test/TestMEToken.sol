pragma solidity ^0.4.24;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/METoken.sol";

contract TestMEToken{
    function testInitialBalanceUsingDeployedContract() {
        METoken meta = METoken(DeployedAddresses.METoken());

        uint expected = 10000;

        Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 MetaCoin initially");
    }

  function testInitialBalanceWithNewMetaCoin() {
        METoken meta = new METoken();

        uint expected = 10000;

        Assert.equal(meta.getBalance(tx.origin), expected, "Owner should have 10000 MetaCoin initially");
  }
}
