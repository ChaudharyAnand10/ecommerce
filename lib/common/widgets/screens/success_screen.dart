
import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/button/elevated_button.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/constants/texts.dart';
import 'package:ecommerce/utils/helpers/device_helpers.dart';
import 'package:flutter/material.dart';



class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key, required this.title, required this.subTitle, required this.image, required this.onTap});


  final String title , subTitle , image;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              Image.asset(image, height: UDeviceHelper.getScreenWidth(context)*0.6),
              SizedBox(height: USizes.spaceBtwItems),

              Text(title , style: Theme.of(context).textTheme.headlineMedium , textAlign: TextAlign.center),
              SizedBox(height: USizes.spaceBtwItems),
              
              Text(subTitle , style: Theme.of(context).textTheme.bodySmall , textAlign: TextAlign.center),
              SizedBox(height: USizes.spaceBtwSections),

              UElevatedButton(onPressed: onTap, child: Text(UTexts.uContinue)),
            ],
          ),
        ),
      ),
    );
  }
}
