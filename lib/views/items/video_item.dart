import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_tube/core/models/video_model.dart';
import 'package:my_tube/util/constant.dart';
import 'package:my_tube/views/screens/play/video_player.dart';
import 'package:my_tube/views/screens/trends_screen/widgets/custom_essential.dart';
import 'package:my_tube/views/widgets/custom_rounded_shape.dart';

class VideoItem extends StatelessWidget {
  final Video video;
  const VideoItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(video: video),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          height: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                height: 230,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        video.thumbnailUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.1),
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: CustomRoundedShape(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            video.duration,
                            style: textMedium.copyWith(
                                fontWeight: FontWeight.bold,
                                color: secondColor),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 5,
                      top: 5,
                      child: CustomRoundedShape(
                        child: Row(
                          children: [
                            MyIcon(HeroIcons.eye),
                            const SizedBox(width: 5),
                            Text(
                              video.viewCount ?? '0',
                              style: textMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: secondColor),
                            ),
                            const SizedBox(width: 10),
                            MyIcon(HeroIcons.handThumbUp),
                            const SizedBox(width: 5),
                            Text(
                              video.likeCount ?? '0',
                              style: textMedium.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: secondColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 3),
              Flexible(
                child: Text(
                  video.title,
                  style: videoTitleStyle.copyWith(color: Colors.white),
                ),
              ),
              Text(
                video.channelTitle,
                style: textMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: secondColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
