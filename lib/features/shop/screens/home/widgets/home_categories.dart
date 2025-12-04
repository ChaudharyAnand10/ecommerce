import 'package:ecommerce/common/widgets/shimmer/brands_shimmer.dart';
import 'package:ecommerce/features/shop/controllers/category/category_controller.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/screens/sub_category/sub_category.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/image_text/vertical_image_text.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';

class UHomeCategories extends StatelessWidget {
  const UHomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CategoryController());
    return Padding(
      padding: const EdgeInsets.only(left: USizes.spaceBtwSections),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(UTexts.popularCategories,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: UColors.white)),
          SizedBox(height: USizes.spaceBtwItems),
          Obx(() {
            final categories = controller.featuredCategories;

            if (controller.isCategoriesLoading.value) {
              return UBrandsShimmer(itemCount: 6,);
            }

            if (categories.isEmpty) {
              return Text('Data not found');
            }

            return SizedBox(
              height: 80,
              child: ListView.separated(
                separatorBuilder: (context, index) =>
                    SizedBox(width: USizes.spaceBtwItems),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  CategoryModel category = categories[index];

                  return UVerticalImageText(
                    title: category.name,
                    image: category.image,
                    textColor: UColors.white,
                    onTap: () => Get.to(() => SubCategoryScreen()),
                  );
                },
              ),
            );
          })
        ],
      ),
    );
  }
}
