// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract PatientInfo {
    struct Appointment {
        address doctorAddress;
        uint256 datetime;
        bool isConfirmed;
        string  meetingLink;
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
        DoctorAccess[] access;
    }

    struct DoctorAccess {
        address doctorAddress;
        address patientAddress;
        bool hasAccess;
    }

    mapping(address => Patient) public patients;

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

    function getPatient(address patientAddress)
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

    function setPatientRecordCids(string memory cid, address patientAddress)
        public
    {
        patients[patientAddress].recordCids.push(cid);
    }

    function getPatientRecordCids(address patientAddress)
        public
        view
        returns (string[] memory cid_)
    {
        cid_ = patients[patientAddress].recordCids;
    }

    function addAppointment(
        uint256 timestamp,
        address doctorAddress,
        address patientAddress,
        string memory link


    ) public {
        patients[patientAddress].appointments.push(
            Appointment(doctorAddress, timestamp, false, link)
        );
        patients[patientAddress].access.push(
            DoctorAccess(doctorAddress, patientAddress, false)
        );
    }

    function getMyAppointments(address patientAddress)
        public
        view
        returns (Appointment[] memory)
    {
        return patients[patientAddress].appointments;
    }

    function toggleAccess(address doctorAddress_, address patientAddress)
        public
    {
        for (uint256 i = 0; i < patients[patientAddress].access.length; i++) {
            if (
                patients[patientAddress].access[i].doctorAddress ==
                doctorAddress_
            ) {
                if(patients[patientAddress].access[i].hasAccess == false){
                    patients[patientAddress].access[i].hasAccess = true;
                }
                else 
                {
                    patients[patientAddress].access[i].hasAccess = false;
                }
            }
        }
    }

    function shareCids(address patientAddress, address doctorAddress_)
        public
        view
        returns (string [] memory)
    {
        string[] memory recordCids;
        for (uint256 i = 0; i < patients[patientAddress].access.length; i++) {
            if (
                patients[patientAddress].access[i].doctorAddress ==
                doctorAddress_
            ) {
                if( patients[patientAddress].access[i].hasAccess){
                    recordCids =  patients[patientAddress].recordCids;
                    break;
                }
            }
        }
        return recordCids;
    }
}
