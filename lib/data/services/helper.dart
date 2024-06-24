import 'dart:convert';
import 'package:cmbapp/data/services/user_services.dart';
import 'package:cmbapp/utils/constants/api_constants.dart';
import 'package:cmbapp/utils/constants/global.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class HelperMethods{


    static Future<Position> checkLocation() async{
        bool serviceEnabled;
        LocationPermission permission;

        // Test if location services are enabled.
        serviceEnabled = await Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          // Location services are not enabled don't continue
          // accessing the position and request users of the 
          // App to enable the location services.
          return Future.error('Location services are disabled.');
        }

        permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            // Permissions are denied, next time you could try
            // requesting permissions again (this is also where
            // Android's shouldShowRequestPermissionRationale 
            // returned true. According to Android guidelines
            // your App should show an explanatory UI now.
            return Future.error('Location permissions are denied');
          }
        }
        
        if (permission == LocationPermission.deniedForever) {
          // Permissions are denied forever, handle appropriately. 
          return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
        } 

        // When we reach here, permissions are granted and we can
        // continue accessing the position of the device.
        return await Geolocator.getCurrentPosition();
  }

 static checkStatus() async {
  
    int today = DateTime.now().microsecondsSinceEpoch;

    SharedPreferences pref = await SharedPreferences.getInstance();
    int? start_app_lp1 = pref.getInt('start_app_lp');
    int? end_app_lp1 = pref.getInt('end_app_lp');
    String? status_app_lp1 = pref.getString('status_app_lp');

    int? start_app_pro1 = pref.getInt('start_app_pro');
    int? end_app_pro1 = pref.getInt('end_app_pro');
    String? status_app_pro1 = pref.getString('status_app_pro');

    if(status_app_lp1 !=null){
      Global.status_app_lp = status_app_lp1;
    }
    if(end_app_lp1 !=null){
      Global.end_app_lp = end_app_lp1;
    }
    if(start_app_lp1 !=null){
      Global.start_app_lp = start_app_lp1;
    }

    if(status_app_pro1 !=null){
      Global.status_app_pro = status_app_pro1;
    }
    if(end_app_pro1 !=null){
      Global.end_app_pro = end_app_pro1;
    }
    if(start_app_pro1 !=null){
      Global.start_app_pro = start_app_pro1;
    }

    if(today > Global.end_app_lp!){
      await pref.setString('status_app_lp', 'inativo');
      Global.status_app_lp = 'inativo';
    }else{
      await pref.setString('status_app_lp', 'ativo');
      Global.status_app_lp = 'ativo';
    }

    if(today > Global.end_app_pro!){
      await pref.setString('status_app_pro', 'inativo');
      Global.status_app_pro = 'inativo';
    }else{
      await pref.setString('status_app_pro', 'ativo');
      Global.status_app_pro = 'ativo';
    }


    

  }




}