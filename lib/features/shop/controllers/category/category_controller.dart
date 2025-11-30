import 'package:ecommerce/data/repositories/category/category_repository.dart';
import 'package:ecommerce/features/shop/models/category_model.dart';
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
          (category) => category.isFeatured && category.parentId.isEmpty));
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    } finally {
      isCategoriesLoading.value = true;
    }
  }
}
