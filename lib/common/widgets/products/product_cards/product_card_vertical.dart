import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
// import 'package:ecommerce/common/widgets/texts/brand_title_text.dart';
import 'package:ecommerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:ecommerce/features/shop/screens/product_details/product_details.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../style/shadow.dart';
import '../../texts/product_price_tex.dart';
import '../../texts/product_title_text.dart';


class UProductCardVertical extends StatelessWidget {
  const UProductCardVertical({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: ()=>Get.to(()=>ProductDetailsScreen()),
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
          boxShadow:UShadow.verticalProductShadow,
          borderRadius: BorderRadius.circular(USizes.productImageRadius),
          color: dark? UColors.darkerGrey : UColors.white

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            URoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(USizes.sm),
              backgroundColor: dark? UColors.dark : UColors.light,
              child: Stack(
                children: [
                  Center(child: URondedImage(imageUrl: UImages.productImage15)),

                  Positioned(
                    top: 12.0,
                    child: URoundedContainer(
                      radius: USizes.sm,
                      backgroundColor: UColors.yellow.withValues(alpha: 0.8),
                      padding: const EdgeInsets.symmetric(horizontal: USizes.sm , vertical: USizes.xs),
                      child: Text('20%', style: Theme.of(context).textTheme.labelLarge!.apply(color: UColors.black)),

                    ),
                  ),

                  Positioned(
                    right: 0,
                      top: 0,

                      child: UCircularIcon(icon: Iconsax.heart5 , color: Colors.red,),
                  )
                ],
              ),
            ),
            SizedBox(height: USizes.spaceBtwItems/2,),


            /// detail

            Padding(
              padding: const EdgeInsets.only(left: USizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  UProductTitleText(title: 'Blue Bata Shoes', smallSize: true),
                  SizedBox(height: USizes.spaceBtwItems/2,),


                  UBrandTitleWithVerifiedIcon(title: 'Bata',),




                ],
              ),
            ),
            Spacer(),


            ///product price add button


            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children:  [


                Padding(
                  padding: const EdgeInsets.only(left: USizes.sm),
                  child: UProductPriceText(
                    price: '65',
                  ),
                ),



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

                )

              ],
            )




          ],
        ),
      ),
    );
  }
}


