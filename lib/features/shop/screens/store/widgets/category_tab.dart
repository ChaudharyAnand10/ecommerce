import 'package:ecommerce/common/widgets/brands/brand_showcase.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
class UCategoryTab extends StatelessWidget {
  const UCategoryTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: USizes.defaultSpace),
          child: Column(
            children: [
              UBrandShowCase(
                images: [
                  UImages.productImage47,
                  UImages.productImage43,
                  UImages.productImage7
                ],
              ),
              UBrandShowCase(
                images: [
                  UImages.productImage47,
                  UImages.productImage43,
                  UImages.productImage7
                ],
              ),
              SizedBox(
                height: USizes.spaceBtwItems,
              ),
              USectionHeading(
                  title: 'You might like', onPressed: () {}),
              UGridLayout(
                itemCount: 4,
                itemBuilder: (context, index) {
                  return UProductCardVertical(product: ProductModel.empty());
                },
              ),
              SizedBox(height: USizes.spaceBtwSections),
            ],
          ),
        )
      ],
    );
  }
}
