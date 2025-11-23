import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';

import 'package:ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/checkout.dart';

import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Padding(
        padding: UPadding.screenPadding,
        child: UCartItems(),
      ),

    bottomNavigationBar: Padding(
      padding: const EdgeInsets.all(USizes.defaultSpace),
      child: UElevatedButton(onPressed: ()=>Get.to(()=>CheckoutScreen()), child: Text('Checkout \$556' )),
    ),


    );
  }
}
