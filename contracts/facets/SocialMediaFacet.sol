// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.9;
import {LibAppStorage} from "../libraries/LibAppStorage.sol";

contract SocialMediaFacet{
    LibAppStorage.Layout internal _appStorage;

    event PostCreatedSuccessful(address indexed sender,uint indexed postId,string _imageUrl);
    event CommentSuccessful(address indexed _sender,uint8 indexed _postId,bytes32  _comment);


function createPost(bytes32 _content, string memory _imageUrl) external {
       uint8 _postId = _appStorage.postId + 1;
       LibAppStorage.Profile storage _foundUser = _appStorage.userProfile[msg.sender];
       LibAppStorage.Post storage _newPost = _appStorage.userPost[_postId];  
       _newPost.postId = _postId;
       _newPost.content = _content;
       _newPost.imageUrl =  _imageUrl;
       _newPost.poster = msg.sender;
       _foundUser.totalPosts = _foundUser.totalPosts + 1; 
        _appStorage.postList.push(_newPost);
        emit PostCreatedSuccessful(msg.sender, _foundUser.totalPosts, _imageUrl);
}

function commentOnPost(uint8 _postId, bytes32 _comment, string calldata _imageUrl) external{
     LibAppStorage.Post storage _foundPost = _appStorage.userPost[_postId]; 
      LibAppStorage.Comment memory _newComment;
      _newComment.postId = _foundPost.postId;
      _newComment.postComment = _comment;
      _newComment.imageUrl = _imageUrl;
      _newComment.commentCount = _newComment.commentCount + 1;
      _newComment.commenter = msg.sender;

      _foundPost.commentedList.push(_newComment);
      emit CommentSuccessful(msg.sender,_postId,_comment);
}
 
function fetchAllUserComment(uint8 _postId) external view returns(LibAppStorage.Comment [] memory) {
          LibAppStorage.Post storage _foundPost = _appStorage.userPost[_postId];
    return   _foundPost.commentedList;
}

//like post and also unlike post if you have liked that post
function likePost(uint8 _postId) external {
      LibAppStorage.Post storage _foundPost = _appStorage.userPost[_postId];
        LibAppStorage.Profile storage _userProfile = _appStorage.userProfile[msg.sender];

        if (_userProfile.hasLiked) {
            // Unlike post
            _foundPost.numberOfLikes--;
            _removeLiker(_foundPost, msg.sender);
            _userProfile.hasLiked = false;
        } else {
            // Like post
            _foundPost.numberOfLikes++;
            _foundPost.likersAddress.push(msg.sender);
            _userProfile.hasLiked = true;
        }
    }
     





 function _removeLiker(LibAppStorage.Post storage _post, address _liker) internal {
        for (uint256 i = 0; i < _post.likersAddress.length; i++) {
            if (_post.likersAddress[i] == _liker) {
                _post.likersAddress[i] = _post.likersAddress[_post.likersAddress.length - 1];
                _post.likersAddress.pop();
                return;
            }
        }
    }




}
