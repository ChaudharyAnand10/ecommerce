import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/common/widgets/products/cart/product_quantity_with_add_remove.dart';
import 'package:ecommerce/common/widgets/texts/product_price_tex.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({
    super.key,  this.showAddremoveButton = true,
  });

  final bool showAddremoveButton;


  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (context, index) => SizedBox(
        height: USizes.spaceBtwSections,
      ),
      itemCount: 2,
      itemBuilder: (context, index) {
        return Column(
          children: [
            UCartItem(),
           if(showAddremoveButton)  SizedBox(
              height: USizes.spaceBtwItems,
            ),
          if(showAddremoveButton)  Row(
              children: [
                SizedBox(
                  width: 70.0,
                ),
                UPRoductQuantityWithAddAndRemove(),
                Spacer(),
                UProductPriceText(price: '323')
              ],
            )
          ],
        );
      },
    );
  }
}
