

import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/Product_meta_data.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:ecommerce/utils/constants/sizes.dart';


import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            UProductThumbNailandSlider(),

            Padding(
              padding: UPadding.screenPadding,
              child: Column(
                children: [
                  
              UProductMetaData(),
                            SizedBox(height: USizes.spaceBtwItems,),

              
              UProductAttributes(),
              SizedBox(height: USizes.spaceBtwSections,),
              
              UElevatedButton(onPressed: (){}, child: Text('Checkout')),
              SizedBox(height: USizes.spaceBtwItems,),
              
              
              USectionHeading(title: 'Description' ,showActionButton: false,),
              SizedBox(height: USizes.spaceBtwItems,),
              
              ReadMoreText(
              'this is a best place i have ever been see how good this is i knew it this is best what a class bro the best it is  this is a best place i have ever been see how good this is i knew it this is best what a class bro the best it is ',
              trimLines: 2,
              trimMode: TrimMode.Line,
              trimCollapsedText: ' Show more',
              trimExpandedText: ' Less',
              moreStyle: TextStyle(fontSize: 14.0 ,fontWeight: FontWeight.w800),
              lessStyle: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
              
              ),
                        SizedBox(height: USizes.spaceBtwItems,),
              
              
                ],
              ),
            )









            
          ],
        ),
      ),


      bottomNavigationBar: UBottomAddToCart(),
    );
  }
}
