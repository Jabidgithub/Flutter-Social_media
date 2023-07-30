import 'dart:convert';

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
    String? accessId = prefs.getString('accessId');
    return accessId;
  }

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

  Future<List<Post>> getAllPosts() async {
    try {
      final accessToken = await getAccessToken();
      final response = await http.get(
        Uri.parse(
            'https://orbit-a3ph.onrender.com/api/v1/allpost?postId=&pageSize='),
        headers: {'Authorization': "bearer ${accessToken}"},
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        return jsonList.map((json) => Post.fromJson(json)).toList();
      } else {
        throw Exception('API request failed');
      }
    } catch (e) {
      throw Exception('API request failed');
    }
  }
}
