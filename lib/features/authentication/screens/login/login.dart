import 'package:flutter/material.dart';
import 'package:cmbapp/features/authentication/screens/login/widget/loginform.dart';
import 'package:cmbapp/features/authentication/screens/login/widget/loginheader.dart';
import 'package:cmbapp/utils/constants/colors.dart';
import 'package:cmbapp/utils/helpers/helper.dart';

import '../../../../common/styles/spacing_styles.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    final dark = THelperFunctions.isDarkMode(context);
    final now = DateTime.now();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: TSpacingStyles.paddingWithAppBarHeight,
          child: Column(
            children: [
              //LOGO TITLE AND SUBTITLE
              LoginHeader(dark: dark),


              //FORM

              const LoginForm(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(child: Divider(color: dark ? TColors.darkGrey : TColors.grey, thickness: 0.5, indent: 60, endIndent: 5,)),
                    Text('${now.year} \u00a9 EMRICH',style: const TextStyle(fontSize: 10),),
                    Flexible(child: Divider(color: dark ? TColors.darkGrey : TColors.grey, thickness: 0.5, indent: 5, endIndent: 60,))
                  ],
                )
            ],
          ),

        ),
      ),
    );
  }
}

