module.exports = {
	// See <http://truffleframework.com/docs/advanced/configuration>
	// to customize your Truffle configuration!
	networks: {
		localnode: { // Whatever network our local node connects to
			network_id: "*", // Match any network id
			host: "localhost",
			port: 9545,
		}
	}
};
