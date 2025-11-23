import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';

class UCircularContainer extends StatelessWidget {
  const UCircularContainer({
    super.key,
    this.height = 400,
    this.width = 400,
    this.backgroundColor = UColors.white,
    this.padding,
    this.margin,
    this.child,
  });

// yha kab variable define karte hai
  final double height, width;
  final Color backgroundColor;
  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    // aur yha kab variable define karte hai

    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1000),
        color: backgroundColor,
      ),
      child: child,
    );
  }
}
