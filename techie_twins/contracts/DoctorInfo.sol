// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract DoctorInfo {
    struct Appointment {
        address patient;
        uint256 appointmentTime;
        bool isConfirmed;
        string meetingLink;
    }

    struct Doctor {
        string name;
        string designation;
        string patientCount;
        string experience;
        string gender;
        string rating;
        string about;
        string email;
        string profileImageURL;
        Appointment[] appointments;
    }
    uint appointmentCount = 0;

    address[] docAdd;
    mapping(address => Doctor) doctors;

    event DoctorRegistration(address indexed doctorAddress, string name);

    function registerDoctor(
        string memory name,
        string memory designation,
        string memory patientCount,
        string memory experience,
        string memory gender,
        string memory rating,
        string memory email,
        string memory about,
        string memory profileImageURL
    ) public {
        doctors[msg.sender].name = name;
        doctors[msg.sender].designation = designation;
        doctors[msg.sender].patientCount = patientCount;
        doctors[msg.sender].experience = experience;
        doctors[msg.sender].gender = gender;
        doctors[msg.sender].rating = rating;
        doctors[msg.sender].email = email;
        doctors[msg.sender].about = about;
        doctors[msg.sender].profileImageURL = profileImageURL;
        docAdd.push(msg.sender);
        emit DoctorRegistration(msg.sender, name);
    }

    function getDoctorInfo(
        address doctorAddress
    )
        public
        view
        returns (
            string memory name,
            string memory designation,
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
            doctor.designation,
            doctor.patientCount,
            doctor.experience,
            doctor.gender,
            doctor.rating,
            doctor.about,
            doctor.email,
            doctor.profileImageURL
        );
    }

    function getDoctorAdd() public view returns (address[] memory docAdd_) {
        docAdd_ = docAdd;
    }

    function bookAppointment(
        uint256 _appointmentTime,
        address docAddress,
        address patientAddress,
        string memory meetingLink
    ) external {
        doctors[docAddress].appointments.push(
            Appointment(patientAddress, _appointmentTime, false , meetingLink)
        );
        appointmentCount++;
    }

    function appointmentConfirmed(uint256 index , address doctorAddress) public {
        doctors[doctorAddress].appointments[index].isConfirmed = true;
    }

    function declineAppointment(uint256 index , address doctorAddress) public {
        delete doctors[doctorAddress].appointments[index];
    } 

    function getAppointments(
        address docaddress_
    ) public view returns (Appointment[] memory) {
        return doctors[docaddress_].appointments;
    }

    function getMeetingLink(uint256 index,address doctorAddress) public view returns(string memory){
        return doctors[doctorAddress].appointments[index].meetingLink;
    }
}
