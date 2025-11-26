import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/authentication/screens/forget_password/reset_password.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  static ForgetPasswordController get instance => Get.find();

  final email = TextEditingController();
  final forgetPasswordFormKey = GlobalKey<FormState>();

  Future<void> sendPasswordResetEmail() async {
    try {
      UFullScreenLoader.openLoadingDialog('Processing your password');

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');

        return;
      }

      if (forgetPasswordFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      AuthenticationRepository.instance.sendPasswordResetEmail(email.text.trim());

      UFullScreenLoader.stopLoading();

      USnackBarHelpers.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link set to reset your password');

      Get.to(() => ResetPasswordScreen(email: email.text.trim(),));
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
          title: 'Failed Forget password', message: e.toString());
    }
  }



  Future<void> resendPasswordResetEmail() async {
    try {
      UFullScreenLoader.openLoadingDialog('Processing your password');

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');

        return;
      }

      AuthenticationRepository.instance.sendPasswordResetEmail(email.text);

      UFullScreenLoader.stopLoading();

      USnackBarHelpers.successSnackBar(
          title: 'Email Sent',
          message: 'Email Link set to reset your password');

      
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
          title: 'Failed Forget password', message: e.toString());
    }
  }



}
