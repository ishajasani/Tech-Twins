var patientinfo = artifacts.require("PatientInfo");

module.exports = function (deployer) {
  deployer.deploy(patientinfo);
};