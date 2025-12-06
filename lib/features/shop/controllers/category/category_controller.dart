import 'package:ecommerce/data/repositories/category/category_repository.dart';
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  static CategoryController get instance => Get.find();

  // Variables
  final _repository = Get.put(CategoryRepository());
  RxList<CategoryModel> allCategories = <CategoryModel>[].obs;
  RxList<CategoryModel> featuredCategories = <CategoryModel>[].obs;

  RxBool isCategoriesLoading = false.obs;

  @override
  void onInit() {
    fetchCategories();
    super.onInit();
  }

  Future<void> fetchCategories() async {
    try {
      isCategoriesLoading.value = true;
      List<CategoryModel> categories = await _repository.getAllCategories();
      allCategories.assignAll(categories);
      featuredCategories.assignAll(categories.where(
          // (category) => category.isFeatured && category.parentId.isEmpty
          (category) =>
              category.isFeatured && ((category.parentId ?? '').isEmpty)));

      print("Total: ${categories.length}");
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    } finally {
      isCategoriesLoading.value = false;
    }
  }

  Future<List<ProductModel>> getCategoryProducts(
      {required String categoryId, int limit = 4}) async {
    try {
      final products = ProductRepository.instance
          .getProductsForCategory(categoryId: categoryId, limit: limit);
      return products;
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
      return [];
    }
  }
  

  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
        final categories = await _repository.getSubCategories(categoryId);
        return categories;
    } catch (e) {
        USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
        return [];
    }
}


}
