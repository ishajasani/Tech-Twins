var appointment = artifacts.require("DoctorAppointment");

module.exports = function (deployer) {
  deployer.deploy(appointment);
};
