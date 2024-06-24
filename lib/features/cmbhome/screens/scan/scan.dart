
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
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {

  String _scanBarcode = 'Desconhecido';
  int statussell = 2;
  int status = 0;
  int errorcode = 0;
  String barcode = '' ;
  String estado = '';
  int estadoId = 0;
  bool loading = false;

    Future<void> scanQR() async {
    int actual_status = 0;
    int actual_error = 0;
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    // barcodeScanRes
    // if(finalvalue.idEvento == userProfile.event_id){
    //   actual_status = 1;
    //   actual_error = 0;
    // }else{
    //   actual_error = 1;
    // }


  
    setState(() {
      status = 1;
      errorcode = actual_error;
      _scanBarcode = barcodeScanRes;

      barcode = barcodeScanRes;
    });

    // getStatus(barcode);
    
  }
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
                      'Scan',
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
              Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // ElevatedButton(
                        //     onPressed: () => scanBarcodeNormal(),
                        //     child: Text('Start barcode scan')),
                        Container(
                          margin: const EdgeInsets.only(
                            top: 10.0,
                            ),

                          width: 250.00,
                          height: 250.00,
                          decoration:  const BoxDecoration(
                          image:  DecorationImage(
                              image:  ExactAssetImage('assets/images/qrcode.jpg'),
                              fit: BoxFit.scaleDown,
                              ),
                          )),
                          loading ?  CircularProgressIndicator() : Container(),
                          Text(estado, style: estadoId ==1 ? TextStyle(color: Colors.red) : TextStyle(color: Colors.green) ,),
                        ElevatedButton(
                            onPressed: () => scanQR(),
                            child: const Text('Iniciar Scan QRCode')),
                        // ElevatedButton(
                        //     onPressed: () => startBarcodeScanStream(),
                        //     child: Text('Start barcode scan stream')),
                        
                        status == 0 ?
                         Container(
                           child: Text('Faça o scan do recibo',
                              style: TextStyle(fontSize: 18)),
                         ):
                        Column(
                          children: [
                            Container(
                           child: Text('Recibo # $barcode',
                              style: TextStyle(fontSize: 18)),
                         ),
                            barcode != '-1' ? ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 27, 230, 37)),
                                ),
                              onPressed: (){
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(builder: (context) =>  SellsDetails(id:int.parse(barcode) )),
                                // );
                              }, 
                              child: const Text('Clique aqui para ver')) : Container()
                            
                          ],
                        )
                      ]))

      
         
            
  
          ],
        ),
      ),
    );
  }
}




