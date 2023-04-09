// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract LaboratoryInfo{
    struct Laboratory{
        string name;
        string recordsDelivered;
        string experience;
        string rating;
        string email;
        string about;
        string profileImageURL;
    }

    mapping(address => Laboratory) laboratories;

    event LaboratoryRegistration(address indexed laboratoryAddress, string name);

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
        emit LaboratoryRegistration(msg.sender, name);
    }

    function getLaboratoryInfo(address laboratoryAddress)public view
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
}