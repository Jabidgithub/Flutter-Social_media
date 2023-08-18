import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';
import 'package:flutter_social_media_app/features/profile/ui/activity_screen.dart';
import 'package:flutter_social_media_app/features/profile/ui/more_option_screen.dart';
import 'package:flutter_social_media_app/features/profile/ui/profile_posts_screen.dart';
import 'package:flutter_social_media_app/features/profile/ui/profile_videos_screen.dart';

class MyProfile extends StatefulWidget {
  final UserData userData;

  const MyProfile({super.key, required this.userData});

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "${widget.userData.name}",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.redAccent),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.userData.avatar),
              ),
              const SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Activity",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                width:
                    MediaQuery.of(context).size.width, // Specify a fixed width
                height:
                    MediaQuery.of(context).size.width, // Specify a fixed height
                child: Analytics(
                  comments: 5,
                  followers: widget.userData.count.followers.toDouble(),
                  followings: widget.userData.count.following.toDouble(),
                  likes: widget.userData.count.reacts.toDouble(),
                  posts: widget.userData.count.posts.toDouble(),
                  videos: widget.userData.count.posts.toDouble(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileVideos(
                                  userId: widget.userData.id,
                                ),
                              ),
                            );
                          },
                          icon: Icon(Icons.video_library_sharp)),
                      const Text(
                        "Your Videos",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UsersAllPosts()));
                          },
                          icon: Icon(Icons.post_add_outlined)),
                      const Text(
                        "Your Posts",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  toMorePage(context, widget.userData);
                },
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                    child: Text(
                      "More",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

toMorePage(context, userData) {
  Navigator.push(
      context,
      PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => MoreOptions(
                userData: userData,
              ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = Offset(1.0, 0.0);
            var end = Offset.zero;
            var curve = Curves.ease;

            var tween =
                Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          }));
}
