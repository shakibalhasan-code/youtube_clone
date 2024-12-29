import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:heroicons/heroicons.dart';
import 'package:http/http.dart' as http;
import 'package:my_tube/getx/home_state.dart';
import 'package:my_tube/getx/services/location_services.dart';
import 'package:my_tube/views/items/video_item.dart';
import 'package:my_tube/views/screens/trends_screen/widgets/custom_essential.dart';

import '../../../util/constant.dart';

class TrendingScreenVideos extends StatefulWidget {
  @override
  State<TrendingScreenVideos> createState() => _TrendingScreenVideosState();
}

class _TrendingScreenVideosState extends State<TrendingScreenVideos> {
  final TrendState _homeState = Get.put(TrendState());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            children: [
              MyIcon(HeroIcons.arrowTrendingUp),
              const SizedBox(
                width: 5,
              ),
              Text(
                'Trend Videos',
                style: videoTitleStyle.copyWith(color: Colors.white),
              ),
              // Spacer(),
              // MyIcon(HeroIcons.chevronDoubleRight),
            ],
          ),
          Expanded(
              child: FutureBuilder(
                  future: _homeState.fetchTrendVideo(20),
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
                          itemCount: _homeState.trendVideos.length,
                          itemBuilder: (context, index) {
                            return VideoItem(
                                video: _homeState.trendVideos[index]);
                          });
                    }
                  }))
        ],
      ),
    );
  }
}
