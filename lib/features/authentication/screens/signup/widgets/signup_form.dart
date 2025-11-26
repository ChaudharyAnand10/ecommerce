
import 'package:ecommerce/features/authentication/controllers/signup/signup_controller.dart';
import 'package:ecommerce/features/authentication/screens/signup/widgets/privacy_policy_checkbox.dart';
import 'package:ecommerce/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/texts.dart';
import '../verify_email.dart';
import 'package:get/get.dart';
class USignUpForm extends StatelessWidget {
  const USignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = SignupController.instance;
    return Form(
      key: controller.signUpFormKey,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: controller.firstName,
                  validator: (value) => UValidator.validateEmptyText('First Name',value),

                decoration: InputDecoration(
                    labelText: UTexts.firstName,
                    prefixIcon: Icon(Iconsax.user)
                ),
              )),



              SizedBox(width: USizes.spaceBtwInputFields,),



              Expanded(
                child: TextFormField(
                  controller: controller.lastName,
                  validator: (value) => UValidator.validateEmptyText('Last Name',value),
                decoration: InputDecoration(
                    labelText: UTexts.lastName,
                    prefixIcon: Icon(Iconsax.user)
      
                ),
              ))
            ],
          ),
          SizedBox(height: USizes.spaceBtwInputFields,),
      
          TextFormField(
            controller: controller.email,
            validator: (value)=>UValidator.validateEmail(value),
            decoration: InputDecoration(
                labelText: UTexts.email,
                prefixIcon: Icon(Iconsax.direct_right)
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields,),
      
      
          TextFormField(
            controller: controller.phoneNumber,
            validator: (value) => UValidator.validatePhoneNumber(value),
            decoration: InputDecoration(
                labelText: UTexts.phoneNumber,
                prefixIcon: Icon(Iconsax.call)
            ),
          ),
          SizedBox(height: USizes.spaceBtwInputFields,),
      
      
      
      
          //  password
      
      
          Obx(
          ()=> TextFormField(
            obscureText: controller.isPasswordVisible.value,
              controller: controller.password,
              validator: (value) => UValidator.validatePassword(value),
              decoration: InputDecoration(
                  labelText: UTexts.password,
                  prefixIcon: Icon(Iconsax.password_check),
                  suffixIcon: IconButton(onPressed: () => controller.isPasswordVisible.value = !controller.isPasswordVisible.value, icon: Icon(controller.isPasswordVisible.value ? Iconsax.eye : Iconsax.eye_slash)),
              ),
            ),
          ),
      
          SizedBox(height: USizes.spaceBtwInputFields/2),
      
      
      
      
      
          // PRIVACY POLICY CHECKBOX
          UPrivacyPolicyCheckbox(),
          SizedBox(height: USizes.spaceBtwItems),
      
          UElevatedButton(onPressed:controller.registerUser, child: Text(UTexts.createAccount)),
      
      
      
      
      
      
      
        ],
      ),
    );
  }
}

