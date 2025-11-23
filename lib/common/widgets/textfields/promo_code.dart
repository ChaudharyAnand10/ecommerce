import 'package:ecommerce/common/widgets/custom_shapes/rounded_container.dart';
import 'package:ecommerce/utils/constants/colors.dart';
import 'package:ecommerce/utils/constants/sizes.dart';
import 'package:ecommerce/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
class UPromocodeField extends StatelessWidget {
  const UPromocodeField({
    super.key,
    
  });

 

  @override
  Widget build(BuildContext context) {
        final dark = UHelperFunctions.isDarkMode(context);
    return URoundedContainer(
      showBorder: true,
      backgroundColor: Colors.transparent,
      padding: EdgeInsets.only(left: USizes.md , right: USizes.sm ,bottom: USizes.sm ,top: USizes.sm),
      child: Row(
        children: [
          Flexible(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'have a promo code entered here',
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                ),
            ),
          ),
    
         SizedBox(width: 80,
          child: ElevatedButton(
            onPressed: (){},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.withValues(alpha: 0.2),
              foregroundColor:dark ? UColors.white.withValues(alpha: 0.5) : UColors.dark.withValues(alpha: 0.5) ,
              side: BorderSide(color: Colors.grey.withValues(alpha: 0.1)),
              
            ),
             child: Text('Apply'),
            )),
    
    
        ],
      ),
    );
  }
}