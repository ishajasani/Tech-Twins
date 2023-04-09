// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract DoctorInfo{
    struct Doctor{
        string name;
        string patientCount;
        string experience;
        string gender;
        string rating;
        string email;
        string about;
        string profileImageURL;
    }

    mapping(address => Doctor) doctors;

    event DoctorRegistration(address indexed doctorAddress, string name);

    function registerDoctor(
        string memory name,
        string memory patientCount,
        string memory experience,
        string memory gender,
        string memory rating,
        string memory email,
        string memory about,
        string memory profileImageURL
    ) public {
        doctors[msg.sender].name = name;
        doctors[msg.sender].patientCount = patientCount;
        doctors[msg.sender].experience = experience;
        doctors[msg.sender].gender = gender;
        doctors[msg.sender].rating = rating;
        doctors[msg.sender].email = email;
        doctors[msg.sender].about = about;
        doctors[msg.sender].profileImageURL = profileImageURL;
        emit DoctorRegistration(msg.sender, name);
    }

    function getDoctorInfo(address doctorAddress)public view
        returns (
        string memory name,
        string memory patientCount,
        string memory experience,
        string memory gender,
        string memory rating,
        string memory email,
        string memory about,
        string memory profileImageURL
        )
    {
        Doctor memory doctor = doctors[doctorAddress];
        return (
            doctor.name,
            doctor.patientCount,
            doctor.experience,
            doctor.gender,
            doctor.rating,
            doctor.email,
            doctor.about,
            doctor.profileImageURL
        );
    }
}