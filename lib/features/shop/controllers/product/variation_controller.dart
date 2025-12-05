import 'package:ecommerce/features/shop/controllers/product/image_controller.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/features/shop/models/product_variation_model.dart';
import 'package:get/get.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  // Variables
  RxMap selectedAttributes = {}.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  RxString variationStockStatus = ''.obs;

  // Select Attribute And Variation
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    Map<String, dynamic> selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;
    this.selectedAttributes[attributeName] =
        attributeValue; // selectedAttribute['Color'] : 'Green'

    ProductVariationModel selectedVariation = product.productVariations!
        .firstWhere(
            (variation) => isSameAttributeValue(
                variation.attributeValues, selectedAttributes),
            orElse: () => ProductVariationModel.empty());

    if (selectedVariation.image.isNotEmpty) {
      ImageController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    // Assign selected Variation to Rx Variable
    this.selectedVariation(selectedVariation);
    getProductVariationStockStatus();
  }

  Set<String?> getAttributesAvailableUttyInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    // Pass the variation to check which attributes are available and stock is not 0
    final availableAttributesValues = variations
        .where((variation) =>
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.attributeValues[attributeName] != null &&
            variation.stock > 0)
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableAttributesValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toStringAsFixed(0);
  }

  bool isSameAttributeValue(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    if (variationAttributes.length != selectedAttributes.length) return false;

    for (final key in variationAttributes.keys) {
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }
}
