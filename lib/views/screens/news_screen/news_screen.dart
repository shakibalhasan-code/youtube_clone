import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:my_tube/getx/news_state.dart';
import 'package:my_tube/views/items/video_item.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final NewsState _newsState = Get.put(NewsState());
    return Expanded(
        child: FutureBuilder(
            future: _newsState.fetchNewsVideo(100),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                return ListView.builder(
                  itemCount: _newsState.newsVideos.length,
                  itemBuilder: (context, index) {
                    final video = _newsState.newsVideos[index];
                    return VideoItem(video: video);
                  },
                );
              }
            }));
  }
}
