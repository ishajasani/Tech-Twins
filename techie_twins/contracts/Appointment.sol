// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract DoctorAppointment {
    struct Appointment {
        address patient;
        uint256 appointmentTime;
        bool isConfirmed;
    }

    mapping(uint256 => Appointment) public appointments;
    uint256 public appointmentCounter;
    address public doctor;

    event AppointmentBooked(
        uint256 appointmentId,
        address patient,
        uint256 appointmentTime
    );
    event AppointmentConfirmed(uint256 appointmentId);

    constructor() {
        appointmentCounter = 1;
    }

    function bookAppointment(uint256 _appointmentTime) external {
        require(
            _appointmentTime > block.timestamp,
            "Appointment time must be in the future"
        );

        appointments[appointmentCounter] = Appointment(
            msg.sender,
            _appointmentTime,
            false
        );
        emit AppointmentBooked(
            appointmentCounter,
            msg.sender,
            _appointmentTime
        );
        appointmentCounter++;
    }

    function confirmAppointment(uint256 _appointmentId) external {
        Appointment storage appointment = appointments[_appointmentId];

        require(appointment.appointmentTime > 0, "Invalid appointment ID");
        require(!appointment.isConfirmed, "Appointment is already confirmed");
        require(
            appointment.appointmentTime > block.timestamp,
            "Appointment time has already passed"
        );

        appointment.isConfirmed = true;
        emit AppointmentConfirmed(_appointmentId);
    }

    function getAppointment(
        uint256 _appointmentId
    ) external view returns (address, uint256, bool) {
        Appointment storage appointment = appointments[_appointmentId];
        return (
            appointment.patient,
            appointment.appointmentTime,
            appointment.isConfirmed
        );
        
    }
}
