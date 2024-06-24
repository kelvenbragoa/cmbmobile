
import 'package:cmbapp/common/custom_shapes/containers/primary_head_container.dart';
import 'package:cmbapp/common/widgets/search_container.dart';
import 'package:cmbapp/common/widgets/section_heading.dart';
import 'package:cmbapp/common/widgets/vertical_image_text.dart';
import 'package:cmbapp/data/repositories/api_response.dart';
import 'package:cmbapp/data/repositories/dashboard.dart';
import 'package:cmbapp/data/services/home_service.dart';
import 'package:cmbapp/data/services/user_services.dart';
import 'package:cmbapp/features/authentication/screens/onboarding/onboarding.dart';
import 'package:cmbapp/features/cmbhome/screens/home/widgets/dashboard_card.dart';
import 'package:cmbapp/features/cmbhome/screens/profile/widgets/form_menu.dart';
import 'package:cmbapp/utils/constants/api_constants.dart';
import 'package:cmbapp/utils/constants/colors.dart';
import 'package:cmbapp/utils/constants/sizes.dart';
import 'package:cmbapp/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/profile_app_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              size: 125,
              child: Column(
               children: [
                TProfileAppBar(),
                SizedBox(height: TSizes.spaceBetwSections,),
               ],
              )
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Informação Perfil',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
            
                ),
            ),
               const SizedBox(
                height: TSizes.spaceBetwItems,
              ),

             FormFieldMenu(onPressed: (){},title: "Nome:",value: UserService.userProfile.firstName),
             const SizedBox(height: TSizes.spaceBetwItems,),
             FormFieldMenu(onPressed: (){},title: "Apelido:",value: UserService.userProfile.lastName),
             const SizedBox(height: TSizes.spaceBetwItems,),
             FormFieldMenu(onPressed: (){},title: "Código:",value: UserService.userProfile.code),
             const SizedBox(height: TSizes.spaceBetwItems,),
             FormFieldMenu(onPressed: (){},title: "Telefone:",value: UserService.userProfile.mobile),

             const SizedBox(
                height: TSizes.spaceBetwItems,
              ),

              InkWell(
                onTap: (){
                   showDialog(context: context , builder: (BuildContext context)=>AlertDialog(
                            title: const Text(TText.logOutButton),
                            content: Text(TText.logOutInfo),
                            actions: [
                              TextButton(
                                onPressed: ()async{
                                  SharedPreferences pref = await SharedPreferences.getInstance();
                                  pref.remove('id');
                                  pref.remove('email');
                                  pref.remove('firstName');
                                  pref.remove('lastName');
                                  pref.remove('mobile');
                                  pref.remove('code');
                                  
                                  Get.offAll(const OnBoardingScreen());
                            
                              }, 
                              child: const Text(TText.yes)),

                              TextButton(onPressed: (){Navigator.pop(context);}, child: const Text(TText.no))
                            ],
                          ));
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(TText.logOutButton),
                    Icon(Iconsax.logout)
                  ],
              
                ),
              ),
         
            
  
          ],
        ),
      ),
    );
  }
}




