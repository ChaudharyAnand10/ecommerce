import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/Product_meta_data.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/bottom_add_to_cart.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_attributes.dart';
import 'package:ecommerce/features/shop/screens/product_details/widgets/product_thumbnail_and_slider.dart';
import 'package:ecommerce/utils/constants/enums.dart';
import 'package:ecommerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final ProductModel product;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UProductThumbNailandSlider(product: product,),
            Padding(
              padding: UPadding.screenPadding,
              child: Column(
                children: [
                  UProductMetaData(product: product),
                  SizedBox(
                    height: USizes.spaceBtwItems,
                  ),
                  if(product.productType == ProductType.variable.toString())...[
                     UProductAttributes(product: product,),
                  SizedBox(
                    height: USizes.spaceBtwSections,
                  ),
                  ],
                 
                  UElevatedButton(onPressed: () {}, child: Text('Checkout')),
                  SizedBox(
                    height: USizes.spaceBtwItems,
                  ),
                  USectionHeading(
                    title: 'Description',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: USizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: ' Show more',
                    trimExpandedText: ' Less',
                    moreStyle:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800),
                  ),
                  SizedBox(
                    height: USizes.spaceBtwItems,
                  ),
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
