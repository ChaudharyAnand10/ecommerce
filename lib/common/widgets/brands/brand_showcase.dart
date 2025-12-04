import 'package:ecommerce/common/widgets/brands/brand_card.dart';
import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class UBrandShowCase extends StatelessWidget {
  const UBrandShowCase({
    super.key, required this.images,
  });
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return URoundedContainer(
      showBorder: true,
      borderColor: UColors.darkGrey,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.all(USizes.md),
      margin: EdgeInsets.only(bottom: USizes.spaceBtwItems),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UBrandCard(
            showBorder: false,
            brand: BrandModel.empty(),
          ),
          Row(
            children: images.map((image)=>buildBrandImage(dark , image)).toList(),
          )
        ],
      ),
    );
  }

  Widget buildBrandImage(bool dark , String image) {
    return Expanded(
      child: URoundedContainer(
            height: 100,
            margin: const EdgeInsets.only(right: USizes.sm),
            padding: const EdgeInsets.all(USizes.md),
            backgroundColor: dark ? UColors.darkGrey : UColors.light,
            child: Image(
              image: AssetImage(image),
              fit: BoxFit.contain,
            ),
          ),
    );
  }
}
