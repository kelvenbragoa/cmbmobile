
import 'package:cmbapp/common/custom_shapes/containers/primary_head_container.dart';
import 'package:cmbapp/common/widgets/search_container.dart';
import 'package:cmbapp/common/widgets/section_heading.dart';
import 'package:cmbapp/common/widgets/vertical_image_text.dart';
import 'package:cmbapp/data/repositories/api_response.dart';
import 'package:cmbapp/data/repositories/dashboard.dart';
import 'package:cmbapp/data/repositories/licence_model.dart';
import 'package:cmbapp/data/repositories/payment_model.dart';
import 'package:cmbapp/data/services/home_service.dart';
import 'package:cmbapp/data/services/licence_service.dart';
import 'package:cmbapp/data/services/payment_service.dart';
import 'package:cmbapp/data/services/user_services.dart';
import 'package:cmbapp/features/authentication/screens/onboarding/onboarding.dart';
import 'package:cmbapp/features/cmbhome/screens/home/widgets/dashboard_card.dart';
import 'package:cmbapp/features/cmbhome/screens/payments/payments_detail.dart';
import 'package:cmbapp/features/cmbhome/screens/payments/widgets/payments_app_bar.dart';
import 'package:cmbapp/features/cmbhome/screens/profile/widgets/form_menu.dart';
import 'package:cmbapp/utils/constants/api_constants.dart';
import 'package:cmbapp/utils/constants/colors.dart';
import 'package:cmbapp/utils/constants/sizes.dart';
import 'package:cmbapp/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
    List<dynamic> _paymentList = [];
  List<dynamic> _paymentListSearch = [];
  TextEditingController controller = TextEditingController(text: '');




  bool _loading = true;
 

  
  
  Future<void> retrieveAllPayments()async{

 

    
    ApiResponse response = await getAllPayments();
  
      setState(() {
        
        _paymentList = response.data as List<dynamic>;
        _paymentListSearch= response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });
     
     
   
    if(response.error == null){
      setState(() {
        _paymentList = response.data as List<dynamic>;
        _paymentListSearch= response.data as List<dynamic>;
        _loading = _loading ? !_loading : _loading;
      });

    }
    else if(response.error == APIConstants.serverError){
      // logout().then((value)  {
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>LoginPage()), (route) => false);
      // });
    }
    else{
      
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response.error}'),
  //       action: SnackBarAction(
  //       label: 'Undo',
  //       onPressed: () {
  //         // Some code to undo the change.
  //         ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //       },
  // ),
        ));
    } 

   
   
  

    

  }

void _runFilter(String enteredKeyword) {
    List<dynamic> results = [];

    
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _paymentListSearch;
    } else {
      

     
      results = _paymentListSearch
          .where((product){
            
            return product.name.toLowerCase().contains(enteredKeyword.toLowerCase()) || product.amount.toString().contains(enteredKeyword);
            // return ticket.id.toString().contains(enteredKeyword);
           
          })
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // results = _allUsers
    //       .where((user) =>
    //           user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
    //       .toList();
      // we use the toLowerCase() method to make it case-insensitive

    // Refresh the UI
    setState(() {
      _paymentList = results;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    retrieveAllPayments();
  }

  @override
  Widget build(BuildContext context){
    var number = NumberFormat.currency(name: 'MZN');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
          children: [
            const TPrimaryHeaderContainer(
              size: 125,
              child: Column(
               children: [
                TPaymentsAppBar(),
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
                    )
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
                    Container(
                          margin: const EdgeInsets.all(4),
                          child: TextField(
                            controller: controller,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Iconsax.search_normal),
                              hintText: 'Pagamentos',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: const BorderSide(color: Color.fromARGB(255, 76, 175, 163))
                              )
                            ),
                            onChanged: _runFilter,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(2),
                          alignment: Alignment.bottomLeft,
                          child: Text('Resultados: ${_paymentList.length}')
                        ),
                        SizedBox(
                          height: 380,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,

                            itemCount: _paymentList.length,
                            itemBuilder: (BuildContext context, int index){
                              PaymentModel payment = _paymentList[index];
                              String formattedDate = DateFormat('MMM d, HH:mm ').format(DateTime.parse(payment.createdAt));
                              return 
                                ListTile(
                                  onTap: (){
                                    Get.to(PaymentsDetailsScreen(id: payment.id));
                                  },
                                  leading: CircleAvatar(
                                    backgroundColor: TColors.primary,
                                    child: Text('${index+1}'),
                                  ),
                                  title: Text(payment.name),
                                  subtitle: Text('${number.format(double.parse(payment.amount.toString()))} - $formattedDate'),
                                  trailing: const Icon(Icons.more_vert),
                                );
                            }
                            ),
                        )
                        
                  ],
                )
         
            
  
          ],
        ),
    );
  }
}




