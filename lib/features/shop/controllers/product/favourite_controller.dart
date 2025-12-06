import 'dart:convert';

import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/data/repositories/product/product_repository.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class FavouriteController extends GetxController {
  static FavouriteController instance = Get.find();

  // Variables
  RxMap<String, bool> favourites = <String, bool>{}.obs;
  final _storage =
      GetStorage(AuthenticationRepository.instance.currentUser!.uid);

  @override
  void onInit() {
    initFavourites();
    super.onInit();
  }

  Future<void> initFavourites() async {
    String encodedFavourites = await _storage.read('favourites');
    Map<String, dynamic> storedFavourites =
        jsonDecode(encodedFavourites) as Map<String, dynamic>;

    favourites.assignAll(
        storedFavourites.map((key, value) => MapEntry(key, value as bool)));
  }

  void toggleFavouriteProduct(String productId) {
    if (favourites.containsKey(productId)) {
      favourites.remove(productId);
      saveFavouritesToStorage();
      USnackBarHelpers.customToast(
          message: 'Product has been removed from the whishlist');
    } else {
      favourites[productId] = true;
      saveFavouritesToStorage();
      USnackBarHelpers.customToast(
          message: 'Product has been added to the whishlist');
    }
  }

  void saveFavouritesToStorage() {
    String encodedFavourites = jsonEncode(favourites);

    _storage.write('favourites', encodedFavourites);
  }

  bool isFavourite(String productId) {
    return favourites[productId] ?? false;
  }


  Future<List<ProductModel>> getFavouriteProducts() async {

    final productIds = favourites.keys.toList();

    return await ProductRepository.instance.getFavouriteProducts(productIds);
}
}
