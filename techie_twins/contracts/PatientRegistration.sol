// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract PatientRegistration {
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
    }

    mapping(address => Patient) public patients;

    event PatientRegistered(address indexed patientAddress, string name);

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
        emit PatientRegistered(msg.sender, name);
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
}
