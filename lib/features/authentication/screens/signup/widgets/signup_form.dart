
import 'package:ecommerce/features/authentication/screens/signup/widgets/privacy_policy_checkbox.dart';
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
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: TextFormField(
              decoration: InputDecoration(
                  labelText: UTexts.firstName,
                  prefixIcon: Icon(Iconsax.user)
              ),
            )),
            SizedBox(width: USizes.spaceBtwInputFields,),
            Expanded(child: TextFormField(
              decoration: InputDecoration(
                  labelText: UTexts.lastName,
                  prefixIcon: Icon(Iconsax.user)

              ),
            ))
          ],
        ),
        SizedBox(height: USizes.spaceBtwInputFields,),

        TextFormField(
          decoration: InputDecoration(
              labelText: UTexts.email,
              prefixIcon: Icon(Iconsax.direct_right)
          ),
        ),
        SizedBox(height: USizes.spaceBtwInputFields,),


        TextFormField(
          decoration: InputDecoration(
              labelText: UTexts.phoneNumber,
              prefixIcon: Icon(Iconsax.call)
          ),
        ),
        SizedBox(height: USizes.spaceBtwInputFields,),




        //  password


        TextFormField(
          decoration: InputDecoration(
              labelText: UTexts.password,
              prefixIcon: Icon(Iconsax.password_check),
              suffixIcon: Icon(Iconsax.eye)
          ),
        ),

        SizedBox(height: USizes.spaceBtwInputFields/2),





        // PRIVACY POLICY CHECKBOX
        UPrivacyPolicyCheckbox(),
        SizedBox(height: USizes.spaceBtwItems),

        UElevatedButton(onPressed: ()=>Get.to(()=>VerifyEmailScreen()), child: Text(UTexts.createAccount)),







      ],
    );
  }
}

