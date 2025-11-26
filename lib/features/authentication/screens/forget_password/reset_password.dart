import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/features/authentication/controllers/forget_password/forget_password_controller.dart';
import 'package:ecommerce/features/authentication/screens/login/login.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/device_helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final controller = ForgetPasswordController.instance;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
              onPressed: () => Get.offAll(() => LoginScreen()),
              icon: Icon(CupertinoIcons.clear))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              //image
              Image.asset(UImages.mailSentImage,
                  height: UDeviceHelper.getScreenWidth(context) * 0.6),
              SizedBox(height: USizes.spaceBtwItems),
              //title

              Text(UTexts.resetPasswordTitle,
                  style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: USizes.spaceBtwItems),

              //email
              Text(
                email,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              SizedBox(height: USizes.spaceBtwItems),

              //subtitle
              Text(UTexts.resetPasswordSubTitle,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center),
              SizedBox(height: USizes.spaceBtwSections),

              //Done
              UElevatedButton(
                  onPressed: () => Get.offAll(() => LoginScreen()),
                  child: Text(UTexts.done)),

              //resendemail
              SizedBox(
                  width: double.infinity,
                  child: TextButton(
                      onPressed: controller.resendPasswordResetEmail, child: Text(UTexts.resendEmail))),
            ],
          ),
        ),
      ),
    );
  }
}
