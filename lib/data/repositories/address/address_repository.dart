import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/personalization/models/address_model.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/exceptions/firebase_exceptions.dart';
import 'package:ecommerce/utils/exceptions/format_exceptions.dart';
import 'package:ecommerce/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AddressRepository extends GetxController {
  static AddressRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  Future<String> addAddress(AddressModel address) async {
    try {
      final userId = AuthenticationRepository.instance.currentUser!.uid;
      final currentAddress = await _db
          .collection(UKeys.userCollection)
          .doc(userId)
          .collection(UKeys.addressCollection)
          .add(address.toJson());

      return currentAddress.id;
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong while saving address. Please try again';
    }
  }

  // Future<List<AddressModel>> fetchUserAddress() async {
  //   try {
  //     final userId = AuthenticationRepository.instance.currentUser!.uid;
  //     if (userId.isEmpty) throw 'User Not found , Please login again';
  //     final query = await _db
  //         .collection(UKeys.userCollection)
  //         .doc(userId)
  //         .collection(UKeys.addressCollection)
  //         .get();

  //     if (query.docs.isNotEmpty) {
  //       List<AddressModel> addresses = query.docs
  //           .map((doc) => AddressModel.fromDocumentSnapshot(doc))
  //           .toList();
  //       return addresses;
  //     }

  //     return [];
  //   } on FirebaseException catch (e) {
  //     throw UFirebaseException(e.code).message;
  //   } on FormatException catch (_) {
  //     throw UFormatException();
  //   } on PlatformException catch (e) {
  //     throw UPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Unable to find  addresses. Please try again';
  //   }
  // }

  Future<List<AddressModel>> fetchUserAddress() async {
    try {
      final user = AuthenticationRepository.instance.currentUser;
      // print('user is $user');
      if (user == null) throw 'User not found, Please login again';
      // print('user hai yha ');

      final query = await _db
          .collection(UKeys.userCollection)
          .doc(user.uid)
          .collection(UKeys.addressCollection)
          .get();
      // print('qury is this $query');

      if (query.docs.isNotEmpty) {
        return query.docs
            .map((doc) => AddressModel.fromDocumentSnapshot(doc))
            .toList();
      }

      return [];
    } on FirebaseException catch (e) {
      throw UFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw UFormatException();
    } on PlatformException catch (e) {
      throw UPlatformException(e.code).message;
    } catch (e) {
      throw 'Unable to load addresses. Please try again';
    }
  }

  Future<void> updateSelectedField(String addressId, bool selected) async {
    try {
      final userId = AuthenticationRepository.instance.currentUser!.uid;
      await _db
          .collection(UKeys.userCollection)
          .doc(userId)
          .collection(UKeys.addressCollection)
          .doc(addressId)
          .update({'selectedAddress': selected});
    } catch (e) {
      throw 'Unable to update selected address please try again';
    }
  }
}
