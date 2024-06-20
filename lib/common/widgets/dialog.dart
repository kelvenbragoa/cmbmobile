import 'package:get/get.dart';
import 'package:flutter/material.dart';



showAlertDialog1(BuildContext context,String desc) 
{ 
    // configura o button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const MyHomePage(title: 'EDC Ligeiros & Pesado',)), (route) => false);
      // Get.offAll(const HomeScreen());
     },
  );
  // configura o  AlertDialog
  AlertDialog alerta = AlertDialog(
  
    title: Text("Informação"),
    content: Text("$desc"),
    actions: [
      okButton,
    ],
  );
  // exibe o dialog
  showDialog(
    barrierDismissible: false,useRootNavigator: false,
    context: context,
    builder: (BuildContext context) {
      return WillPopScope(
        child: alerta, 
        onWillPop: () => Future.value(false));
    },
  );
}