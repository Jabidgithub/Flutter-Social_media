import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/features/home/models/post_model.dart';

class PostTileWidget extends StatelessWidget {
  final Post postData;
  // const PostTileWidget({super.key, required this.postData});
  const PostTileWidget({Key? key, required this.postData}) : super(key: key);

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
                      child: Image.network(
                        postData.pictures[0].toString(),
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
                          Text(
                            postData.userId.toString(),
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(postData.createAt.toString()),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        postData.title.toString(),
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
}
