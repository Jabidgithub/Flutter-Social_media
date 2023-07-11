import 'package:flutter/material.dart';
import 'features/auth/ui/auth_liquid_screens.dart';

void main() async {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: AuthScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
