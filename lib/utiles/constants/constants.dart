import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/features/auth/ui/auth_email.dart';
import 'package:flutter_social_media_app/features/auth/ui/auth_signin.dart';
import 'package:flutter_social_media_app/features/auth/ui/auth_signup.dart';
import 'package:flutter_social_media_app/features/auth/ui/auth_welcone.dart';
import 'package:flutter_social_media_app/features/home/ui/home_page.dart';
import 'package:flutter_social_media_app/features/post/ui/add_post_screen.dart';
import 'package:flutter_social_media_app/features/videos/ui/video_reels.dart';

final authPages = [
  const AuthWelcome(), // welcome screen
  const AuthEmail(), // email screen
  const AuthSignUp(), // signIn Screen
  const AuthSignIn(), // SignUp Screen
];

final List<Widget> navigationPages = [
  HomePage(), // home page
  AddPost(), // Post page
  VideoScreen(), // video page
  Container(), // messages
  Container(), // search page
];

class AppColors {
  static const Color primaryAuthColor = Colors.white;
  static Color secondaryAuthColor = Colors.grey.shade100;
  static const Color errorThirdColor = Colors.white;
  static const Color buttonColor = Colors.redAccent;

  // Define other colors...
}
