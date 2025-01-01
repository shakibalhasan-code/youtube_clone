import 'package:flutter/material.dart';
import 'package:my_tube/core/models/video_model.dart';
import 'package:my_tube/util/constant.dart';
import 'package:my_tube/views/screens/play/video_player.dart';

class SmallHorizentalVideoItem extends StatelessWidget {
  final Video video;
  const SmallHorizentalVideoItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => VideoPlayerScreen(video: video)));
      },
      child: Container(
        height: 100, // Fixed height for the grid item
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: thirdColor,
        ),
        child: Row(
          children: [
            SizedBox(
              height:
                  100, // Ensure the image is square and matches the item height
              width: 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  video.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    video.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textMedium.copyWith(
                      color: Colors.white,
                      fontSize: 12, // Smaller font size for better fit
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    video.channelTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: secondColor,
                      fontSize: 10, // Smaller font size for better fit
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
