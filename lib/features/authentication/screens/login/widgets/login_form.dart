import 'package:ecommerce/features/authentication/controllers/login/login_controller.dart';
import 'package:ecommerce/features/authentication/screens/forget_password/forget_password.dart';
import 'package:ecommerce/navigation_menu.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../../signup/signup.dart';
import 'package:get/get.dart';

class ULoginForm extends StatelessWidget {
  const ULoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
    return Form(
      key: controller.loginFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //email
          TextFormField(
            controller: controller.email,
            validator: (value) => UValidator.validateEmail(value),
            decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.direct_right), labelText: UTexts.email),
          ),
          SizedBox(height: USizes.spaceBtwInputFields),
          //password
          Obx(
            ()=> TextFormField(
              controller: controller.password,
              obscureText: controller.isPasswordVisible.value,
              validator: (value) => UValidator.validateEmptyText('Password' ,value),
              decoration: InputDecoration(
                prefixIcon: Icon(Iconsax.password_check),
                labelText: UTexts.password,
                suffixIcon: IconButton(onPressed: ()=>controller.isPasswordVisible.toggle(), icon: Icon(controller.isPasswordVisible.value ?  Iconsax.eye_slash : Iconsax.eye)),
              ),
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields / 2),
          //remember me and forget password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //remember me
              Row(
                children: [
                  Obx(()=> Checkbox(value: controller.rememberMe.value, onChanged: (value) =>controller.rememberMe.toggle())),
                  Text(UTexts.rememberMe),
                ],
              ),
              //forget password
              TextButton(
                  onPressed: () => Get.to(() => ForgetPasswordScreen()),
                  child: Text(UTexts.forgetPassword))
            ],
          ),
          SizedBox(height: USizes.spaceBtwSections),
      
          //signup
          UElevatedButton(
              onPressed:  controller.loginWithEmailAndPassword,
              child: Text(UTexts.signIn)),
          SizedBox(height: USizes.spaceBtwItems / 2),
      
          //create account
          SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                  onPressed: () => Get.to(() => SignupScreen()),
                  child: Text(UTexts.createAccount))),
        ],
      ),
    );
  }
}
