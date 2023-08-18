import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_social_media_app/features/home/models/post_model.dart';
import 'package:flutter_social_media_app/logics/Home_bloc/post_bloc/post_bloc.dart';
import 'package:flutter_social_media_app/utiles/widgets/animated_loading.dart';

class UsersPostTileWidget extends StatelessWidget {
  final PostModel postData;
  const UsersPostTileWidget({Key? key, required this.postData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Visiting my post");

    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is DeletingPostState) {
          return AnimatedLoader();
        } else if (state is DeletedPostState) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          child: ClipOval(
                            // Profile Pic
                            child: Image.network(
                              postData.user.avatar,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // user name
                                Text(
                                  postData.user.name,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),

                                // creation date
                                Text(postData.getFormattedCreatedAt()),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Stars",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<PostBloc>(context).add(
                                  DeletePostEvent(postId: postData.postId));
                            },
                            icon: Icon(Icons.delete)),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    postData.title,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    postData.description.toString(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: double.maxFinite,
                  child: Image.network(
                    postData.pictures[0],
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_outline),
                        ),
                        Text("${postData.count["reacts"] as int}"),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.comment),
                        ),
                        Text("${postData.count["comments"] as int}"),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share),
                        ),
                        Text("0"),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          child: ClipOval(
                            // Profile Pic
                            child: Image.network(
                              postData.user.avatar,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                // user name
                                Text(
                                  postData.user.name,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 10,
                                ),

                                // creation date
                                Text(postData.getFormattedCreatedAt()),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Stars",
                              style:
                                  TextStyle(fontSize: 10, color: Colors.grey),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              BlocProvider.of<PostBloc>(context).add(
                                  DeletePostEvent(postId: postData.postId));
                            },
                            icon: Icon(Icons.delete)),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    postData.title,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  child: Text(
                    postData.description.toString(),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 200,
                  width: double.maxFinite,
                  child: Image.network(
                    postData.pictures[0],
                    fit: BoxFit.cover,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_outline),
                        ),
                        Text("10"),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.comment),
                        ),
                        Text("10"),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share),
                        ),
                        Text("10"),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        }
      },
    );
  }
}
