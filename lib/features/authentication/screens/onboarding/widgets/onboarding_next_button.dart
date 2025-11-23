// import 'package:flutter/cupertino.dart';
import 'package:ecommerce/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/button/elevated_button.dart';
import '../../../../../utils/constants/sizes.dart';
import 'package:get/get.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;
    return Positioned(
        left: 0,
        right: 0,
        bottom: USizes.spaceBtwItems*4,
        child: UElevatedButton(
          child: Obx(()=> Text( controller.currentIndex.value==2 ? 'GetStarted':'Next')),
          onPressed: controller.nextPage,
        ));
  }
}
