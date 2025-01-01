import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:my_tube/util/constant.dart';

class MarqueeTextWidget extends StatelessWidget {
  final String text;
  const MarqueeTextWidget({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      child: Marquee(
        scrollAxis: Axis.horizontal,
        text: text,
        style: videoTitleStyle.copyWith(color: secondColor),
        crossAxisAlignment: CrossAxisAlignment.start,
        blankSpace: 20.0,
        velocity: 100.0,
        pauseAfterRound: Duration(seconds: 10),
        startPadding: 10.0,
        accelerationDuration: Duration(seconds: 5),
        accelerationCurve: Curves.linear,
        decelerationDuration: Duration(milliseconds: 800),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}
