import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
class UBillingAmountSection extends StatelessWidget {
  const UBillingAmountSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(child: Text('SubTotal',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('\$345',style: Theme.of(context).textTheme.bodyMedium,),
    
          ],
        ),
    
        SizedBox(height: USizes.spaceBtwItems/2,),
    
    
         Row(
          children: [
            Expanded(child: Text('Shipping fee',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('\$12',style: Theme.of(context).textTheme.labelLarge,),
    
          ],
        ),
       SizedBox(height: USizes.spaceBtwItems/2,),
    
         Row(
          children: [
            Expanded(child: Text('Tax Fee',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('\$1',style: Theme.of(context).textTheme.labelLarge,),
    
          ],
        ),
    
        SizedBox(height: USizes.spaceBtwItems/2,),
         Row(
          children: [
            Expanded(child: Text('Total order',style: Theme.of(context).textTheme.bodyMedium,)),
            Text('\$1200',style: Theme.of(context).textTheme.titleMedium,),
    
          ],
        ),
    
    
    
    
    
      ],
    );
  }
}
