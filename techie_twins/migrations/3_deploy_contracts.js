var doctorInfo = artifacts.require("DoctorInfo");

module.exports = function (deployer) {
  deployer.deploy(doctorInfo);
};