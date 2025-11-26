import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/features/authentication/controllers/login/login_controller.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/login_form.dart';
import 'package:ecommerce/features/authentication/screens/login/widgets/login_header.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/widgets/button/social_button.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(LoginController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //title and subtitle
              ULoginHeader(),
              SizedBox(height: USizes.spaceBtwSections),

              //form

              ULoginForm(),
              SizedBox(height: USizes.spaceBtwSections),

              //divide
              UFormDivider(
                title: UTexts.orSignInWith,
              ),
              SizedBox(height: USizes.spaceBtwSections),

              // footer  social media
              USocialButton()
            ],
          ),
        ),
      ),
    );
  }
}
