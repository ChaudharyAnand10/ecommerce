import 'package:ecommerce/features/shop/controllers/home/home_controller.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_appbar.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
import 'package:ecommerce/common/widgets/custom_shapes/primary_header_container.dart';
import 'package:ecommerce/features/shop/screens/home/widgets/promo_slider.dart';
import 'package:ecommerce/utils/constants/images.dart';

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

    final controller = Get.put(HomeController());
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
                const SizedBox(height: USizes.spaceBtwSections,),
          
                USectionHeading(title: 'Popular Products', onPressed: ()=>Get.to(()=>AllProductsScreen())),
                const SizedBox(height: USizes.spaceBtwSections,),
          
          
                // vertical product card
                UGridLayout(
                  itemCount: 6,
                  itemBuilder:  (context, index) {
                    return  UProductCardVertical() ;
                  } ,
                ),
              ],
            ),
          )
                ],
              ),
        ),
    );
  }
}






