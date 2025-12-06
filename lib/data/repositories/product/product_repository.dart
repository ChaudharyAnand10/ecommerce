import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/services/cloudinary_services.dart';
import 'package:ecommerce/features/shop/models/product_model.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  /// [Upload] - Function to upload list of products to Firebase
  Future<void> uploadProducts(List<ProductModel> products) async {
    try {
      for (ProductModel product in products) {
        File thumbnailFile =
            await UHelperFunctions.assetToFile(product.thumbnail);
        dio.Response response = await _cloudinaryServices.uploadImage(
            thumbnailFile, UKeys.productsFolder);
        if (response.statusCode == 200) {
          product.thumbnail = response.data['url'];
        }

        if (product.images != null && product.images!.isNotEmpty) {
          List<String> imageUrls = [];

          // upload image one by one
          for (String image in product.images!) {
            File imageFile = await UHelperFunctions.assetToFile(image);
            dio.Response response = await _cloudinaryServices.uploadImage(
                imageFile, UKeys.productsFolder);
            if (response.statusCode == 200) {
              imageUrls.add(response.data['url']);
            }
          }

          // update product variation images

         if (product.productVariations != null) {
  for (final variation in product.productVariations!) {
    int index = product.images!.indexWhere((image) => image == variation.image);
    if (index != -1 && index < imageUrls.length) {
      variation.image = imageUrls[index];
    } else {
      print("Variation image not found: ${variation.image}");
    }
  }
}


          product.images!.clear();
          product.images!.assignAll(imageUrls);
        }

        await _db
            .collection(UKeys.productsCollection)
            .doc(product.id)
            .set(product.toJson());

        print('Products ${product.id} uploaded');
      }
    } on FirebaseException catch (e) {
      print('1 exception');
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      print('2 exception');
      throw UFormatException();
    } on PlatformException catch (e) {
      print('3 exception');
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong . Please try gain';
    }
  }


   /// [Upload] - Function to upload list of products to Firebase
  Future<List<ProductModel>> fetchFeaturedProducts() async {
    try {

      final query = await _db.collection(UKeys.productsCollection).where('isFeatured', isEqualTo: true).limit(4).get();

      if(query.docs.isNotEmpty){
          List<ProductModel> products = query.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
          return products;
      }
      return [];



      
    } on FirebaseException catch (e) {
      print('1 exception');
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      print('2 exception');
      throw UFormatException();
    } on PlatformException catch (e) {
      print('3 exception');
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong . Please try gain';
    }
  }
 
  
  /// [Upload] - Function to upload list of products to Firebase
  Future<List<ProductModel>> fetchAllFeaturedProducts() async {
    try {

      final query = await _db.collection(UKeys.productsCollection).where('isFeatured', isEqualTo: true).get();

      if(query.docs.isNotEmpty){
          List<ProductModel> products = query.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
          return products;
      }
      return [];



      
    } on FirebaseException catch (e) {
      print('1 exception');
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      print('2 exception');
      throw UFormatException();
    } on PlatformException catch (e) {
      print('3 exception');
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong . Please try gain';
    }
  }
 

   /// [Upload] - Function to upload list of products to Firebase
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {

      final querySnapshot = await query.get();

      if(querySnapshot.docs.isNotEmpty){
          List<ProductModel> products = querySnapshot.docs.map((document) => ProductModel.fromQuerySnapshot(document)).toList();
          return products;
      }
      return [];



      
    } on FirebaseException catch (e) {
      print('1 exception');
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      print('2 exception');
      throw UFormatException();
    } on PlatformException catch (e) {
      print('3 exception');
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong . Please try gain';
    }
  }
 
  
  Future<List<ProductModel>> getProductsForbrand({required String brandId, int limit = -1}) async{
    try{


      final query = limit == -1
    ? await _db.collection(UKeys.productsCollection).where('brand.id', isEqualTo: brandId).get()
    : await _db.collection(UKeys.productsCollection).where('brand.id', isEqualTo: brandId).limit(limit).get();

if (query.docs.isNotEmpty) {
    List<ProductModel> products = query.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
    return products;
}

return [];



    
    
    } on FirebaseException catch(e){
    throw UFirebaseException(e.code).message;
    }
     on FormatException catch(__){
    throw UFormatException();
    }
    on PlatformException catch(e){
    throw UPlatformException(e.code).message;
    }
     catch(e){
    throw 'Something went wrong. Please try again';
    }
    }
  

    
  Future<List<ProductModel>> getProductsForCategory({required String categoryId, int limit = -1}) async{
    try{


      final productCategoryQuery = limit == -1
    ? await _db.collection(UKeys.productCategoryCollection).where('categoryId', isEqualTo: categoryId).get()
    : await _db.collection(UKeys.productCategoryCollection).where('categoryId', isEqualTo: categoryId).limit(limit).get();

     List<String> productIds = productCategoryQuery.docs.map((doc) => doc['productId'] as String).toList();
     final productQuery = await _db.collection(UKeys.productsCollection).where(FieldPath.documentId, whereIn: productIds).get();
     List<ProductModel> products = productQuery.docs.map((doc) => ProductModel.fromSnapshot(doc)).toList();

     return products;



    
    
    } on FirebaseException catch(e){
    throw UFirebaseException(e.code).message;
    }
     on FormatException catch(__){
    throw UFormatException();
    }
    on PlatformException catch(e){
    throw UPlatformException(e.code).message;
    }
     catch(e){
    throw 'Something went wrong. Please try again';
    }
    }

 

   /// [Upload] - Function to upload list of products to Firebase
  Future<List<ProductModel>> getFavouriteProducts(List<String> productsIds) async {
    try {

      final query = await _db.collection(UKeys.productsCollection).where(FieldPath.documentId , whereIn: productsIds).get();

      if(query.docs.isNotEmpty){
          List<ProductModel> products = query.docs.map((document) => ProductModel.fromSnapshot(document)).toList();
          return products;
      }
      return [];



      
    } on FirebaseException catch (e) {
      print('1 exception');
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      print('2 exception');
      throw UFormatException();
    } on PlatformException catch (e) {
      print('3 exception');
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong . Please try gain';
    }
  }
 
 
 
}
