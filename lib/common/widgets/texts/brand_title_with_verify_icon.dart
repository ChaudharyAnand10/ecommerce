import 'package:ecommerce/common/widgets/texts/brand_title_text.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UBrandTitleWithVerifiedIcon extends StatelessWidget {
  const UBrandTitleWithVerifiedIcon({
    super.key, required this.title,  this.maxLines=1, this.textColor, this.iconColor=UColors.primary, this.textAlign = TextAlign.center,  this.brandTextSize = TextSizes.small,
  });

  final String title;
  final int maxLines;
  final Color? textColor, iconColor;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(child: UBrandTitleText(title: title , maxLines: maxLines,textAlign: textAlign,brandTextSize: brandTextSize,color: textColor,)),
        SizedBox(width: USizes.xs),
        Icon(Iconsax.verify5, color: UColors.primary, size: USizes.iconXs)
      ],
    );
  }
}
