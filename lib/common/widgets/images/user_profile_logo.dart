import 'package:ecommerce/common/widgets/images/circular_image.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:flutter/material.dart';
class UserProfileLogo extends StatelessWidget {
  const UserProfileLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return UCircularImage(
      image: UImages.profileLogo,
      height: 120.0,
      width: 120.0,
      borderWidth: 5.0,
      padding: 0,
      );
  }
}