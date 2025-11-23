
import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/button/social_button.dart';
import 'package:ecommerce/common/widgets/login_signup/form_divider.dart';
import 'package:ecommerce/features/authentication/screens/signup/widgets/signup_form.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:flutter/material.dart';
class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
        padding: UPadding.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //header

            Text(UTexts.signupTitle,style: Theme.of(context).textTheme.headlineMedium,),
            SizedBox(height: USizes.spaceBtwSections,),



            //form

            USignUpForm(),
            SizedBox(height: USizes.spaceBtwSections,),




            //divide

            UFormDivider(title: UTexts.orSignupWith),
            SizedBox(height: USizes.spaceBtwSections,),




            // footer
            USocialButton(),



          ],
        ),
        ),
      ),
    );
  }
}

