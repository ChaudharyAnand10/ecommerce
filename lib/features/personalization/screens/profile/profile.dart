import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/features/personalization/screens/address/address.dart';
import 'package:ecommerce/features/personalization/screens/profile/widgets/profile_primary_header.dart';
import 'package:ecommerce/features/personalization/screens/profile/widgets/settings_menu_tile.dart';
import 'package:ecommerce/features/personalization/screens/profile/widgets/user_profile_tile.dart';
import 'package:ecommerce/features/shop/screens/order/order.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            UProfilePRimaryHeader(),
            Padding(
              padding: const EdgeInsets.all(USizes.defaultSpace),
              child: Column(
                children: [
                   UserProfileTile(),
                   SizedBox(height: USizes.spaceBtwItems,),
                   
              
                   USectionHeading(title: 'Account Settings' , showActionButton: false,),
              
              
                   SettingsMenuTile(title:'MyAddresses',subtitle: 'set Shopping delivery address' ,icon: Iconsax.safe_home,onTap: () => Get.to(()=>AddressScreen()),),
                   SettingsMenuTile(title:'My Cart',subtitle: 'Add , remove products and move to checkout' ,icon: Iconsax.safe_home,onTap: (){},),
                   SettingsMenuTile(title:'My Orders',subtitle: 'In-progress and completed Orders' ,icon: Iconsax.safe_home,onTap: ()=>Get.to(()=>OrderScreen()),),
                   SizedBox(height: USizes.spaceBtwSections,),


                   SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(onPressed: (){}, child: Text('Logout')),
                   ),
        
                 SizedBox(height: USizes.spaceBtwSections,),

        
                ],
              ),
            )
           
          ],
        ),
      ),
    );
  }
}
