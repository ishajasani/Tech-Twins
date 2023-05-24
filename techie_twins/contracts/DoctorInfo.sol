// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract DoctorInfo {
    struct Appointment {
        address patient;
        uint256 appointmentTime;
        bool isConfirmed;
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

    function bookAppointment(uint256 _appointmentTime , address docAddress) external {
        doctors[docAddress].appointments.push(Appointment(msg.sender , _appointmentTime , false));
        appointmentCount++;
    }

    function appointmentConfirmed(uint256 index) public{
        doctors[msg.sender].appointments[index].isConfirmed = true;
    }

    function getAppointments() public view returns (Appointment[] memory){
        Appointment[] memory tempAppointment = new Appointment[](appointmentCount);
        for(uint i = 0 ; i<appointmentCount ; i++){
            Appointment memory tempappointment = doctors[msg.sender].appointments[i];
            tempAppointment[i] = tempappointment;
        }
        return tempAppointment;
    }
}