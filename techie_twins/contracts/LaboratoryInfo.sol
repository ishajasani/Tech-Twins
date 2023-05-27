// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract LaboratoryInfo {
    uint256 reportCounter = 0;
    struct Laboratory {
        string name;
        string recordsDelivered;
        string experience;
        string rating;
        string email;
        string about;
        string profileImageURL;
        Reports[] reports;
    }

    struct Reports {
        address patientAddress;
        address doctorAddress;
        string reportType;
        string[] cids;
    }
    address[] labAddress;

    mapping(address => Laboratory) laboratories;

    function registerLaboratory(
        string memory name,
        string memory recordsDelivered,
        string memory experience,
        string memory rating,
        string memory email,
        string memory about,
        string memory profileImageURL
    ) public {
        laboratories[msg.sender].name = name;
        laboratories[msg.sender].recordsDelivered = recordsDelivered;
        laboratories[msg.sender].experience = experience;
        laboratories[msg.sender].rating = rating;
        laboratories[msg.sender].email = email;
        laboratories[msg.sender].about = about;
        laboratories[msg.sender].profileImageURL = profileImageURL;
        labAddress.push(msg.sender);
    }

    function getLaboratoryInfo(address laboratoryAddress)
        public
        view
        returns (
            string memory name,
            string memory recordsDelivered,
            string memory experience,
            string memory rating,
            string memory email,
            string memory about,
            string memory profileImageURL
        )
    {
        Laboratory memory laboratory = laboratories[laboratoryAddress];
        return (
            laboratory.name,
            laboratory.recordsDelivered,
            laboratory.experience,
            laboratory.rating,
            laboratory.email,
            laboratory.about,
            laboratory.profileImageURL
        );
    }

    function requestReport(
        address doctorAddress,
        string memory reportType,
        address laboratoryAddress,
        address patientAddress
    ) public {
        laboratories[laboratoryAddress].reports.push(
            Reports(patientAddress, doctorAddress, reportType, new string[](0))
        );

        reportCounter++;
    }

    function generateReport(address patientAddress_,address laboratoryAddress, string[] memory cids_)
        public
    {
        for (uint256 i = 0; i < reportCounter; i++) {
            if (
                laboratories[laboratoryAddress].reports[i].patientAddress ==
                patientAddress_
            ) {
                laboratories[laboratoryAddress].reports[i].cids = cids_;
            }
        }
    }

    function getReport(address patientAddress_ , address laboratoryAddress)
        public
        view
        returns (string[] memory)
    {
        uint256 i;
        for (i = 0; i < reportCounter; i++) {
            if (
                laboratories[laboratoryAddress].reports[i].patientAddress ==
                patientAddress_
            ) {
                break;
            }
        }
        return laboratories[laboratoryAddress].reports[i].cids;
    }

    function getAllLaboratory() public view  returns (address[] memory labAddress_ ){
        labAddress_ = labAddress;
    }
}
