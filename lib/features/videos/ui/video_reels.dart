import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController _videoPlayerController;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.asset('assets/video/video.mp4')
          ..initialize().then((value) {
            setState(() {
              _videoPlayerController.setLooping(true);
            });
          });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: 2,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // _videoPlayerController.value.isInitialized
              //     ? AspectRatio(
              //         aspectRatio: 16 / 9,
              //         child: Expanded(
              //           child: VideoPlayer(_videoPlayerController),
              //         ),
              //       )
              //     : Center(
              //         child: CircularProgressIndicator(),
              //       ),
              Positioned.fill(
                child: Container(
                  color: Colors.black,
                  child: _videoPlayerController.value.isInitialized
                      ? AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController),
                        )
                      : Container(),
                ),
              ),

              Positioned(
                top: MediaQuery.of(context).size.height * 0.3,
                right: 20,
                child: Container(
                  width: 50,
                  height: 400,
                  color: Colors.transparent,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.redAccent,
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.favorite),
                          ),
                          Text("10"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.message_outlined),
                          ),
                          Text("10"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.reply_outlined),
                          ),
                          Text("10"),
                        ],
                      ),
                      Column(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.add),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_double_arrow_left_outlined,
                          color: Colors.red,
                          size: 40,
                        ),
                        onPressed: () {
                          _videoPlayerController.seekTo(
                            Duration(
                              seconds: _videoPlayerController
                                      .value.position.inSeconds -
                                  10,
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          _videoPlayerController.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.red,
                          size: 40,
                        ),
                        onPressed: () {
                          if (_videoPlayerController.value.isPlaying) {
                            _videoPlayerController.pause();
                          } else {
                            _videoPlayerController.play();
                          }
                          setState(() {});
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.keyboard_double_arrow_right_outlined,
                          color: Colors.red,
                          size: 40,
                        ),
                        onPressed: () {
                          _videoPlayerController.seekTo(
                            Duration(
                              seconds: _videoPlayerController
                                      .value.position.inSeconds +
                                  10,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
