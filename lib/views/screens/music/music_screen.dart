import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_tube/getx/music_state.dart';
import 'package:my_tube/views/items/video_item.dart';

class MusicScreen extends StatelessWidget {
  const MusicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MusicState _musicState = Get.put(MusicState());

    return Expanded(
        child: FutureBuilder(
            future: _musicState.fetchMusicVideo(100),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Obx(() {
                  return ListView.builder(
                      itemCount: _musicState.musicVideos.length,
                      itemBuilder: (context, index) {
                        final video = _musicState.musicVideos[index];
                        return VideoItem(video: video);
                      });
                });
              }
            }));
  }
}
