import 'package:ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/product_price_tex.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    return Column(
      children: [
        URoundedContainer(
          padding: EdgeInsets.all(USizes.md),
          backgroundColor: dark ? UColors.darkerGrey : UColors.grey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  USectionHeading(
                    title: 'Variation',
                    showActionButton: false,
                  ),
                  SizedBox(
                    width: USizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          UProductTitleText(
                            title: 'Price',
                            smallSize: true,
                          ),
                          SizedBox(width: USizes.sm,),
                          Text('250',
                              style:
                                  Theme.of(context).textTheme.titleSmall!.apply(
                                        decoration: TextDecoration.lineThrough,
                                      )),
                          SizedBox(
                            width: USizes.spaceBtwItems,
                          ),
                          UProductPriceText(price: '200'),
                        ],
                      ),
                      Row(
                        children: [
                            UProductTitleText(
                            title: 'Stock',
                            smallSize: true,
                          ),
                          SizedBox(width: USizes.sm,),
                          Text('In Stock' , style: Theme.of(context).textTheme.titleMedium,)
    
    
                          
                        ],
                      )
                    ],
                  )
                ],
              ),
              
    
              UProductTitleText(title: 'this is good buy it now or regret whole life ' , smallSize: true, maxLines: 4,),
    
    
    
            ],
          ),
        ),
    
        SizedBox(height: USizes.spaceBtwItems,),
    
    
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            USectionHeading(title: 'Colors' , showActionButton: false,),
            SizedBox(
              height: USizes.spaceBtwItems/2,
            ),
            Wrap(spacing: USizes.sm,
              children: [
                     UChoiceChip(
              text: 'Red',
              selected: true,
              onSelected: (value){}
            ),
            UChoiceChip(
              text: 'Blue',
              selected: false,
              onSelected: (value){}
            ),
           
    
              ],
            ),
    
       
          ],
        ),

        SizedBox(height: USizes.spaceBtwItems,),
    
    
    
    
        
    
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            USectionHeading(title: 'Sizes' , showActionButton: false,),
            SizedBox(
              height: USizes.spaceBtwItems/2,
            ),
            Wrap(spacing: USizes.sm,
              children: [
                     UChoiceChip(
              text: 'Small',
              selected: true,
              onSelected: (value){}
            ),
            UChoiceChip(
              text: 'Medium',
              selected: false,
              onSelected: (value){}
            ),
            UChoiceChip(
              text: 'Large',
              selected: false,
              onSelected: (value){}
            ),
    
              ],
            ),
    
       
          ],
        ),
    
    
    
    
    
    
    
    
        
    
    
      ],
    );
  }
}

