import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/features/videos/models/video_model.dart';
import 'package:flutter_social_media_app/features/videos/ui/upload_video.dart';
import 'package:flutter_social_media_app/repositories/home_repository.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final HomeRepository homeRepository = HomeRepository();
  // bool _isPlaying = false;
  late PageController _pageController;
  late List<Video> _videos = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _loadVideos();
  }

  Future<void> _loadVideos() async {
    try {
      final videos = await homeRepository.getAllVideos();
      setState(() {
        _videos = videos;
      });
    } catch (e) {
      print('Error loading videos: $e');
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: _videos.length,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final video = _videos[_currentIndex];

          return VideoItem(
            video: video,
            onPageChanged: (int newPage) {
              if (newPage == index + 1) {
                _pageController.jumpToPage(0);
              }
            },
          );
        },
      ),
    );
  }
}

class VideoItem extends StatefulWidget {
  final Video video;
  final ValueChanged<int> onPageChanged;

  VideoItem({
    required this.video,
    required this.onPageChanged,
  });

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.network(widget.video.videoUrl)
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
    return Stack(
      children: [
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
        // Other UI components here

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
                  backgroundImage: NetworkImage(widget.video.user.avatar),
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.favorite),
                      color: Colors.white,
                    ),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.message_outlined),
                      color: Colors.white,
                    ),
                    Text(
                      "10",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.reply_outlined),
                      color: Colors.white,
                    ),
                    Text("10", style: TextStyle(color: Colors.white)),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => VideoUploadScreen()),
                        );
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white,
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
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    _videoPlayerController.seekTo(
                      Duration(
                        seconds:
                            _videoPlayerController.value.position.inSeconds -
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
                    color: Colors.white,
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
                    color: Colors.white,
                    size: 40,
                  ),
                  onPressed: () {
                    _videoPlayerController.seekTo(
                      Duration(
                        seconds:
                            _videoPlayerController.value.position.inSeconds +
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
  }
}
