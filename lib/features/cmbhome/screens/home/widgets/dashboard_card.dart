import 'package:cmbapp/utils/constants/colors.dart';
import 'package:cmbapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';



class DashboardCard extends StatelessWidget {
   DashboardCard({
    Key? key, 
 
    required this.title, 
    required this.amount, 
   
  }) : super(key: key);

  final String title;
  final double amount;
  

  var number = NumberFormat.currency(name: 'MZN');



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(TSizes.defaultSpace/2),
      child: Container(
       
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        decoration: const BoxDecoration(
          color: TColors.primary,
          borderRadius: BorderRadius.all(Radius.circular(10))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Text(title , 
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: TColors.white),
                ),
            
           
            
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
               
                  Text(number.format(amount)
                  , style: Theme.of(context)
                  .textTheme.bodySmall
                  !.copyWith(color: 
                  Colors.white
                  ),
                  ),
                   const Icon(
                  Icons.more_vert, color:Colors.white54
                )
                ],
              )
          ],
        ),
      ),
    );
  }
}