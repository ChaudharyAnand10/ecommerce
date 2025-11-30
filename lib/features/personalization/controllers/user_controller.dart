import 'dart:io';

import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/features/personalization/screens/edit_profile/widgets/re_authenticate_user_form.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final _userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;

  RxBool profileLoading = false.obs;

  final email = TextEditingController();
  final password = TextEditingController();
  final reAuthFormKey = GlobalKey<FormState>();
  RxBool isPasswordVisible = false.obs;
  RxBool isProfileUploading = false.obs;

  @override
  void onInit() {
    fetchUserDetails();
    super.onInit();
  }

  Future<void> saveUserRecord(UserCredential userCredential) async {
    try {
      await fetchUserDetails();

      if (user.value.id.isEmpty) {
        final nameParts = UserModel.nameParts(userCredential.user!.displayName);

        final username = '${userCredential.user!.displayName}23451';

        UserModel userModel = UserModel(
            id: userCredential.user!.uid,
            firstName: nameParts[0],
            lastName:
                nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
            username: username,
            email: userCredential.user!.email ?? '',
            phoneNumber: userCredential.user!.phoneNumber ?? '',
            profilePicture: userCredential.user!.photoURL ?? '');

        await _userRepository.saveUserRecord(userModel);
      }
    } catch (e) {
      USnackBarHelpers.warningSnackBar(
          title: 'Data not saved',
          message: 'something went wrong while saving your info');
    }
  }

  Future<void> fetchUserDetails() async {
    try {
      profileLoading.value = true;

      final user = await _userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  void deleteAccountWarningPopup() {
    Get.defaultDialog(
      contentPadding: EdgeInsets.all(USizes.md),
      title: 'Delete Account',
      middleText: 'Are you sure you want to delete account permanently ?',
      confirm: ElevatedButton(
          onPressed: () => deleteUserAccount(),
          style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red, side: BorderSide(color: Colors.red)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: USizes.lg),
            child: Text('Delete'),
          )),
      cancel:
          OutlinedButton(onPressed: () => Get.back(), child: Text('Cancel')),
    );
  }

  Future<void> deleteUserAccount() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing...');

      final authRepository = AuthenticationRepository.instance;
      final provider = authRepository.currentUser!.providerData
          .map((e) => e.providerId)
          .first;

      if (provider == 'google.com') {
        await authRepository.signInWithGoogle();
        await authRepository.deleteAccount();
        UFullScreenLoader.stopLoading();
        Get.offAll(() => LoginScreen());
      } else if (provider == 'password') {
        UFullScreenLoader.stopLoading();
        Get.to(() => ReAuthenticateUserForm());
      }
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  Future<void> reAuthenticateUser() async {
    try {
      // Start Loading
      UFullScreenLoader.openLoadingDialog('Processing...');

// Check Internet Connectivity
      bool isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        return;
      }

// Form Validation
      if (!reAuthFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRepository.instance
          .reAuthenticateUserWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      await AuthenticationRepository.instance.deleteAccount();

      UFullScreenLoader.stopLoading();
      Get.offAll(() => LoginScreen());
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Failed', message: e.toString());
    }
  }

  Future<void> updateUserProfilePicture() async {
    try {
      // Pick image from gallery

      isProfileUploading.value = true;
      XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
      );
      if (image == null) return;

// Convert XFile to File
      File file = File(image.path);

      if (user.value.publicId.isNotEmpty) {
        await _userRepository.deleteProfilePicture(user.value.publicId);
      }

// Upload profile Picture To Cloudinary
      dio.Response response = await _userRepository.uploadImage(file);
      if (response.statusCode == 200) {
        final data = response.data;
        final imageUrl = data['url'];
        final publicId = data['public_id'];

        // update profile picture from Firestore
        await _userRepository.updateSingleField(
            {'profilePicture': imageUrl, 'publicId': publicId});

        user.value.profilePicture = imageUrl;
        user.value.publicId = publicId;

        user.refresh();

        USnackBarHelpers.successSnackBar(
            title: 'congratulations',
            message: 'PRofile picture updated successfuly');
      } else {
        throw 'Failed to upload profile picture. Please try again';
      }
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Failed!', message: e.toString());
    }finally{
      isProfileUploading.value = false;
    }
  }
}
