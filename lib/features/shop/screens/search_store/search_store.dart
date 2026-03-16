import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/layouts/grid_layout.dart';
import 'package:ecommerce/common/widgets/products/product_cards/product_card_vertical.dart';
import 'package:ecommerce/features/shop/controllers/product/product_controller.dart';
import 'package:ecommerce/features/shop/screens/search_store/widgets/search_store_brand.dart';
import 'package:ecommerce/features/shop/screens/search_store/widgets/search_store_categories.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/cloud_helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:iconsax/iconsax.dart';

class SearchStoreScreen extends StatelessWidget {
  const SearchStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    RxString searchText = ''.obs;
    return Scaffold(
      appBar: UAppBar(
        showBackArrow: true,
        title: Text(
          'Search',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              Hero(
                tag: 'search_animation',
                child: Material(
                  color: Colors.transparent,
                  child: TextFormField(
                    decoration: InputDecoration(
                        prefixIcon: Icon(Iconsax.search_normal),
                        hintText: 'Search in store '),
                    onChanged: (value) => searchText.value = value,
                  ),
                ),
              ),
              SizedBox(
                height: USizes.spaceBtwSections,
              ),

              //brands

              Obx(() {
                if (searchText.value.isEmpty) {
                  return Column(
                    children: [
                      SearchStoreBrand(),
                      SizedBox(
                        height: USizes.spaceBtwSections,
                      ),
                      SearchStoreCategories()
                    ],
                  );
                }

                return FutureBuilder(
                  future: ProductController.instance.getAllProducts(),
                  builder: (context, snapshot) {
                    final widget = UCloudHelperFunctions.checkMultiRecordState(
                        snapshot: snapshot);
                    if (widget != null) return widget;

                    final products = snapshot.data!;

                    final filteredProducts = products
                        .where((product) => product.title
                            .toLowerCase()
                            .contains(searchText.value.toLowerCase()))
                        .toList();

                    if (filteredProducts.isEmpty)
                      return Text('No Products found');

                    return UGridLayout(
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return UProductCardVertical(product: product);
                      },
                    );
                  },
                );
              })
            ],
          ),
        ),
      ),
    );
  }
}
