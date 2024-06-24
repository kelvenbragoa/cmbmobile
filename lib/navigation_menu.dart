import 'package:cmbapp/features/cmbhome/screens/fees/fees.dart';
import 'package:cmbapp/features/cmbhome/screens/home/home.dart';
import 'package:cmbapp/features/cmbhome/screens/payments/payments.dart';
import 'package:cmbapp/features/cmbhome/screens/profile/profile.dart';
import 'package:cmbapp/features/cmbhome/screens/scan/scan.dart';
import 'package:cmbapp/utils/constants/colors.dart';
import 'package:cmbapp/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NavigationMenu extends StatefulWidget {

   const NavigationMenu({super.key,});

  @override
  State<NavigationMenu> createState() => _NavigationMenuState();
}

class _NavigationMenuState extends State<NavigationMenu> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Obx(
        ()=> NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
          backgroundColor: darkMode ? TColors.black : TColors.white,
          indicatorColor: darkMode ? TColors.white.withOpacity(0.1):TColors.black.withOpacity(0.1),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Inicio'),
            NavigationDestination(icon: Icon(Iconsax.dollar_circle), label: 'Taxas'),
            NavigationDestination(icon: Icon(Iconsax.camera), label: 'Scan'),
            NavigationDestination(icon: Icon(Iconsax.receipt), label: 'Receitas'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Perfil'),
          ]),
      ),
        body: Obx(()=>controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController{
  final Rx<int> selectedIndex = 0.obs;
  final screens = [
                    const HomeScreen(),
                    const FeesScreen(),
                    const ScanScreen(),
                    const PaymentsScreen(),
                    const ProfileScreen()];
}