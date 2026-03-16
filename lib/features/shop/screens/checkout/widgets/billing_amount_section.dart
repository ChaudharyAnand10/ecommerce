import 'package:ecommerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/pricing_calculator.dart';
import 'package:flutter/material.dart';

class UBillingAmountSection extends StatelessWidget {
  const UBillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    final subTotal = cartController.totalCartPrice.value;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Text(
              'SubTotal',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '${UTexts.currency}$subTotal',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        SizedBox(
          height: USizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              'Shipping fee',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '${UTexts.currency}${UPricingCalculator.calculateShippingCost(subTotal, 'India')}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        SizedBox(
          height: USizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              'Tax Fee',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '${UTexts.currency}${UPricingCalculator.calculateTax(subTotal, 'India')}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ],
        ),
        SizedBox(
          height: USizes.spaceBtwItems / 2,
        ),
        Row(
          children: [
            Expanded(
                child: Text(
              'Total order',
              style: Theme.of(context).textTheme.bodyMedium,
            )),
            Text(
              '${UTexts.currency}${UPricingCalculator.calculateTotalPrice(subTotal, 'India')}',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
