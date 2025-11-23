// import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/appbar/tabbar.dart';
import 'package:ecommerce/common/widgets/brands/brand_card.dart';
// import 'package:ecommerce/common/widgets/brands/brand_showcase.dart';
// import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
// import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
// import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
// import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
// import 'package:ecommerce/common/widgets/images/rounded_image.dart';
// import 'package:ecommerce/common/widgets/products/cart/cart_counter_icon.dart';
// import 'package:ecommerce/common/widgets/textfields/search_bar.dart';
// import 'package:ecommerce/common/widgets/texts/brand_title_with_verify_icon.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/screens/brands/all_brands.dart';
import 'package:ecommerce/features/shop/screens/store/widgets/category_tab.dart';
// import 'package:ecommerce/features/shop/screens/home/widgets/home_appbar.dart';
// import 'package:ecommerce/features/shop/screens/home/widgets/home_categories.dart';
// import 'package:ecommerce/features/shop/screens/home/widgets/primary_header_container.dart';
import 'package:ecommerce/features/shop/screens/store/widgets/store_primary_header.dart';
// import 'package:ecommerce/utils/constants/colors.dart';
// import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
// import 'package:ecommerce/utils/helpers/device_helpers.dart';
// import 'package:ecommerce/utils/helpers/helper_functions.dart';
// import 'package:ecommerce/utils/constants/colors.dart';
// import 'package:ecommerce/utils/constants/enums.dart';
// import 'package:ecommerce/utils/constants/images.dart';
// import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final dark = UHelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 380,
                  pinned: true,
                  floating: false,
                  flexibleSpace: SingleChildScrollView(
                    child: Column(
                      children: [
                        UStorePrimaryHeader(),
                        SizedBox(
                          height: USizes.spaceBtwItems,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: USizes.defaultSpace),
                          child: Column(
                            children: [
                              SizedBox(height: 15,),
                              USectionHeading(
                                title: 'Brands',
                                onPressed: () =>Get.to(()=>BrandScreen()),
                              ),
                              SizedBox(height: 15,),

                              SizedBox(
                                height: USizes.brandCardHeight,
                                child: ListView.separated(
                                  separatorBuilder: (context, index) =>
                                      SizedBox(
                                    width: USizes.spaceBtwItems,
                                  ),
                                  shrinkWrap: true,
                                  itemCount: 10,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => SizedBox(
                                    width: USizes.brandCardWidth,
                                    child: UBrandCard()),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  bottom: UTabBar(
                    tabs: [
                      Tab(child: Text('Sports')),
                      Tab(child: Text('Furniture')),
                      Tab(child: Text('Electronics')),
                      Tab(child: Text('Clothes')),
                      Tab(child: Text('Cosmetics')),
                    ],
                  ),
                ),
              ];
            },
          
            body: TabBarView(children: [
              UCategoryTab(),
              UCategoryTab(),
              UCategoryTab(),
              UCategoryTab(),
              UCategoryTab(),
            ])),
      ),
    );
  }
}
