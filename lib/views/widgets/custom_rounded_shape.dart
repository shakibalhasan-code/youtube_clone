import 'package:flutter/material.dart';
import 'package:my_tube/util/constant.dart';

class CustomRoundedShape extends StatelessWidget {
  final Widget child;
  const CustomRoundedShape({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(10)),
      child:
          Padding(padding: EdgeInsets.symmetric(horizontal: 5), child: child),
    );
  }
}
