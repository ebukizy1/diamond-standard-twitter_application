// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import {LibAppStorage} from "../libraries/LibAppStorage.sol";

contract SocialMediaFacet{
    LibAppStorage.Layout internal _appStorage;

    event PostCreatedSuccessful(address indexed sender,uint indexed postId,string _imageUrl);
    event CommentSuccessful(address indexed _sender,uint8 indexed _postId,bytes32  _comment);


function createPost(bytes32 _content, string memory _imageUrl) external {
       uint8 _postId = _appStorage.postId + 1;
       LibAppStorage.Post storage _newPost = _appStorage.userPost[_postId];  
       _newPost.postId = _postId;
       _newPost.content = _content;
       _newPost.imageUrl =  _imageUrl;
       _newPost.poster = msg.sender;
        _appStorage.postList.push(_newPost);
        emit PostCreatedSuccessful(msg.sender, _newPost.postId, _imageUrl);
}

function commentOnPost(uint8 _postId, bytes32 _comment, string calldata _imageUrl) external{
      LibAppStorage.Comment memory _newComment;
      _newComment.postId = _postId;
      _newComment.postComment = _comment;
      _newComment.imageUrl = _imageUrl; 
      _newComment.commenter = msg.sender;

      LibAppStorage.Post storage _foundPost = _appStorage.userPost[_postId]; 
      _foundPost.commentedList.push(_newComment);
      emit CommentSuccessful(msg.sender,_postId,_comment);
      
}




}
