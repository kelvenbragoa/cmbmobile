import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:cmbapp/utils/constants/sizes.dart';
import 'package:cmbapp/utils/constants/text_strings.dart';
import 'package:cmbapp/utils/helpers/helper.dart';


class ForgetScreen extends StatefulWidget {

  const ForgetScreen({super.key});

  @override
  State<ForgetScreen> createState() => _ForgetScreenState();
}

class _ForgetScreenState extends State<ForgetScreen> {

  bool loading = false;
  


  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: dark ? Colors.white : Colors.black, //change your color here
          ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(TText.forgetTitle, style: Theme.of(context).textTheme.headlineMedium,),
              const SizedBox(height: TSizes.spaceBetwSections,),
              Text(TText.forgetText, style: Theme.of(context).textTheme.bodyMedium,),
              const SizedBox(height: TSizes.spaceBetwSections,),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal:TSizes.spaceBetwSections*2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Iconsax.call),
                    Icon(Iconsax.mobile),
                    Icon(Iconsax.message),
                  ],
                ),
              )



            
            ],)
        ),
      ),
    );
  }
}