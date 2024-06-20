import 'package:cmbapp/navigation_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:cmbapp/data/repositories/user.dart';
import 'package:cmbapp/data/services/helper.dart';
import 'package:cmbapp/data/services/user_services.dart';
import 'package:cmbapp/features/authentication/screens/onboarding/onboarding.dart';
import 'package:cmbapp/utils/theme/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {

    bool loggedin = false;
    Future<void> _checkStatus() async {
      

    SharedPreferences pref = await SharedPreferences.getInstance();
    print(pref.getInt('id').isBlank);
    if(pref.getInt('id') == null){
      
      return;
    }else{
      setState(() {
        loggedin = true;
      });
      
       UserService.userProfile = UserData(
        id: pref.getInt('id') ?? 0,
        email: pref.getString('email') ?? '',
        firstName: pref.getString('firstName') ?? '',
        lastName: pref.getString('lastName') ?? '',
        mobile: pref.getString('mobile')?? '',
        code: pref.getString('code')?? '',
        today: pref.getString('today')?? '',
        month: pref.getString('month')?? '',
        yesterday: pref.getString('yesterday')?? '',
        year: pref.getString('year')?? '',
        );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkStatus();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EMRICH',
      themeMode: ThemeMode.system,
      theme: TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      home: loggedin ? const NavigationMenu() : const OnBoardingScreen(),
    );
  }
}