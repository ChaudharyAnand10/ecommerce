import 'package:ecommerce/features/authentication/screens/forget_password/forget_password.dart';
import 'package:ecommerce/navigation_menu.dart';
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //email
        TextFormField(
          decoration: InputDecoration(
              prefixIcon: Icon(Iconsax.direct_right),
              labelText: UTexts.email

          ),
        ),
        SizedBox(height:  USizes.spaceBtwInputFields),
        //password
        TextFormField(
          decoration: InputDecoration(
            prefixIcon: Icon(Iconsax.password_check),
            labelText: UTexts.password,
            suffixIcon: Icon(Iconsax.eye),

          ),
        ),
        SizedBox(height: USizes.spaceBtwInputFields/2),
        //remember me and forget password
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //remember me
            Row(
              children: [
                Checkbox(value: true, onChanged: (value){}),
                Text(UTexts.rememberMe),

              ],
            ),
            //forget password
            TextButton(
                onPressed: ()=>Get.to(()=>ForgetPasswordScreen()), child: Text(UTexts.forgetPassword)
            )

          ],
        ),
        SizedBox(height: USizes.spaceBtwSections),


        //signup
        UElevatedButton(onPressed: ()=>Get.to(()=>NavigationMenu()), child: Text(UTexts.signIn)),
        SizedBox(height: USizes.spaceBtwItems/2),

        //create account
        SizedBox(
          width: double.infinity,
            child: OutlinedButton(onPressed: ()=>Get.to(()=>SignupScreen()), child: Text(UTexts.createAccount))),


      ],
    );
  }
}
