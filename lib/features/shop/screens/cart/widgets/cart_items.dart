import 'package:ecommerce/common/widgets/products/cart/cart_item.dart';
import 'package:ecommerce/common/widgets/products/cart/product_quantity_with_add_remove.dart';
import 'package:ecommerce/common/widgets/texts/product_price_tex.dart';
import 'package:ecommerce/features/shop/controllers/cart/cart_controller.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class UCartItems extends StatelessWidget {
  const UCartItems({
    super.key,
    this.showAddremoveButton = true,
  });

  final bool showAddremoveButton;

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Obx(
      ()=> ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => SizedBox(
          height: USizes.spaceBtwSections,
        ),
        itemCount: controller.cartItems.length,
        itemBuilder: (context, index) {
          final CartItem = controller.cartItems[index];

          
          return 
             Column(
              children: [
                UCartItem(cartItem: CartItem),
                if (showAddremoveButton)
                  SizedBox(
                    height: USizes.spaceBtwItems,
                  ),
                if (showAddremoveButton)
                  Row(
                    children: [
                      SizedBox(
                        width: 70.0,
                      ),
                      UPRoductQuantityWithAddAndRemove(
                        quantity: CartItem.quantity,
                        add: ()=>controller.addOneToCart(CartItem),
                        remove: ()=>controller.removeOneFromCart(CartItem),
                      ),
                      Spacer(),
                      UProductPriceText(price: (CartItem.price*CartItem.quantity).toStringAsFixed(0))
                    ],
                  )
              ],
            );
          
        },
      ),
    );
  }
}
