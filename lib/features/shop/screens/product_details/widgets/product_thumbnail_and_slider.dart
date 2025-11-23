import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
class UProductThumbNailandSlider extends StatelessWidget {
  const UProductThumbNailandSlider({
    super.key,
   
  });

 

  @override
  Widget build(BuildContext context) {
        final dark = UHelperFunctions.isDarkMode(context);

    return Container(
      color: dark ? UColors.darkerGrey : UColors.light,
      child: Stack(
        children: [
      
          SizedBox(
            height: 400,
            child: Padding(
              padding: const EdgeInsets.all(USizes.productImageRadius *2 ),
              child: Center(child: Image(image: AssetImage(UImages.productImage4a),)),
            ),
          ),
      
         Positioned(
          left: USizes.defaultSpace,
          right: 0,
          bottom: 30,
           child: SizedBox(
            height: 80.0,
             child: ListView.separated(
              separatorBuilder: (context, index) => SizedBox(width: USizes.spaceBtwItems,),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) =>  URondedImage(
                width: 80,
                backgroundColour: dark ? UColors.dark : UColors.white,
                padding: EdgeInsets.all(USizes.sm),
                border: Border.all(color: UColors.primary),
                imageUrl: UImages.productImage2),),
           ),
         ),
    
    
    
         UAppBar(showBackArrow: true,
         actions: [
          UCircularIcon(icon: Iconsax.heart5,color: Colors.red,)
    
         ],) 
          
        ],
      ),
    );
  }
}
