import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/promo_slider.dart';

import 'package:ecommerce/utils/constants/sizes.dart';

import 'package:flutter/material.dart';

import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../common/widgets/textfields/search_bar.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/texts/section_heading.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.put(HomeController());
    final productConroller = Get.put(ProductController());
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // upper part
            Stack(
              children: [
                SizedBox(
                  height: USizes.homePrimaryHeaderHeight + 10,
                ),
                UPrimaryHeaderContainer(
                    height: USizes.homePrimaryHeaderHeight,
                    child: Column(
                      children: [
                        UHomeAppBar(),
                        SizedBox(height: USizes.spaceBtwSections),
                        UHomeCategories(),
                      ],
                    )),
                USearchBar()
              ],
            ),

            // lower part
            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                  UPromoSlider(),
                  const SizedBox(
                    height: USizes.spaceBtwSections,
                  ),

                  USectionHeading(
                      title: 'Popular Products',
                      onPressed: () => Get.to(() => AllProductsScreen(
                        title: 'Popular Products',
                        futureMethod: productConroller.getAllFeaturedProduct(),
                      ))),
                  const SizedBox(
                    height: USizes.spaceBtwSections,
                  ),

                  // vertical product card
                  Obx(() {
                    if (productConroller.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (productConroller.featoredProducts.isEmpty) {
                      return Center(child: Text('Products Not Founds!'));
                    }

                    return UGridLayout(
                      itemCount: productConroller.featoredProducts.length,
                      itemBuilder: (context, index) {
                        ProductModel product =
                            productConroller.featoredProducts[index];
                        return UProductCardVertical(product: product);
                      },
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
