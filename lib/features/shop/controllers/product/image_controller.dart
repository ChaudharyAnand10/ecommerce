import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class ImageController extends GetxController {
  static ImageController get instance => Get.find();

  // Variables
  RxString selectedProductImage = ''.obs;

  List<String> getAllProductImages(ProductModel product) {
    Set<String> images = {};

    // Load Thumbnail image
    images.add(product.thumbnail);

    // Assign Thumbnail as Selected Image
    selectedProductImage.value = product.thumbnail;

    // Load all images of product
    if (product.images != null && product.images!.isNotEmpty) {
      images.addAll(product.images!);
    }

    if (product.productVariations != null &&
        product.productVariations!.isNotEmpty) {
      List<String> variationImages = product.productVariations!
          .map((variation) => variation.image)
          .toList();
      images.addAll(variationImages);
    }

    return images.toList();
  }
  

  void showEnLargeImage(String image){
    Get.to(
        fullscreenDialog: true,
        () => Dialog.fullscreen(
            child: Column(
                children: [
                    // Image
                    Padding(padding: EdgeInsets.symmetric(vertical: USizes.defaultSpace * 2, horizontal: USizes.defaultSpace),
                        child: CachedNetworkImage(imageUrl: image)), // Padding
                    SizedBox(height: USizes.spaceBtwSections),
                    // Close Button
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                            width: 150,
                            child: OutlinedButton(onPressed: Get.back, child: Text('Close'))
                        ), // SizedBox
                    ) // Align
                ],
            ), // Column
        ) // Dialog.fullscreen
    );
}




}
