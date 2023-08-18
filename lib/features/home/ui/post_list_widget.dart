import 'package:bottom_sheet/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feed_reaction/flutter_feed_reaction.dart';
import 'package:flutter_social_media_app/features/home/models/comment_model.dart';

import 'package:flutter_social_media_app/features/home/models/post_model.dart';
import 'package:flutter_social_media_app/logics/Home_bloc/other_profile_bloc/other_profile_bloc.dart';
import 'package:flutter_social_media_app/repositories/home_repository.dart';

final List<String> reactionTypes = [
  "like",
  "love",
  "haha",
  "sad",
  "wow",
  "angry"
];

class PostTileWidget extends StatefulWidget {
  final PostModel postData;
  PostTileWidget({Key? key, required this.postData}) : super(key: key);

  @override
  State<PostTileWidget> createState() => _PostTileWidgetState();
}

class _PostTileWidgetState extends State<PostTileWidget> {
  final _reactions = [
    FeedReaction(
      header: const ReactionTitle(
        title: 'like',
      ),
      reaction: Image.asset(
        'assets/imgs/like.png',
        width: 35.0,
        height: 35.0,
      ),
      id: 0,
    ),
    FeedReaction(
      header: const ReactionTitle(
        title: 'love',
      ),
      reaction: Image.asset(
        'assets/imgs/love.png',
        width: 35.0,
        height: 35.0,
      ),
      id: 1,
    ),
    FeedReaction(
      header: const ReactionTitle(
        title: 'haha',
      ),
      reaction: Image.asset(
        'assets/imgs/haha.png',
        width: 35.0,
        height: 35.0,
      ),
      id: 2,
    ),
    FeedReaction(
      header: const ReactionTitle(
        title: 'sad',
      ),
      reaction: Image.asset(
        'assets/imgs/sad.png',
        width: 35.0,
        height: 35.0,
      ),
      id: 3,
    ),
    FeedReaction(
      header: const ReactionTitle(
        title: 'wow',
      ),
      reaction: Image.asset(
        'assets/imgs/wow.png',
        width: 35.0,
        height: 35.0,
      ),
      id: 4,
    ),
    FeedReaction(
      header: const ReactionTitle(
        title: 'angry',
      ),
      reaction: Image.asset(
        'assets/imgs/angry.png',
        width: 35.0,
        height: 35.0,
      ),
      id: 5,
    ),
  ];

  FeedReaction? _selectedReaction;
  int _totalLikes = 0;

  @override
  void initState() {
    super.initState();
    _totalLikes = widget.postData.count["Reacts"] as int;
    if (widget.postData.reacts.isNotEmpty) {
      _selectedReaction = FeedReaction(
        header: const ReactionTitle(
          title: 'like',
        ),
        reaction: Image.asset(
          'assets/imgs/${widget.postData.reacts[0].type}.png',
          width: 35.0,
          height: 35.0,
        ),
        id: reactionTypes.indexOf("${widget.postData.reacts[0]}"),
      );
    }
  }

  final HomeRepository homeRepository = HomeRepository();
  List<Comment> _comments = []; // Maintain the list of comments

  Future<void> _loadComments() async {
    try {
      print("Loaded again all comment");
      final comments =
          await homeRepository.getAllComments(widget.postData.postId);
      setState(() {
        _comments = comments;
      });
    } catch (e) {
      print("Error loading comments: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    print("FeedReaction value is ${_selectedReaction} and ${_totalLikes}");

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
                  InkWell(
                    onTap: () {
                      BlocProvider.of<OtherProfileBloc>(context).add(
                          LoadOtherUserDataEvent(
                              postUserId: widget.postData.userId));
                    },
                    child: CircleAvatar(
                      radius: 20,
                      child: ClipOval(
                        // Profile Pic
                        child: Image.network(
                          widget.postData.user.avatar,
                          fit: BoxFit.cover,
                        ),
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
                            widget.postData.user.name,
                            style: TextStyle(
                                fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 10,
                          ),

                          // creation date
                          Text(widget.postData.getFormattedCreatedAt()),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Stars",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.more_vert)
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              widget.postData.title,
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            child: Text(
              widget.postData.description.toString(),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Container(
            height: 200,
            width: double.maxFinite,
            child: Image.network(
              widget.postData.pictures[0],
              fit: BoxFit.cover,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  FlutterFeedReaction(
                    reactions: _reactions,
                    dragSpace: 50,
                    onPressed: () async {
                      try {
                        await homeRepository
                            .likeACertainPost(widget.postData.postId, "like")
                            .whenComplete(() {
                          print("onPressed Reaction done");
                        });
                        setState(() {
                          if (_selectedReaction == null) {
                            _selectedReaction = FeedReaction(
                              header: const ReactionTitle(
                                title: 'like',
                              ),
                              reaction: Image.asset(
                                'assets/imgs/like.png',
                                width: 35.0,
                                height: 35.0,
                              ),
                              id: 0,
                            );
                            _totalLikes++;
                          } else {
                            _selectedReaction = null;
                            _totalLikes--;
                          }
                        });
                      } catch (e) {
                        // Handle API call error
                        print("Error liking post: $e");
                      }

                      print("Reacted");
                    },
                    onReactionSelected: (val) async {
                      try {
                        await homeRepository
                            .likeACertainPost(
                                widget.postData.postId, reactionTypes[val.id])
                            .whenComplete(() {
                          print("onSelected Reaction done");
                        });
                        setState(() {
                          _selectedReaction = val;
                          _totalLikes++;
                        });
                      } catch (e) {
                        print("Error liking post: $e");
                      }
                    },
                    prefix: _selectedReaction != null
                        ? _selectedReaction?.reaction as Image
                        : Image.asset(
                            "assets/imgs/reaction.png",
                            width: 35,
                          ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  Text("${_totalLikes}"),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      await _loadComments().whenComplete(() {
                        showFlexibleBottomSheet(
                          minHeight: 0,
                          initHeight: 0.8,
                          maxHeight: 0.8,
                          context: context,
                          builder:
                              (context, scrollController, bottomSheetOffset) =>
                                  _buildBottomSheet(
                            context,
                            scrollController,
                            bottomSheetOffset,
                            _comments,
                            homeRepository as HomeRepository,
                            widget.postData.postId,
                            _loadComments,
                          ),
                          isExpand: true,
                        );
                      });
                    },
                    icon: Icon(Icons.comment),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("${widget.postData.count["comments"] as int}"),
                ],
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.share),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text("0"),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class ReactionTitle extends StatelessWidget {
  final String title;
  const ReactionTitle({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child: Text(
        title,
        style: TextStyle(color: Colors.white, fontSize: 5),
      ),
    );
  }
}

Widget _buildBottomSheet(
  BuildContext context,
  ScrollController scrollController,
  double bottomSheetOffset,
  List<Comment> comments,
  HomeRepository homeRepository,
  postId,
  refreshComment,
) {
  return Material(
    child: SingleChildScrollView(
      reverse: true,
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.8,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Comment",
              style: TextStyle(
                fontSize: 18,
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Divider(color: Colors.black, thickness: 1.20),
            SizedBox(
              height: 15,
            ),
            Container(
              color: Colors.grey[100],
              height: MediaQuery.of(context).size.height * 0.62,
              child: comments.isEmpty
                  ? Center(
                      child: Text("No comments available"),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: comments.length,
                            itemBuilder: (context, index) {
                              final reversedIndex = comments.length - 1 - index;
                              return CommentContainerTile(
                                comment: comments[reversedIndex],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
            ),
            Spacer(),
            CommentInputBox(
              postId: postId,
              homeRepository: homeRepository,
              refreshComments: refreshComment,
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    ),
  );
}

class CommentContainerTile extends StatelessWidget {
  final Comment comment;

  CommentContainerTile({
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            radius: 20,
            backgroundImage:
                NetworkImage(comment.user.avatar!) as ImageProvider,
          ),
        ),
        // Comment Container
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(15),
            margin: const EdgeInsets.only(right: 15, bottom: 15),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "${comment.user.name}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.redAccent,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${comment.getFormattedCreateAt()}",
                      style: TextStyle(fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  "${comment.body}",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class CommentInputBox extends StatelessWidget {
  final TextEditingController textEditingController = TextEditingController();
  final String postId;
  final HomeRepository homeRepository;
  final refreshComments;

  CommentInputBox({
    super.key,
    required this.postId,
    required this.homeRepository,
    required this.refreshComments,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  await homeRepository
                      .postComment(postId, textEditingController.text)
                      .whenComplete(() {
                    textEditingController.clear();
                    refreshComments(); // Call the refresh method to reload comments
                  });
                },
                icon: Icon(Icons.comment),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: textEditingController,
                    maxLines: null, // Allow for multiple lines of text
                    decoration: InputDecoration(
                      hintText: 'Write a comment...',
                      border: InputBorder.none,
                      fillColor: Colors.grey,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
