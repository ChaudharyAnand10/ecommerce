import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/data/repositories/user/user_repository.dart';
import 'package:ecommerce/features/authentication/models/user_model.dart';
import 'package:ecommerce/features/authentication/screens/signup/verify_email.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();


  final signUpFormKey = GlobalKey<FormState>();

  RxBool isPasswordVisible = false.obs;
  RxBool privacyPolicy = false.obs;

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final email = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();

  Future<void> registerUser() async {
    try {
      UFullScreenLoader.openLoadingDialog(
          'WE are processing your information ...');

      bool isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet connection');
        return;
      }

      if (!privacyPolicy.value) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(
            title: 'Accept Privac Policy',
            message:
                'Inorder to create account you must read the privecy and policy ');
        return;
      }

      if (!signUpFormKey.currentState!.validate()) {
        return;
      }

      UserCredential userCredential = await AuthenticationRepository.instance.registerUser(
          email.text.trim(), password.text.trim());

      UserModel userModel = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text,
        lastName: lastName.text,
        username: '${firstName.text} ${lastName.text} 716283',
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());

      await userRepository.saveUserRecord(userModel);

      USnackBarHelpers.successSnackBar(
          title: 'Congratulations!',
          message: 'Your Account has been created ! Verify email to continue');
      UFullScreenLoader.stopLoading();

      Get.to(() => VerifyEmailScreen(email: email.text,));
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
