import 'package:flutter/material.dart';
import 'package:my_tube/core/models/video_model.dart';
import 'package:my_tube/util/constant.dart';
import 'package:my_tube/views/screens/play/video_player.dart';
import 'package:my_tube/views/widgets/custom_rounded_shape.dart';

import '../../../core/models/search_model.dart';

class HorizentalVideoItem extends StatelessWidget {
  final Video video;
  const HorizentalVideoItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(video: video)));
        },
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: thirdColor),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                  height: 100,
                  width: 100,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      maxLines: 4,
                      video.title,
                      overflow:
                          TextOverflow.ellipsis, // Add this to handle overflow

                      style: textMedium.copyWith(color: Colors.white),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.channelTitle,
                          style: textMedium.copyWith(
                              fontWeight: FontWeight.bold, color: secondColor),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
