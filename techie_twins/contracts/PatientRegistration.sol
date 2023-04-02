// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract PatientRegistration {
    struct Patient {
        string name;
        string age;
        string gender;
        string email;
        string phone;
        string height;
        string weight;
        string profileImageURL;
        string[] recordCids;
    }

    mapping(address => Patient) public patients;

    event PatientRegistered(address indexed patientAddress, string name);

    function registerPatient(
        string memory name,
        string memory age,
        string memory height,
        string memory weight,
        string memory gender,
        string memory email,
        string memory phone,
        string memory profileImageURL
    ) public {
        Patient storage patient = patients[msg.sender];
        patient.name = name;
        patient.age = age;
        patient.gender = gender;
        patient.email = email;
        patient.height = height;
        patient.weight = weight;
        patient.phone = phone;
        patient.profileImageURL = profileImageURL;
        emit PatientRegistered(msg.sender, name);
    }

    function getPatient(address patientAddress)
        public
        view
        returns (
            string memory name,
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
            patient.age,
            patient.height,
            patient.weight,
            patient.gender,
            patient.email,
            patient.phone,
            patient.profileImageURL
        );
    }

    function setPatientRecordCids(string memory cid) public
    {
        patients[msg.sender].recordCids.push(cid);
    }

    function getPatientRecordCids() public view returns (string[] memory cid_)
    {
        cid_ = patients[msg.sender].recordCids;
    }
}