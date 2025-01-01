import 'package:flutter/material.dart';
import 'package:my_tube/util/constant.dart';

class CustomRoundedShape extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? borderRadius;
  const CustomRoundedShape(
      {super.key, required this.child, this.color, this.borderRadius});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color ?? Colors.black,
          borderRadius: BorderRadius.circular(borderRadius ?? 10)),
      child:
          Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: child),
    );
  }
}
