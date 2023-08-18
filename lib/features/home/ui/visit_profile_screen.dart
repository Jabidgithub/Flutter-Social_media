import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/features/home/ui/visit_user_all_posts.dart';
import 'package:flutter_social_media_app/features/profile/models/profile_user_model.dart';
import 'package:flutter_social_media_app/features/profile/ui/activity_screen.dart';
import 'package:flutter_social_media_app/features/profile/ui/profile_videos_screen.dart';
import 'package:flutter_social_media_app/repositories/home_repository.dart';

class VisitProfile extends StatefulWidget {
  final UserData userData;
  const VisitProfile({super.key, required this.userData});

  @override
  State<VisitProfile> createState() => _VisitProfileState();
}

class _VisitProfileState extends State<VisitProfile> {
  bool isFollowing = false;
  final HomeRepository homeRepository = HomeRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.userData.name,
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
              InkWell(
                // Follow button
                onTap: () async {
                  setState(() {
                    isFollowing = !isFollowing; // Toggle the follow status
                  });
                  // Call your follow/unfollow API here and handle errors if needed
                  await homeRepository.followUser(widget.userData.id);
                },
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(15)),
                  width: 120,
                  child: Center(
                    child: Text(
                      isFollowing ? "Follow" : "UnFollow",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
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
                        "Videos",
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
                                    builder: (context) => VisitUsersAllPosts(
                                          userAccessId: widget.userData.id,
                                        )));
                          },
                          icon: Icon(Icons.post_add_outlined)),
                      const Text(
                        "Posts",
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
            ],
          ),
        ),
      ),
    );
  }
}
