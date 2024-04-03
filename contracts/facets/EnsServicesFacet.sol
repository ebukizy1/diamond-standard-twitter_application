// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

import {LibAppStorage} from "../libraries/LibAppStorage.sol";
contract EnsServicesFacet{
    LibAppStorage.Layout internal _appStorage;


    event ProfileSuccessful(address indexed sender,string indexed _imageUrl, bytes32 userbio);
    event RegistrationSuccessful(address indexed sender, bytes32 indexed _username);
    

    function registerUsername(bytes32 _username) external { 
        require(_appStorage.usernameToAddress[_username] != address(0),"username already taken");
        require(_appStorage.addressToUsername[msg.sender] != bytes32(0), "user already register");
        _appStorage.usernameToAddress[_username] = msg.sender;
        _appStorage.addressToUsername[msg.sender] = _username;
        LibAppStorage.Profile storage _userProfile = _appStorage.userProfile[msg.sender];
        _userProfile.username = _username;
        _userProfile.userAdres = msg.sender;
        _userProfile.totalPosts = 0;
        _userProfile.followers =  0;
        _userProfile.following = 0; 
        _appStorage.hasRegistered[msg.sender] = true;
        _appStorage.profileList.push(_userProfile);

        emit RegistrationSuccessful(msg.sender, _username);
        
    }


    function setUpProfile(bytes32 _userBio, string calldata _imageUrl) external {
        require(_userBio != bytes32(0), "invalid description");
        LibAppStorage.Profile storage _foundUser = _appStorage.userProfile[msg.sender];
       _foundUser.userBio  = _userBio;
       _foundUser.imageUrl = _imageUrl;
        emit ProfileSuccessful(msg.sender, _imageUrl, _userBio);
    }


    function getAllUserProfile() external  view returns(LibAppStorage.Profile [] memory) {
      return  _appStorage.profileList;
    }



}