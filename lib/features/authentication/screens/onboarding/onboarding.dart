import 'package:ecommerce/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:ecommerce/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:ecommerce/utils/constants/images.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';



class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(OnBoardingController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: USizes.defaultSpace),
        child: Stack(
          children: [
            PageView(
              controller:controller.pageController ,
              onPageChanged: controller.updatePageIndicator,
              children: [
                OnBoardingPage(animation: UImages.onboarding1Animation,title: UTexts.onBoardingTitle1,subtitle: UTexts.onBoardingSubTitle1,),
                OnBoardingPage(animation: UImages.onboarding2Animation,title: UTexts.onBoardingTitle2,subtitle: UTexts.onBoardingSubTitle2,),
                OnBoardingPage(animation: UImages.onboarding3Animation,title: UTexts.onBoardingTitle3,subtitle: UTexts.onBoardingSubTitle3,),



              ],
            ),

            OnBoardingDotNavigation(),

            OnBoardingNextButton(),


            OnBoardingSkipButton()
          ],
        ),
      ),
    );
  }
}






