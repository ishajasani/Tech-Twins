const Test = artifacts.require('test');

module.exports = function (deployer) {
  deployer.deploy(Test);
};
