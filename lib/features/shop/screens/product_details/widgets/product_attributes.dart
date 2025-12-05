import 'package:ecommerce/common/widgets/chips/choice_chip.dart';
import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/common/widgets/texts/product_price_tex.dart';
import 'package:ecommerce/common/widgets/texts/product_title_text.dart';
import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/shop/controllers/product/variation_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';

class UProductAttributes extends StatelessWidget {
  const UProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = UHelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      ()=> Column(
        children: [
      
          if(controller.selectedVariation.value.id.isNotEmpty)
          URoundedContainer(
            padding: EdgeInsets.all(USizes.md),
            backgroundColor: dark ? UColors.darkerGrey : UColors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    USectionHeading(
                      title: 'Variation',
                      showActionButton: false,
                    ),
                    SizedBox(
                      width: USizes.spaceBtwItems,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            UProductTitleText(
                              title: 'Price',
                              smallSize: true,
                            ),
                            SizedBox(
                              width: USizes.sm,
                            ),
                            if(controller.selectedVariation.value.salePrice > 0)
                            Text('${UTexts.currency}${controller.selectedVariation.value.price.toStringAsFixed(0)}',
                                style:
                                    Theme.of(context).textTheme.titleSmall!.apply(
                                          decoration: TextDecoration.lineThrough,
                                        )),
                            SizedBox(
                              width: USizes.spaceBtwItems,
                            ),
                            UProductPriceText(price: controller.getVariationPrice()),
                          ],
                        ),
                        Row(
                          children: [
                            UProductTitleText(
                              title: 'Stock',
                              smallSize: true,
                            ),
                            SizedBox(
                              width: USizes.sm,
                            ),
                            Text(
                              controller.variationStockStatus.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
                UProductTitleText(
                  title: controller.selectedVariation.value.description ?? '',
                  smallSize: true,
                  maxLines: 4,
                ),
              ],
            ),
          ),
          SizedBox(
            height: USizes.spaceBtwItems,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: product.productAttributes!.map((attribute) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  USectionHeading(
                    title: attribute.name ?? '',
                    showActionButton: false,
                  ),
                  SizedBox(
                    height: USizes.spaceBtwItems / 2,
                  ),
                  Wrap(
                    spacing: USizes.sm,
                    children: attribute.values!.map((attributebalue) {
                      bool isSelected =
                          controller.selectedAttributes[attribute.name] ==
                              attributebalue;
      
                      bool available = controller
                          .getAttributesAvailableUttyInVariation(
                              product.productVariations!, attribute.name!)
                          .contains(attributebalue);
                      return UChoiceChip(
                          text: attributebalue,
                          selected: isSelected,
                          onSelected: available
                              ? (selected) {
                                  if (available && selected) {
                                    controller.onAttributeSelected(
                                        product, attribute.name, attributebalue);
                                  }
                                }
                              : null);
                    }).toList(),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
