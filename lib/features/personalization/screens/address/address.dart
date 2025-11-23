import 'package:ecommerce/common/style/padding.dart';
import 'package:ecommerce/common/widgets/appbar/appbar.dart';
import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/features/personalization/screens/address/add_newaddress.dart';
import 'package:ecommerce/features/personalization/screens/address/widgets/single_address.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: UAppBar(showBackArrow: true,title: Text('Address' , style: Theme.of(context).textTheme.headlineMedium,),),
      body: SingleChildScrollView(
        child: Padding(
          padding: UPadding.screenPadding,
          child: Column(
            children: [
              USingleAddress(isSelected: true,),
              SizedBox(height: USizes.spaceBtwItems,),
               USingleAddress(isSelected: false,),
              
              
            ],
          ),
        ),
      ),





      floatingActionButton: FloatingActionButton(onPressed: ()=>Get.to(()=>AddNewAddressScreen()),backgroundColor: UColors.primary,child: Icon(Iconsax.add),),
    );
  }
}
