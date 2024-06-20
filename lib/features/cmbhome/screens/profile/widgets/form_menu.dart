import 'package:cmbapp/utils/constants/colors.dart';
import 'package:cmbapp/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class FormFieldMenu extends StatelessWidget {
  const FormFieldMenu({
    super.key,
    required this.onPressed,
    required this.title,
    required this.value,
    this.icon = Iconsax.arrow_right_34

  });

  final IconData icon;
  final VoidCallback onPressed;
  final String title, value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: TSizes.spaceBetwItems/1.5),
        child: Container(
          decoration: BoxDecoration(
            color: TColors.grey,
            borderRadius: BorderRadius.circular(5)
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Text(title, style: Theme.of(context).textTheme.bodySmall,overflow: TextOverflow.ellipsis,)),
                Expanded(
                  flex: 5,
                  child: Text(value, style: Theme.of(context).textTheme.bodySmall,overflow: TextOverflow.ellipsis,)),
               
              ],
            ),
          ),
        ),
      ),
    );
  }
}