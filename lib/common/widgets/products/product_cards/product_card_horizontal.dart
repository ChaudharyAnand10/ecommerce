import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/products/favourite/favourite_icon.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:ecommerce/common/widgets/texts/product_price_tex.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UProductCardHorizontal extends StatelessWidget {
  const UProductCardHorizontal({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Container(
      width: 310,
      padding: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(USizes.productImageRadius),
        color: dark ? UColors.darkerGrey : UColors.white,
      ),
      child: Row(
        children: [


          URoundedContainer(
            height: 120,
            padding: EdgeInsets.all(USizes.sm),
            backgroundColor: dark ? UColors.dark : UColors.light,
            child: Stack(
              children: [
                SizedBox(
                    height: 120,
                    width: 120,
                    child: URondedImage(imageUrl: UImages.productImage15)),
                Positioned(
                  top: 12.0,
                  child: URoundedContainer(
                    radius: USizes.sm,
                    backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                    padding: const EdgeInsets.symmetric(
                        horizontal: USizes.sm, vertical: USizes.xs),
                    child: Text('20%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: UColors.black)),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: UFavouriteIcon(productId: '',),
                )




              ],


            ),
          ),

          //right portion
          SizedBox(
            width: 172.0,
            child: Padding(
              padding: const EdgeInsets.only(left: USizes.sm ,top: USizes.sm ),
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                   Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UProductTitleText(title: 'Blue Bata Shoes',smallSize: true,),
                  SizedBox(height: USizes.spaceBtwItems/2),
              
                  UBrandTitleWithVerifiedIcon(title: 'Bata'),
              
              
                ],
              ),
                   Spacer(),
            
            
                   Row(
                    children: [
                      Flexible(child: UProductPriceText(price: '65')),
            
                      Container(
                    width: USizes.iconLg *1.2,
                    height: USizes.iconLg *1.2,
                    decoration: BoxDecoration(
                        color: UColors.primary,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(USizes.productImageRadius),
                          bottomRight: Radius.circular(USizes.productImageRadius),
                        )
                    ),
                    child: Icon(Iconsax.add , color: UColors.white),
            
                  ),
            
            
            
                    ],
                   )
            
                ],
              )
            
            
            
            ),
          )




        ],
      ),
    );
  }
}
