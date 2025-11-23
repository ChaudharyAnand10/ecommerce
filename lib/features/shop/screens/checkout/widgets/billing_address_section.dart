import 'package:ecommerce/common/widgets/texts/section_heading.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class UBillingAddressSection extends StatelessWidget {
  const UBillingAddressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        USectionHeading(title: 'Billing Address' , buttonTitle: 'Change', onPressed: (){},),

        Text('UnKnown Pro' , style: Theme.of(context).textTheme.titleLarge,),
           SizedBox(height: USizes.spaceBtwItems/2,),

        Row(
          children: [
            Icon(Icons.phone , size: USizes.iconSm, color: UColors.darkGrey,),
            SizedBox(width: USizes.spaceBtwItems,),

            Text('+91 892889383983')

          ],
        ),

        SizedBox(height: USizes.spaceBtwItems/2,),



        Row(
          children: [
            Icon(Icons.location_history , size: USizes.iconSm, color: UColors.darkGrey,),
            SizedBox(width: USizes.spaceBtwItems,),

            Expanded(child: Text('Delhi ,  Sector 14  NH-24 Nice Place' , softWrap: true,))

          ],
        ),



      ],
    );
  }
}