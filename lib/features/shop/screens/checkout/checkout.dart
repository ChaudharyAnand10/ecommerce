import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/screens/success_screen.dart';
import 'package:ecommerce/common/widgets/textfields/promo_code.dart';
import 'package:ecommerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:ecommerce/features/shop/controllers/order/order_controller.dart';
import 'package:ecommerce/features/shop/screens/cart/widgets/cart_items.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_address_section.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_amount_section.dart';
import 'package:ecommerce/features/shop/screens/checkout/widgets/billing_payment_section.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/pricing_calculator.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = CartController.instance;
    double subTotal = cartController.totalCartPrice.value;
    double totalPrice =
        UPricingCalculator.calculateTotalPrice(subTotal, 'India');
        final orderController = Get.put(OrderController());

    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text('Oreder Review',
            style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              UCartItems(
                showAddremoveButton: false,
              ),

              SizedBox(
                height: USizes.spaceBtwSections,
              ),

              UPromocodeField(),

              // Billing ammount section

              URoundedContainer(
                showBorder: true,
                padding: EdgeInsets.all(USizes.md),
                backgroundColor: Colors.transparent,
                child: Column(
                  children: [
                    //AMount

                    UBillingAmountSection(),

                    SizedBox(
                      height: USizes.spaceBtwItems,
                    ),

                    // payment
                    UBillingPaymentSection(),
                    SizedBox(
                      height: USizes.spaceBtwItems,
                    ),

                    // address
                    UBillingAddressSection(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(40),
        child: UElevatedButton(
            onPressed: subTotal>0 ?()=> orderController.processOrder(totalPrice): () => USnackBarHelpers.errorSnackBar(title: 'Empty Cart' , message: 'Add Items in the cart'),
            child: Text('Checkout ${UTexts.currency}$totalPrice')),
      ),
    );
  }
}
