import 'package:flutter/material.dart';
import 'package:my_tube/core/models/video_model.dart';
import 'package:my_tube/util/constant.dart';
import 'package:y_player/y_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final Video video;
  const VideoPlayerScreen({super.key, required this.video});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late String videoId;

  @override
  void initState() {
    super.initState();
    videoId = widget.video.id;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          YPlayer(
            youtubeUrl: 'https://www.youtube.com/watch?v=$videoId',
            onStateChanged: (status) {
              print('Player Status: $status');
            },
            onProgressChanged: (position, duration) {
              print('Progress: ${position.inSeconds}/${duration.inSeconds}');
            },
            onControllerReady: (controller) {
              print('Controller is ready!');
            },
          ),
        ],
      ),
    );
  }
}
