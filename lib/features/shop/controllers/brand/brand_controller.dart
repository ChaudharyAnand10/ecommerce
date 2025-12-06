import 'package:ecommerce/data/repositories/brand/brand_repository.dart';
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/dummy_data.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:get/get.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  // Variables
  final _repository = Get.put(BrandRepository());
  RxList<BrandModel> allBrands = <BrandModel>[].obs;
  RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    getBrands();
    super.onInit();
  }

  Future<void> getBrands() async {
    try {
      isLoading.value = true;
      List<BrandModel> allBrands = await _repository.fetchBrands();

      this.allBrands.assignAll(allBrands);

      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).toList());
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<List<ProductModel>> getBrandProducts(String brandId , {int limit = -1}) async {
    try {
      List<ProductModel> products = await ProductRepository.instance
          .getProductsForbrand(brandId: brandId , limit: limit);
      return products;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }
  

  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
        final brands = await _repository.fetchBrandsForCategory(categoryId);
        return brands;
    } catch (e) {
        USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
        return [];
    }
}




}
