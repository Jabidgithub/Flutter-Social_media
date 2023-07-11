import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/features/home/ui/post_list_widget.dart';

class ProfilePosts extends StatelessWidget {
  const ProfilePosts({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Posts",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.redAccent),
      ),
      body: Container(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) {
                  return PostTileWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
