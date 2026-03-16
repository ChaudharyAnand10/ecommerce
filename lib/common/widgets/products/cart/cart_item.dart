import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/features/shop/models/cart_item_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class UCartItem extends StatelessWidget {
  const UCartItem({
    super.key, required this.cartItem,
  });

  final CartItemModel cartItem;
  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);

    return Row(
      children: [
        URondedImage(
          imageUrl: cartItem.image ?? '',
          isNetworkImage: true,
          height: 60.0,
          width: 60.0,
          padding: EdgeInsets.all(USizes.sm),
          backgroundColour: dark ? UColors.darkerGrey : UColors.light,
        ),
        SizedBox(
          width: USizes.spaceBtwItems,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              UBrandTitleWithVerifiedIcon(title: cartItem.brandName ?? ''),
              UProductTitleText(
                title: cartItem.title,
                maxLines: 1,
              ),
              RichText(
                  text: TextSpan(children:(cartItem.selectedVariation ?? {}).entries.map((e)=>TextSpan(
                    children: [
                       TextSpan(
                  text: '${e.key} ',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                TextSpan(
                  text: '${e.value} ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                    ]
                  )).toList()
              )
              ),
            ],
          ),
        )
      ],
    );
  }
}
