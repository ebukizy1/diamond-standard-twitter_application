// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;

library LibAppStorage {



struct Post{
    uint8 postId;
    bytes32 content;
    string imageUrl;
    uint numberOfLikes;
    uint numberOfRetweet;
    Comment [] commentedList;
    address [] likersAddress;
    address poster;

}


struct Comment {
    uint8 postId;
    uint8 commentCount;
    string imageUrl;
    bytes32 postComment;
    address commenter;
    }






    struct Profile {
        bytes32 username;
        address userAdres;
        bytes32 userBio;
        uint256 followers;
        uint256 following;
        uint256 totalPosts;
        string imageUrl;
        bool hasLiked;
    }
    
    struct Layout{
        mapping(address =>Profile) userProfile;
        mapping(bytes32 => address) usernameToAddress;
        mapping(address => bytes32) addressToUsername;
        mapping(address => bool) hasRegistered;
        mapping(uint => Post) userPost;
        Post [] postList;
        Profile [] profileList;
        uint8 postId;



        


    }
    
}