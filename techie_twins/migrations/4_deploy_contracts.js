var laboratoryInfo = artifacts.require("LaboratoryInfo");

module.exports = function (deployer) {
  deployer.deploy(laboratoryInfo);
};