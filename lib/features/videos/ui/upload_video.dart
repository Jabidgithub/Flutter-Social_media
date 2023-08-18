import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_social_media_app/repositories/home_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class VideoUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  final HomeRepository homeRepository = HomeRepository();
  VideoPlayerController? _videoPlayerController;
  File? _selectedVideo;
  String _description = "";

  Future<void> _pickVideo() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      final File videoFile = File(pickedVideo.path);

      // Dispose the previous controller before initializing a new one
      _videoPlayerController?.dispose();

      setState(() {
        _selectedVideo = videoFile;
        _videoPlayerController = VideoPlayerController.file(_selectedVideo!);
      });

      // Initialize the VideoPlayerController outside of the setState callback
      await _videoPlayerController!.initialize();
    }
  }

  Future<void> _uploadVideo() async {
    if (_selectedVideo == null) {
      return;
    }

    try {
      await homeRepository
          .uploadVideo(_description, _selectedVideo!.path)
          .whenComplete(() {
        setState(() {
          _description = "";
          _selectedVideo = null;
        });
      });
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Upload Video",
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.redAccent,
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.redAccent),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                onPressed: _pickVideo,
                child: const Text('Select Video'),
              ),
              SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  setState(() {
                    _description = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.redAccent),
                ),
                onPressed: _uploadVideo,
                child: const Text('Upload Video'),
              ),
              SizedBox(height: 16),
              if (_selectedVideo != null)
                AspectRatio(
                  aspectRatio: _videoPlayerController!.value.aspectRatio,
                  child: VideoPlayer(_videoPlayerController!),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
