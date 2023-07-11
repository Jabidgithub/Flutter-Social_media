import 'package:flutter/material.dart';

class PostTileWidget extends StatelessWidget {
  const PostTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
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
                      child: Image.asset(
                        'assets/imgs/avatar.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Ahmed Jabid Hasan",
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text("3h"),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Programmer",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(Icons.more_vert)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              "The standard ListView constructor works well for small lists. To work with lists that contain a large number of items, it’s best to use the ListView.builder constructor In contrast to the default ListView constructor, which requires creating all items at once, the ListView.builder() constructor creates items as they’re scrolled onto the screen",
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            width: double.maxFinite,
            child: Image.asset(
              "assets/imgs/jabid.jpg",
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
}
