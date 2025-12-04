import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/services/cloudinary_services.dart';
import 'package:ecommerce/features/shop/models/banners_model.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class BannerRepository extends GetxController {
  static BannerRepository get instance => Get.find();

  /// Variables
  final _db = FirebaseFirestore.instance;
  final _cloudinaryServices = Get.put(CloudinaryServices());

  Future<void> uploadBanners(List<BannerModel> banners) async {
    for (final banner in banners) {
      try {
        File image = await UHelperFunctions.assetToFile(banner.imageUrl);

        dio.Response response = await _cloudinaryServices.uploadImage(
          image,
          UKeys.bannersFolder,
        );

        if (response.statusCode == 200) {
          banner.imageUrl = response.data['url'];
        }

        await _db.collection(UKeys.bannerCollection).doc().set(banner.toJson());
        // print("Uploaded banner: ${banner.imageUrl}");
      } catch (e) {
        print("Error uploading ${banner.imageUrl}: $e");
        // continue; // <-- IMPORTANT 🔥
      }
    }
  }

  // Future<void> uploadBanners(List<BannerModel> banners) async {
  //   try {
  //     for (final banner in banners) {
  //       // convert assetPath to File
  //       File image = await UHelperFunctions.assetToFile(banner.imageUrl);
  //       dio.Response response =
  //           await _cloudinaryServices.uploadImage(image, UKeys.bannersFolder);
  //       if (response.statusCode == 200) {
  //         banner.imageUrl = response.data['url'];
  //       }
  //       await _db.collection(UKeys.bannerCollection).doc().set(banner.toJson());
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

  Future<List<BannerModel>> fetchActiveBanners() async {
    try {
      final query = await _db
          .collection(UKeys.bannerCollection)
          .where('active', isEqualTo: true)
          .get();
      if (query.docs.isNotEmpty) {
        List<BannerModel> banners = query.docs
            .map((document) => BannerModel.fromDocument(document))
            .toList();
        print('fetching successfully ${banners.length}');

        return banners;
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
}
