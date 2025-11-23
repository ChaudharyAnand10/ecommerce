import 'package:ecommerce/common/widgets/custom_shapes/rounded_edges_container.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'circular_container.dart';
import '../../../utils/constants/colors.dart';

class UPrimaryHeaderContainer extends StatelessWidget {
  const UPrimaryHeaderContainer({
    super.key,
    required this.child,
    required this.height
  });

  final Widget child;
  final double height;


  @override
  Widget build(BuildContext context) {
    return URondedEdges(
      child: Container(
        height:height,
        color: UColors.primary,
        child: Stack(
          children: [
            Positioned(
              top: -150,
              right: -160,
              child: UCircularContainer(
                height: USizes.homePrimaryHeaderHeight,
                width: USizes.homePrimaryHeaderHeight,
                backgroundColor: UColors.white.withValues(alpha: 0.1),
              ),
            ),
            Positioned(
              top: 50,
              right: -250,
              child: UCircularContainer(
                height: USizes.homePrimaryHeaderHeight,
                width: USizes.homePrimaryHeaderHeight,
                backgroundColor: UColors.white.withValues(alpha: 0.1),
              ),
            ),
            child
          ],
        ),
      ),
    );
  }
}
