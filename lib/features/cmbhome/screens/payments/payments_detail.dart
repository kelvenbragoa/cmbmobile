
import 'package:cmbapp/common/custom_shapes/containers/primary_head_container.dart';
import 'package:cmbapp/common/widgets/search_container.dart';
import 'package:cmbapp/common/widgets/section_heading.dart';
import 'package:cmbapp/common/widgets/vertical_image_text.dart';
import 'package:cmbapp/data/repositories/api_response.dart';
import 'package:cmbapp/data/repositories/dashboard.dart';
import 'package:cmbapp/data/repositories/licence_model.dart';
import 'package:cmbapp/data/repositories/payment_model.dart';
import 'package:cmbapp/data/services/payment_service.dart';
import 'package:cmbapp/features/cmbhome/screens/payments/payments_location.dart';
import 'package:cmbapp/features/cmbhome/screens/payments/widgets/payments_detail_app_bar.dart';
import 'package:cmbapp/features/cmbhome/screens/profile/widgets/form_menu.dart';
import 'package:cmbapp/utils/constants/api_constants.dart';
import 'package:cmbapp/utils/constants/colors.dart';
import 'package:cmbapp/utils/constants/image_strings.dart';
import 'package:cmbapp/utils/constants/sizes.dart';
import 'package:cmbapp/utils/constants/text_strings.dart';
import 'package:cmbapp/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:printing/printing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;


class PaymentsDetailsScreen extends StatefulWidget {
  int id;
  PaymentsDetailsScreen({super.key, required this.id});

  @override
  State<PaymentsDetailsScreen> createState() => _PaymentsDetailsScreenState();
}

class _PaymentsDetailsScreenState extends State<PaymentsDetailsScreen> {
    List<dynamic> _paymentList = [];
  List<dynamic> _paymentListSearch = [];
  TextEditingController controller = TextEditingController(text: '');




  bool _loadingbutton = false;
  late int paymentid;
  bool _loading = true;
  late PaymentModel payment;
 

  
 Future<void> retrievePayment()async{

    ApiResponse response = await getPayment(widget.id);

    setState(() {
      paymentid = widget.id;
    }); 
  
      setState(() {
        _paymentList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
      payment = _paymentList[0];
     
     
   
    if(response.error == null){
      setState(() {
        _paymentList = response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
        
      });
      payment = _paymentList[0];
    
    }
    else if(response.error == APIConstants.serverError){
      // logout().then((value)  {
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      // });
    }
    else{
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}')));
    } 

  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrievePayment();
  }

  @override
  Widget build(BuildContext context){
    var number = NumberFormat.currency(name: 'MZN');
    bool dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TPrimaryHeaderContainer(
              size: 150,
              child: Column(
               children: [
                TPaymentsDetailsAppBar(),
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
                      'Pagamentos',
                      style: Theme.of(context).textTheme.headlineSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    _loading ?  const CircularProgressIndicator(
                            backgroundColor: TColors.primary,
                          ) : IconButton(
                      onPressed: (){
                        Get.to(PaymentsLocationScreen(latitude:double.parse(payment.latitude) , longitude: double.parse(payment.longitude) ,));
                      },
                      icon:const Icon(Iconsax.map))
                  ],
                ),
            ),
               const SizedBox(
                height: TSizes.spaceBetwItems,
              ),

             _loading ? const Padding(
      
            padding: EdgeInsets.all(8),
    
                      child: Center(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: TColors.primary,
                          ),
                          Text('Carregando...')
                        ],
                      )),
                    ) : 
                 Column(
                  children: [
                     
                      Padding(
                      padding: EdgeInsets.all(8.0),
                      child:  Center(
                        child: Image(image: AssetImage(dark ? TImages.lightAppLogo : TImages.darkAppLogo),height: 50, width: 50,)
                      ),
                      ),
                      Padding(
                      padding: EdgeInsets.all(8.0),
                      child:  Center(
                        child: Text('EMRICH',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      ),
                      Padding(
                      padding: EdgeInsets.all(8.0),
                      child:  Center(
                        child: Text('Empresa Municipal do Rio Chiveve',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      ),
                      Divider(),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('**Nuit: 500005688**',style: const TextStyle(fontSize: 12),),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('**Data: ${DateFormat('MMM d, HH:mm ').format(DateTime.parse(payment.createdAt))}**',style: const TextStyle(fontSize: 12),),
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text('**Criado por: ${payment.firstName} ${payment.lastName}**',style: const TextStyle(fontSize: 12),),
                        ),
                      ),
                      Divider(),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Nome: ${payment.title}',style: const TextStyle(fontSize: 12),),
                        ),
                      ),
                       Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Dados: ${payment.obs}',style: const TextStyle(fontSize: 12),),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Descrição: ${payment.name}',style: const TextStyle(fontSize: 12),),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Valor: ${number.format(double.parse(payment.amount.toString()))}',style: const TextStyle(fontSize: 12),),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Qtd: ${payment.quantity}',style: const TextStyle(fontSize: 12),),
                        ),
                      ),
                       Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Total: ${number.format(double.parse(payment.total.toString()))}',style: const TextStyle(fontSize: 12),),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Metodo: ${payment.method}',style: const TextStyle(fontSize: 12),),
                        ),
                      ),
                      Divider(),
                      const Center(
                              child: Text('**Obrigado**',style: TextStyle(fontSize: 16)),
                            ),
                            Center(
                              child: SizedBox(
                                height: 100,
                                child: SfBarcodeGenerator(
                                    value: '${payment.uuid}',
                                    symbology: QRCode(),
                                  ),
                              ),
                            ),
                            Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              _createPdf(payment);
                            },
                            child: const Text('Imprimir',),
                          ),
                          const SizedBox(height: 20,),
                          
                        ],
                      ),
                    ),

                      
                       
                        
                  ],
                )
         
            
  
          ],
        ),
      ),
    );
  }

    /// create PDF & print it
  Future<void> _createPdf(PaymentModel payment) async {
    
    final doc = pw.Document();

    final image = await imageFromAssetBundle(TImages.darkAppLogo);
    /// for using an image from assets
    // final image = await imageFromAssetBundle('assets/image.png');
    
    var number = NumberFormat.currency(name: 'MZN');
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.roll80,
        build: (pw.Context context) {
          return pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [

            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Container(
              
            child: pw.Image(image,height: 50, width: 50,),
              )
            ),
            pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('EMRICH',style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
                  ),
              ),
              pw.Align(
                  alignment: pw.Alignment.topCenter,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('EMPRESA MUNICIPAL',style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
                  ),
              ),
            pw.Align(
                  alignment: pw.Alignment.topCenter,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('DO RIO CHIVEVE',style: pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
                  ),
              ),
            // pw.Padding(
            //   padding: const pw.EdgeInsets.all(8),
            //   child: pw.Center(
            // child: pw.Text('MUNICIPIO DA BEIRA',style:  pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
            //   )
            // ),
            // pw.Padding(
            //   padding: const pw.EdgeInsets.all(8),
            //   child: pw.Center(
            // child: pw.Text('CONSELHO MUNICIPAL DA BEIRA',style:  pw.TextStyle(fontSize: 16,fontWeight: pw.FontWeight.bold),),
            //   )
            // ),
             pw.Divider(),
             pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text('**Nuit: 500005688**',style:  pw.TextStyle(fontSize: 12)),
              )
            ),
            pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text(' **Data: ${DateFormat('MMM d, HH:mm ').format(DateTime.parse(payment.createdAt))}**',style:  pw.TextStyle(fontSize: 12)),
              )
            ),
             pw.Padding(
              padding: const pw.EdgeInsets.all(8),
              child: pw.Center(
            child: pw.Text('**Criado por: ${payment.firstName} ${payment.lastName}**',style:  pw.TextStyle(fontSize: 12)),
              )
            ),
            pw.Divider(),
            pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('Nome: ${payment.title}',style: const pw.TextStyle(fontSize: 12),),
                  ),
              ),
              pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Padding(
                  padding: const pw.EdgeInsets.all(8.0),
                        child: pw.Text('Dados: ${payment.obs}',style: const pw.TextStyle(fontSize: 12),),
                  ),
              ),
            pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('Descrição: ${payment.name}',style: const pw.TextStyle(fontSize: 12),),
                  ),
              ),

            pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('Valor: ${number.format(double.parse(payment.amount.toString()))}',style: const pw.TextStyle(fontSize: 12),),
                  ),
              ),
               pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('Qtd: ${payment.quantity}',style: const pw.TextStyle(fontSize: 12),),
                  ),
              ),
              pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('Total: ${number.format(double.parse(payment.total.toString()))}',style: const pw.TextStyle(fontSize: 12),),
                  ),
              ),
            pw.Align(
                  alignment: pw.Alignment.centerLeft,
                  child: pw.Padding(
                  padding: pw.EdgeInsets.all(8.0),
                        child: pw.Text('Metodo: ${payment.method}',style: const pw.TextStyle(fontSize: 12),),
                  ),
              ),
              pw.Divider(),
            
             pw.Center(
                        child: pw.Text('**Obrigado**',style: pw.TextStyle(fontSize: 16)),
                    ),
            pw.Center(
                child: pw.SizedBox(
                  child: pw. BarcodeWidget(
                    barcode: pw.Barcode.qrCode(
                      errorCorrectLevel: pw.BarcodeQRCorrectionLevel.high,
                    ),
                    data: '${payment.uuid}',
                    width: 100,
                    height: 100,
                  ),
                 
                )
              ),
               pw.SizedBox(height: 5),
              pw.Center(
                child: pw.Text('Beira, Moçambique',style: pw.TextStyle(fontSize: 12)),
              ),
              // pw.Center(
              //   child: pw.Text('+258 842648618',style: pw.TextStyle(fontSize: 12)),
              // ),
              pw.SizedBox(height: 50),
              pw.Center(
                child: pw.Text('***************',style: pw.TextStyle(fontSize: 16)),
              ),


          ]);
        },
      ),
    ); // Page

    /// print the document using the iOS or Android print service:
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());

    /// share the document to other applications:
    // await Printing.sharePdf(bytes: await doc.save(), filename: 'my-document.pdf');

    /// tutorial for using path_provider: https://www.youtube.com/watch?v=fJtFDrjEvE8
    /// save PDF with Flutter library "path_provider":
    // final output = await getTemporaryDirectory();
    // final file = File('${output.path}/example.pdf');
    // await file.writeAsBytes(await doc.save());
  }
}




