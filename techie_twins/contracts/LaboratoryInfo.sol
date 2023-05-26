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
        address laboratoryAddress
    ) public {
        laboratories[laboratoryAddress].reports.push(
            Reports(msg.sender, doctorAddress, reportType, new string[](0))
        );

        reportCounter++;
    }

    function generateReport(address patientAddress_, string[] memory cids_)
        public
    {
        for (uint256 i = 0; i < reportCounter; i++) {
            if (
                laboratories[msg.sender].reports[i].patientAddress ==
                patientAddress_
            ) {
                laboratories[msg.sender].reports[i].cids = cids_;
            }
        }
    }

    function getReport(address patientAddress_)
        public
        view
        returns (string[] memory)
    {
        uint256 i;
        for (i = 0; i < reportCounter; i++) {
            if (
                laboratories[msg.sender].reports[i].patientAddress ==
                patientAddress_
            ) {
                break;
            }
        }
        return laboratories[msg.sender].reports[i].cids;
    }
}
