import 'dart:async';

import 'package:ecommerce/common/widgets/screens/success_screen.dart';
import 'package:ecommerce/data/repositories/authentication_repository.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/popups/snackar_helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  Future<void> sendEmailVerification() async {
    try {
      await AuthenticationRepository.instance.sendEmailVerification();
      USnackBarHelpers.successSnackBar(
          title: 'Email Sent',
          message: 'plz check your inbox and verify your email');
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }

  void setTimerForAutoRedirect() {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser!.reload();
      final user = FirebaseAuth.instance.currentUser;

      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
            title: UTexts.accountCreatedTitle,
            subTitle: UTexts.accountCreatedSubTitle,
            image: UImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect()));
      }
    });
  }

  Future<void> checkEmailVerificationStatus() async {
    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null && currentUser.emailVerified) {
        Get.off(() => SuccessScreen(
            title: UTexts.accountCreatedTitle,
            subTitle: UTexts.accountCreatedSubTitle,
            image: UImages.successfulPaymentIcon,
            onTap: () => AuthenticationRepository.instance.screenRedirect()));
      }
    } catch (e) {
      USnackBarHelpers.errorSnackBar(title: 'Error', message: e.toString());
    }
  }
}
