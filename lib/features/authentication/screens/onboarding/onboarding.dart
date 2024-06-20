import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cmbapp/features/authentication/controllers/onboarding/onboarding_controllers.dart';
import 'package:cmbapp/features/authentication/screens/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:cmbapp/features/authentication/screens/onboarding/widgets/onboarding_next_button.dart';
import 'package:cmbapp/features/authentication/screens/onboarding/widgets/onboarding_page.dart';
import 'package:cmbapp/features/authentication/screens/onboarding/widgets/onboarding_skip.dart';
import 'package:cmbapp/utils/constants/image_strings.dart';
import 'package:cmbapp/utils/constants/text_strings.dart';
import 'package:cmbapp/utils/helpers/helper.dart';



class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(OnBoardingController());

    return Scaffold(
      body: Stack(
        children: [

          //pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: [
              OnBoardingPage(image: dark ? TImages.lightAppLogo : TImages.darkAppLogo, title: TText.onBoardingTitle1,subtitle: TText.onBoardingSubTitle1,),
              OnBoardingPage(image: dark ? TImages.lightAppLogo : TImages.darkAppLogo, title: TText.onBoardingTitle2,subtitle: TText.onBoardingSubTitle2,),
              OnBoardingPage(image: dark ? TImages.lightAppLogo : TImages.darkAppLogo, title: TText.onBoardingTitle3,subtitle: TText.onBoardingSubTitle3,),
            ],
          ),

          //skip button
          const OnBoardingSkip(),

          //Dot Navigation smoot page Indicator
          const OnBoardingNavigation(),


          // Circular Button
          const OnBoardingNextButton()
        ],
      ),
    );
  }
}







