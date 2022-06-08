var GSTContract = artifacts.require("GSTContract");

module.exports = function(deployer) {
    deployer.deploy(GSTContract);
};

