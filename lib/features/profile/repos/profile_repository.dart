import 'dart:convert';

import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfileRepository {
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

  Future<void> saveUserDataToSharedPreferences(UserData userData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userDataJson = jsonEncode(userData.toJson());
      await prefs.setString('UserData', userDataJson);
    } catch (e) {
      throw Exception('Failed to save user data to SharedPreferences.');
    }
  }

  Future<UserData> getUserData() async {
    try {
      final String? accessToken = await getAccessToken();
      final String? accessId = await getAccessId();

      if (accessToken == null) {
        throw Exception('Access token not available.');
      }

      final response = await http.get(
        Uri.parse('https://orbit-a3ph.onrender.com/api/v1/user/$accessId'),
        headers: {
          'Authorization': "bearer ${accessToken}",
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        UserData userData = UserData.fromJson(jsonResponse);
        // Save userData to SharedPreferences
        await saveUserDataToSharedPreferences(userData);

        return UserData.fromJson(jsonResponse);
      } else {
        throw Exception('API request failed');
      }
    } catch (e) {
      throw Exception('API error: $e');
    }
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
      throw Exception('Failed to get user data from SharedPreferences.');
    }
  }

  Future<void> clearSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
