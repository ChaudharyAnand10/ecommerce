import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_horizontal.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class SubCategoryScreen extends StatelessWidget {
  const SubCategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Sports',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [


              USectionHeading(
                title: 'Sports Shoes',
                onPressed: () {},
              ),
              SizedBox(
                height: USizes.spaceBtwItems / 2,
              ),

              //Horizontal product card
              SizedBox(
                  height: 120,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: USizes.spaceBtwItems/2,),
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return UProductCardHorizontal();
                    },
                  )),



                    
              USectionHeading(
                title: 'Sports Shoes',
                onPressed: () {},
              ),
              SizedBox(
                height: USizes.spaceBtwItems / 2,
              ),

              //Horizontal product card
              SizedBox(
                  height: 120,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: USizes.spaceBtwItems/2,),
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return UProductCardHorizontal();
                    },
                  )),



                  
            ],
          ),
        ),
      ),
    );
  }
}
