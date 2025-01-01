import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:just_audio/just_audio.dart';
import 'package:my_tube/core/models/video_model.dart';
import 'package:my_tube/getx/play_video_state.dart';
import 'package:my_tube/util/constant.dart';

class SuggestedVideoItem extends StatelessWidget {
  final Video video;
  final VoidCallback clicked;
  const SuggestedVideoItem(
      {super.key, required this.video, required this.clicked});

  @override
  Widget build(BuildContext context) {
    final PlayVideoState _playerState = Get.put(PlayVideoState());

    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () async {
          _playerState.nextClickedVideo(video.id);
          clicked.call();
        },
        child: Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: thirdColor),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 170,
                  width: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            video.thumbnailUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Positioned(
                      //     right: 2,
                      //     bottom: 3,
                      //     child: CustomRoundedShape(
                      //         child: Text(
                      //       video.duration,
                      //       style: textMedium.copyWith(color: secondColor),
                      //     )))
                    ],
                  )),
              const SizedBox(width: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        maxLines: 4,
                        video.title,
                        overflow: TextOverflow
                            .ellipsis, // Add this to handle overflow

                        style: textMedium.copyWith(color: Colors.white),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            video.channelTitle,
                            style: textMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: secondColor),
                          ),
                          const Spacer(),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            '${video.viewCount} views',
                            style: textMedium.copyWith(
                                fontSize: 12, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
