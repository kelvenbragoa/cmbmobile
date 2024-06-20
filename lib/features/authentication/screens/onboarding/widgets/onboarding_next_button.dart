import 'package:flutter/material.dart';
import 'package:cmbapp/features/authentication/controllers/onboarding/onboarding_controllers.dart';
import 'package:cmbapp/utils/constants/colors.dart';
import 'package:cmbapp/utils/helpers/helper.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: (){
          OnBoardingController.instance.nextPage();
        },
        style: ElevatedButton.styleFrom(shape: const CircleBorder(),backgroundColor: dark ? TColors.primary: Colors.black),
        child: const Icon(Icons.arrow_right_alt)
      ));
  }
}