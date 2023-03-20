// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract test{
    struct UserData{
        string username;
        address walletAddress;
        string pin;
    }

    uint256 public index= 0;

    mapping (address => UserData) public userdata;

    function setUserData(string memory _username , address _walletAddress , string memory _pin) public{
       userdata[_walletAddress] = UserData(_username , _walletAddress , _pin);
       index++;
    }
}