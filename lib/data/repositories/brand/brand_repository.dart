import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/services/cloudinary_services.dart';
import 'package:ecommerce/features/shop/models/brand_category_model.dart';
import 'package:ecommerce/features/shop/models/brand_model.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  // Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServivices = Get.put(CloudinaryServices());

  // [Upload] - Function to upload all brands


  // Future<void> uploadBrands(List<BrandModel> brands) async {
  //   try {
  //     for (BrandModel brand in brands) {
  //       File brandImage = await UHelperFunctions.assetToFile(brand.image);

  //       dio.Response response = await _cloudinaryServivices.uploadImage(
  //           brandImage, UKeys.brandsFolder);
  //       if (response.statusCode == 200) {
  //         // brand.image = response.data['url'];
  //         brand.image = response.data['secure_url'];
  //       }

  //       await _db
  //           .collection(UKeys.brandsCollection)
  //           .doc(brand.id)
  //           .set(brand.toJson());
  //       print('Brand uploaded');
  //     }
  //   } on FirebaseException catch (e) {
  //     throw UFirebaseException(e.code).message;
  //   } on FormatException catch (e) {
  //     throw UFormatException();
  //   } on PlatformException catch (e) {
  //     throw UPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong . Please try gain';
  //   }
  // }

  Future<void> uploadBrands(List<BrandModel> brands) async {
  try {
    for (BrandModel brand in brands) {
      final File brandImage =
          await UHelperFunctions.assetToFile(brand.image);

      final response = await _cloudinaryServivices.uploadImage(
        brandImage,
        UKeys.brandsFolder,
      );

      print('Cloudinary Response: ${response.data}');

      if (response.statusCode == 200) {
        brand.image = response.data['secure_url']; // <-- Fix!
      }

      await _db.collection(UKeys.brandsCollection)
          .doc(brand.id)
          .set(brand.toJson());

      print('Brand uploaded: ${brand.name}');
    }
  } catch (e) {
    print(e.toString());
    throw 'Something went wrong. Please try again';
  }
}


  Future<List<BrandModel>> fetchBrands() async {
    try {
      final query = await _db.collection(UKeys.brandsCollection).get();

      if (query.docs.isNotEmpty) {
        List<BrandModel> brands = query.docs
            .map((document) => BrandModel.fromSnapshot(document))
            .toList();

        print('brands fetch');
        return brands;
      }

      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong . Please try gain';
    }
  }

 
 
  Future<List<BrandModel>> fetchBrandsForCategory(String categoryId) async {
    try {

          // Query to get all documents where category `m` matches the provided categoryId
           final brandCategoryQuery = await _db.collection(UKeys.brandCategoryCollection).where('categoryId', isEqualTo: categoryId).get();

           List<BrandCategoryModel> brandCategories = brandCategoryQuery.docs.map((doc) => BrandCategoryModel.fromSnapshot(doc)).toList();

           List<String> brandIds = brandCategories.map((brandCategory) => brandCategory.brandId).toList();

           final brandsQuery = await _db.collection(UKeys.brandsCollection).where(FieldPath.documentId, whereIn: brandIds).limit(2).get();

           List<BrandModel> brands = brandsQuery.docs.map((doc) => BrandModel.fromSnapshot(doc)).toList();

           return brands;


     
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (e) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong . Please try gain';
    }
  }

 






}

