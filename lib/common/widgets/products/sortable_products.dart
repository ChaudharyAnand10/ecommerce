import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class USortableProducts extends StatelessWidget {
  const USortableProducts({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(
            decoration: InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            onChanged: (value) {},
            items: [
              'Name',
              'Lower Price',
              'Higher Price',
              'Sale',
              ' Newest'
            ].map((filter) {
              return DropdownMenuItem(value: filter, child: Text(filter));
            }).toList(),
            ),
            SizedBox(height: USizes.spaceBtwSections,),
    
    
            UGridLayout(itemCount: 10, itemBuilder: (context, index) =>UProductCardVertical(),)
      ],
    );
  }
}
