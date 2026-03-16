import 'package:ecommerce/common/widgets/images/rounded_image.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/screens/all_products/all_products.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchStoreCategories extends StatelessWidget {
  const SearchStoreCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Obx(() {
      if (controller.isCategoriesLoading.value)
        return Center(
          child: CircularProgressIndicator(),
        );

      if (controller.allCategories.isEmpty) return Text('No Categories found!');

      List<CategoryModel> categories =
          controller.allCategories;

      return Column(
        children: [
          USectionHeading(
            title: 'Categories',
            showActionButton: false,
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (context, index) {
              CategoryModel category = categories[index];
              return ListTile(
                onTap: ()=> Get.to(()=>AllProductsScreen(title: category.name , futureMethod: controller.getCategoryProducts(categoryId: category.id),)),
                contentPadding: EdgeInsets.zero,
                leading: URondedImage(
                  imageUrl: category.image,
                  borderRadius: 0,
                  width: USizes.iconLg,
                  height: USizes.iconLg,
                  isNetworkImage: true,
                ),
                title: Text(category.name),
              );
            },
          )
        ],
      );
    });
  }
}
