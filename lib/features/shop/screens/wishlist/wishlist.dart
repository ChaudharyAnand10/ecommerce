import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/icons/circular_icon.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/loaders/animation_loader.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/common/widgets/shimmer/vertical_product_shimmer.dart';
import 'package:ecommerce/features/shop/controllers/product/favourite_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:iconsax/iconsax.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(
        title: Text('Wishlist',style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          UCircularIcon(icon: Iconsax.add , 
          onPressed: ()=>NavigationController.instance.selectedIndex.value=0,
          )
          ],
      ),
      body: SingleChildScrollView(child: Padding(
        padding: const EdgeInsets.all(USizes.defaultSpace),
        child: Obx(
          ()=> FutureBuilder(
            future: FavouriteController.instance.getFavouriteProducts(),
            builder: (context, snapshot) {
              final nothingFound =UAnimationLoader(text: 'Whishlist is Empty ...',
              animation: UImages.pencilAnimation,
              showActionButton: true,
              actionText: "let's add some",
              onActionPressed: ()=>NavigationController.instance.selectedIndex.value=0,
              );
              const loader =UVerticalProductShimmer(itemCount: 6);
          
              /// Manage empty data, loading and error
                  final widget = UCloudHelperFunctions.checkMultiRecordState(snapshot: snapshot , loader:loader  , nothingFound: nothingFound);
                if (widget != null) return widget;
          
              /// Products Found
              List<ProductModel> products = snapshot.data!;
          
          
          
          
              return UGridLayout(itemCount: products.length, itemBuilder: (context, index) => UProductCardVertical(product: products[index]),);
            }
          ),
        ),
      )),

    );
  }
}