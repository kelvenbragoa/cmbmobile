import 'package:flutter/material.dart';
import 'package:cmbapp/features/authentication/controllers/onboarding/onboarding_controllers.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/device/device_utility.dart';
import '../../../../../utils/helpers/helper.dart';

class OnBoardingNavigation extends StatelessWidget {
  const OnBoardingNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);
    final controller = OnBoardingController.instance;
    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 25,
      left: TSizes.defaultSpace,
      
      child: SmoothPageIndicator(
        
        effect: ExpandingDotsEffect(activeDotColor: dark ?  TColors.ligth : TColors.dark, dotHeight: 6),
        controller:controller.pageController,
        onDotClicked: controller.dotNavigatorClick ,
        count: 3));
  }
}