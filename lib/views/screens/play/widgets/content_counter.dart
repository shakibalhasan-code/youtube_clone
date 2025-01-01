import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:my_tube/util/constant.dart';
import 'package:my_tube/views/widgets/custom_rounded_shape.dart';

class ContentCounter extends StatelessWidget {
  final HeroIcons heroIcon;
  final String textData;
  const ContentCounter(
      {super.key, required this.heroIcon, required this.textData});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery for responsive styling
    final iconSize = MediaQuery.of(context).size.width * 0.04;
    final textSize = MediaQuery.of(context).size.width * 0.04;
    return Flexible(
      child: CustomRoundedShape(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HeroIcon(
              heroIcon,
              color: secondColor,
              size: iconSize.clamp(12, 20),
            ),
            const SizedBox(width: 8),
            Text(
              textData,
              style: textMedium.copyWith(
                color: secondColor,
                fontWeight: FontWeight.bold,
                fontSize: textSize.clamp(12, 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
