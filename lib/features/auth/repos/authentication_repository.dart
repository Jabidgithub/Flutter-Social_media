import 'dart:convert';
import 'dart:io';

import 'package:flutter_social_media_app/features/auth/models/AuthenticationResponse.dart';
import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http_parser/http_parser.dart';

class AuthenticationRepository {
  Future<AuthenticationResponse> verifyEmail(String email) async {
    try {
      final response = await http.post(
        Uri.parse('https://orbit-a3ph.onrender.com/api/v1/emailverification'),
        body: {'email': email},
      );

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        print(
            "This Account is ${AuthenticationResponse.fromJson(jsonResponse).user}");
        return AuthenticationResponse.fromJson(jsonResponse);
      } else {
        throw Exception('API request failed');
      }
    } catch (e) {
      throw Exception('API error: $e');
    }
  }

  Future<void> saveAccessToken(String accessToken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
  }

  Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    return accessToken;
  }

  Future<void> saveAccessId(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('id', id);
  }

  Future<String?> getAccessId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessId = prefs.getString('id');
    return accessId;
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

  Future<void> saveUserDataToSharedPreferences(UserData userData) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String userDataJson = jsonEncode(userData.toJson());
      await prefs.setString('UserData', userDataJson);
    } catch (e) {
      throw Exception('Failed to save user data to SharedPreferences.');
    }
  }

  Future<String> loginFunction(String email, String password) async {
    print("This account email is ${email} and password is ${password}");

    try {
      final response = await http.post(
        Uri.parse('https://orbit-a3ph.onrender.com/api/v1/getaccess'),
        body: {'email': email, 'password': password},
      );

      print("Response ${response.body} statuscode  ${response.statusCode}");

      if (response.statusCode == 202) {
        final jsonResponse = json.decode(response.body);
        final String accessToken = jsonResponse['accessToken'];
        final String accessId = jsonResponse['id'];

        await saveAccessToken(accessToken);
        await saveAccessId(accessId);

        return accessToken;
      } else {
        throw Exception('API request failed');
      }
    } catch (e) {
      print("Problem in API");
      print(e.toString());
      throw Exception('API error: $e');
    }
  }

  Future<String> signUpFunction(String name, String location, String phone,
      String gender, File profilePic) async {
    String? accessToken = await getAccessToken();
    try {
      final uri = Uri.parse('https://orbit-a3ph.onrender.com/api/v1/userinfo');
      final request = http.MultipartRequest('PUT', uri);
      request.fields['name'] = name;
      request.fields['location'] = location;
      request.fields['phone'] = phone;
      request.fields['gender'] = gender;

      // Add the profile picture as a file field
      final fileStream =
          http.ByteStream(Stream.castFrom(profilePic.openRead()));
      final fileLength = await profilePic.length();
      final imageType = lookupMimeType(profilePic.path);

      final multipartFile = http.MultipartFile(
        'avatar',
        fileStream,
        fileLength,
        filename: profilePic.path.split('/').last,
        contentType: MediaType('image', imageType!),
      );
      request.files.add(multipartFile);

      request.headers['Content-Type'] =
          'multipart/form-data; boundary=<calculated when request is sent>';

      if (accessToken != null) {
        request.headers['Authorization'] = 'Bearer ${accessToken}';
      } else {
        print('Access tocken is null');
      }

      final response = await request.send();
      final responseString = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(responseString);
        final String responseStatus = jsonResponse['info'];

        return responseStatus.toString();
      } else {
        throw Exception(
            'API request failed with status code ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API error: $e');
    }
  }
}
