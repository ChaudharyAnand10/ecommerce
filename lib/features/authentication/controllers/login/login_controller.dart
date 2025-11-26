import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/features/personalization/controllers/user_controller.dart';
import 'package:ecommerce/utils/constants/keys.dart';
import 'package:ecommerce/utils/helpers/network_manager.dart';
import 'package:ecommerce/utils/popups/full_screen_loader.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  static LoginController get instance => Get.find();

  ///variables
  final _userController = Get.put(UserController());

  final email = TextEditingController();
  final password = TextEditingController();

  RxBool isPasswordVisible = false.obs;
  RxBool rememberMe = false.obs;

  final loginFormKey = GlobalKey<FormState>();

  final localStorage = GetStorage();

  @override
  void onInit() {
    email.text = localStorage.read(UKeys.rememberMeEmail) ?? ' ';
    password.text = localStorage.read(UKeys.rememberMePassword) ?? ' ';
    super.onInit();
  }

  Future<void> loginWithEmailAndPassword() async {
    try {
      UFullScreenLoader.openLoadingDialog('Logging you in ...');

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');

        return;
      }

      if (!loginFormKey.currentState!.validate()) {
        UFullScreenLoader.stopLoading();
        return;
      }

      if (rememberMe.value) {
        localStorage.write(UKeys.rememberMeEmail, email.text.trim());
        localStorage.write(UKeys.rememberMePassword, password.text.trim());
      }

      await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      UFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      UFullScreenLoader.stopLoading();
      USnackBarHelpers.errorSnackBar(
          title: 'Login Failed', message: e.toString());
    }
  }

  Future<void> googeSignIn() async {
    try {
      UFullScreenLoader.openLoadingDialog('Logging you in ...');

      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        UFullScreenLoader.stopLoading();
        USnackBarHelpers.warningSnackBar(title: 'No Internet Connection');

        return;
      }

      UserCredential userCredential =
          await AuthenticationRepository.instance.signInWithGoogle();

      await _userController.saveUserRecord(userCredential);

      UFullScreenLoader.stopLoading();

      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      UFullScreenLoader.stopLoading();

      USnackBarHelpers.errorSnackBar(
          title: 'Login Failed', message: e.toString());
    }
  }
}
