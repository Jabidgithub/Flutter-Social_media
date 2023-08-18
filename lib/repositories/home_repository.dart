import 'dart:convert';
import 'dart:io';

import 'package:flutter_social_media_app/features/home/models/comment_model.dart';
import 'package:flutter_social_media_app/features/videos/models/video_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_social_media_app/features/home/models/post_model.dart';
import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';

class HomeRepository {
  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    return accessToken;
  }

  Future<String?> getAccessId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessId = prefs.getString('id');
    return accessId;
  }

  //Todo: Load Profile UserData
  Future<UserData?> getUserDataFromSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userDataJson = prefs.getString('UserData');
      if (userDataJson != null) {
        Map<String, dynamic> userDataMap = jsonDecode(userDataJson);

        return UserData.fromJson(userDataMap);
      }
      return null;
    } catch (e) {
      throw Exception(
          'Home Respository Failed to get user data from SharedPreferences.');
    }
  }

  //Todo get all the posts for homePage

  Future<List<PostModel>> getAllPosts() async {
    try {
      final accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse(
            'https://orbit-a3ph.onrender.com/api/v1/allpost?postId=&pageSize='),
        headers: {'Authorization': "bearer ${accessToken}"},
      );

      print("All Post ${response.statusCode} and ${response}");

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final List<dynamic> postDataList = jsonResponse['data'];
        return postDataList.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw Exception('API request failed');
      }
    } catch (e) {
      throw Exception('API request failed $e');
    }
  }

  //Todo Create Post

  Future<bool> createPost(
      String title, String description, List<File> pictures) async {
    try {
      final String? accessToken = await getAccessToken();
      if (accessToken == null) {
        throw Exception("Access Token is not available in post ");
      }
      final request = http.MultipartRequest(
        'POST',
        Uri.parse("https://orbit-a3ph.onrender.com/api/v1/post"),
      );
      request.headers['Authorization'] = "bearer $accessToken";
      request.fields['title'] = title;
      request.fields['description'] = description;

      for (int i = 0; i < pictures.length; i++) {
        final file = pictures[i];
        final stream = http.ByteStream(file.openRead());
        final length = await file.length();
        final multipartFile = http.MultipartFile('pictures', stream, length,
            filename: 'pictures$i.jpg');
        request.files.add(multipartFile);
      }

      final response = await request.send();

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Create Post Error $e");
    }
  }

  //Todo post delete

  Future<bool> deletePost(String postId) async {
    try {
      final response = await http.delete(
        Uri.parse('https://orbit-a3ph.onrender.com/api/v1/post/$postId'),
      );

      // Check if the response was successful (status code 200)
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

// Todo Users all post
  Future<List<PostModel>> getUserPosts(String? accessId) async {
    try {
      final String? userAccessId = accessId ?? await getAccessId();

      final String? accessToken = await getAccessToken();

      print("AccessId -------------------$accessId");
      final response = await http.get(
        Uri.parse(
            'https://orbit-a3ph.onrender.com/api/v1/userallpost/${userAccessId}?postId=undefined&pageSize=2'),
        headers: {'Authorization': 'bearer ${accessToken}'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);

        final List<PostModel> allPosts = jsonList.map((json) {
          return PostModel.fromJson(json as Map<String, dynamic>);
        }).toList();

        return allPosts;
      } else {
        throw Exception();
      }
    } catch (e) {
      throw Exception('API request failed $e');
    }
  }

  //Todo Fined User / route to user
  Future<UserData?> finedUser(String postUserId) async {
    try {
      final String? accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse("https://orbit-a3ph.onrender.com/api/v1/user/${postUserId}"),
        headers: {'Authorization': 'bearer ${accessToken}'},
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body.trim());
        UserData userData = UserData.fromJson(jsonResponse);
        return userData;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Find users Data api error $e");
    }
  }

  //Todo Like a post

  Future<bool> likeACertainPost(String postId, String reactionType) async {
    try {
      final String? accessToken = await getAccessToken();
      final response = await http.put(
        Uri.parse("https://orbit-a3ph.onrender.com/api/v1/react"),
        headers: {"Authorization": "bearer ${accessToken}"},
        body: {"postId": "$postId", "reactType": "$reactionType"},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Liking user Data Error $e");
    }
  }

  // TODO Get list of user who liked
  /*
  Future<bool> listOfPostReaction() async {
    try {
      final String? accessToken = await getAccessToken();

      final response = await http.get(
        Uri.parse("https://orbit-a3ph.onrender.com/api/v1/react"),
        headers: {"Authorization": "bearer ${accessToken}"},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {

      }
    } catch (e) {}
  }
   */

  // TODO Get  Comment

  Future<List<Comment>> getAllComments(String postId) async {
    try {
      final accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse("https://orbit-a3ph.onrender.com/api/v1/comment/${postId}"),
        headers: {'Authorization': "bearer $accessToken"},
      );

      print("All Comments ${response.statusCode} and ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((json) => Comment.fromJson(json)).toList();
      } else {
        throw Exception('API request failed');
      }
    } catch (e) {
      throw Exception('API request failed $e');
    }
  }

  Future<void> postComment(String postId, String comment) async {
    try {
      final accessToken = await getAccessToken();
      final response = await http.post(
        Uri.parse('https://orbit-a3ph.onrender.com/api/v1/comment'),
        headers: {'Authorization': "bearer $accessToken"},
        body: {'postId': postId, 'body': comment},
      );

      if (response.statusCode == 200) {
        print("Comment posted successfully");
      } else {
        print("Failed to post comment: ${response.statusCode}");
      }
    } catch (e) {
      print("Error while posting comment: $e");
    }
  }
  // Todo Load All videos

  Future<List<Video>> getAllVideos() async {
    try {
      final accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse("https://orbit-a3ph.onrender.com/api/v1/reels"),
        headers: {'Authorization': 'bearer $accessToken'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((json) => Video.fromJson(json)).toList();
      } else {
        throw Exception('API request failed');
      }
    } catch (e) {
      throw Exception('API request failed $e');
    }
  }

  // Todo Load Users Videos

  Future<List<Video>> getUsersAllVideos(String userId) async {
    try {
      final accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse("https://orbit-a3ph.onrender.com/api/v1/reels/${userId}"),
        headers: {'Authorization': 'bearer $accessToken'},
      );

      print("Response Status Code is ${response.statusCode}");

      if (response.statusCode == 200) {
        final List<dynamic> jsonResponse = json.decode(response.body);
        return jsonResponse.map((json) => Video.fromJson(json)).toList();
      } else {
        throw Exception('API request failed');
      }
    } catch (e) {
      throw Exception('API request failed $e');
    }
  }

  // Todo Create Video
  Future<void> uploadVideo(String description, String videoFilePath) async {
    try {
      final accessToken =
          await getAccessToken(); // Replace with your access token retrieval logic
      final uri = Uri.parse("https://orbit-a3ph.onrender.com/api/v1/reels");

      var request = http.MultipartRequest('POST', uri)
        ..headers['Authorization'] = 'bearer $accessToken'
        ..fields['description'] = description
        ..files.add(await http.MultipartFile.fromPath('video', videoFilePath));

      final response = await request.send();

      if (response.statusCode == 200) {
        print('Video uploaded successfully');
      } else {
        print('Failed to upload video ${response.statusCode}');
      }
    } catch (e) {
      print('Error uploading video: $e');
    }
  }

  // Todo Follow Unfollow
  Future<String> followUser(String followerId) async {
    try {
      final accessToken =
          await getAccessToken(); // Replace with your access token retrieval logic
      final uri = Uri.parse("https://orbit-a3ph.onrender.com/api/v1/follow");

      final response = await http.put(
        uri,
        headers: {'Authorization': 'bearer $accessToken'},
        body: {'followerId': followerId},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        final status = jsonResponse['status'];

        if (status == 'Follow') {
          return 'UnFollow';
        } else if (status == 'unFollow') {
          return 'Follow';
        } else {
          return 'Unexpected status: $status';
        }
      } else {
        return 'Failed to follow user ${response.statusCode}';
      }
    } catch (e) {
      return 'Error following user: $e';
    }
  }
}
