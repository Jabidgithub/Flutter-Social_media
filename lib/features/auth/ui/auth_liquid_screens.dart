import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/utiles/constants/constants.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: authPages,
        enableLoop: false,
        initialPage: 0,
      ),
    );
  }
}
