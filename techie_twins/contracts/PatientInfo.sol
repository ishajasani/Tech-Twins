// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PatientInfo{
    struct Appointment {
        address doctorAddress;
        uint256 datetime;
        bool isConfirmed;
    }

    struct Patient {
        string name;
        string blood;
        string age;
        string gender;
        string email;
        string phone;
        string height;
        string weight;
        string profileImageURL;
        string[] recordCids;
        Appointment[] appointments;
    }

    mapping(address => Patient) public patients;
    uint appointmentCount = 0;

    function registerPatient(
        string memory name,
        string memory blood,
        string memory age,
        string memory height,
        string memory weight,
        string memory gender,
        string memory email,
        string memory phone,
        string memory profileImageURL
    ) public {
        patients[msg.sender].name = name;
        patients[msg.sender].blood = blood;
        patients[msg.sender].age = age;
        patients[msg.sender].gender = gender;
        patients[msg.sender].email = email;
        patients[msg.sender].height = height;
        patients[msg.sender].weight = weight;
        patients[msg.sender].phone = phone;
        patients[msg.sender].profileImageURL = profileImageURL;
    }

    function getPatient(
        address patientAddress
    )
        public
        view
        returns (
            string memory name,
            string memory blood,
            string memory age,
            string memory height,
            string memory weight,
            string memory gender,
            string memory email,
            string memory phone,
            string memory profileImageURL
        )
    {
        Patient memory patient = patients[patientAddress];
        return (
            patient.name,
            patient.blood,
            patient.age,
            patient.height,
            patient.weight,
            patient.gender,
            patient.email,
            patient.phone,
            patient.profileImageURL
        );
    }

    function setPatientRecordCids(string memory cid) public {
        patients[msg.sender].recordCids.push(cid);
    }

    function getPatientRecordCids() public view returns (string[] memory cid_) {
        cid_ = patients[msg.sender].recordCids;
    }

    function addAppointment (uint256 timestamp, address doctorAddress, address patientAddress,bool isConfirmed) public {
        patients[patientAddress].appointments.push(Appointment(doctorAddress,timestamp,isConfirmed));
    }

    function getMyAppointments(address patientAddress) public view returns (Appointment[] memory){
        return patients[patientAddress].appointments;
    }
    

    //Boolean value to show whether doctor has access to reports or not.
}