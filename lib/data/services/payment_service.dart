import 'dart:convert';
import 'package:cmbapp/data/repositories/api_response.dart';
import 'package:cmbapp/data/repositories/licence_model.dart';
import 'package:cmbapp/data/repositories/payment_model.dart';
import 'package:cmbapp/data/services/user_services.dart';
import 'package:cmbapp/utils/constants/api_constants.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;


Future<ApiResponse> getAllPayments() async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<PaymentModel> paymentList =[];


  try{
    

    final response = await http.get(
      Uri.parse('${APIConstants.paymentsURL}/${UserService.userProfile.id}'),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['payments'];

    

    


   
     
    


    if(values.length>0){
     
        for(int i=0;i<values.length;i++){
           
          if(values[i]!=null){
            Map<String,dynamic> map=values[i];
            paymentList.add(PaymentModel.fromJson(map));
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
       
        apiResponse.data = paymentList;
       
        apiResponse.data as List<dynamic>;
       
        
       

        //funcional
         //data = jsonDecode(response.body)['categories'];
         //funcional

      
        
       
        break;
      
      case 401:
       
       apiResponse.error = APIConstants.serverError;
       break;


      default:
      apiResponse.error = APIConstants.serverError;
    }
  }catch (e){
    

    apiResponse.error = APIConstants.serverError;
  }
//funcional
  //return data;\

  return apiResponse;
}


Future<ApiResponse> getPayment(id) async {

//funional
  ApiResponse apiResponse = ApiResponse();
  var data;
  List<PaymentModel> paymentList =[];



  try{
    
    
  
    final response = await http.get(
      Uri.parse('${APIConstants.paymentURL}/$id'),
      headers: {'Accept':'application/json',
     }
    );

    var values = jsonDecode(response.body)['payment'];


     
    


    if(values.length>0){

      
        for(int i=0;i<values.length;i++){
          
          if(values[i]!=null){
           
            Map<String,dynamic> map=values[i];
            
            paymentList.add(PaymentModel.fromJson(map));

           
          }}
    }
    

       
 
     

    switch (response.statusCode) {
      case 200:
      // apiResponse.data = Category.fromJson(jsonDecode(response.body));
        // apiResponse.data = jsonDecode(response.body)['categories'].map((p) => Category.fromJson(p)).toList();
        // we get list of posts, so we need to map each item to post model
        apiResponse.data = paymentList;
        apiResponse.data as List<dynamic>;
        
       

        //funcional
         //data = jsonDecode(response.body)['categories'];
         //funcional

      
        
       
        break;
      
      case 401:
       
       apiResponse.error = APIConstants.serverError;
       break;


      default:
      apiResponse.error = APIConstants.serverError;
    }
  }catch (e){
    

    apiResponse.error = APIConstants.serverError;

  }
//funcional
  //return data;\

  return apiResponse;
}





Future<ApiResponse> createPayment(int userid, int payment_id, String title, String obs, String method, String quantity) async {
  

  

ApiResponse apiResponse = ApiResponse();
  try {
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
   
    final response = await http.post(
      Uri.parse(APIConstants.paymentCreateURL),
      headers: {
      'Accept': 'application/json',
      
    }, body: {
      'user_id': '$userid',
      'licence_id': '$payment_id',
      'title': title,
      'obs': obs,
      'latitude': '${position.latitude}',
      'longitude':  '${position.longitude}',
      'method':  method,
      'quantity':  quantity,

    } );




    

    
    

    switch(response.statusCode){
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        // apiResponse.error = errors[errors.keys.elementAt(0)][0];
        apiResponse.error = errors.toString();
        break;
      case 401:
        apiResponse.error = APIConstants.serverError;
        break;
      default:
        apiResponse.error = APIConstants.serverError;
        break;
    }
  }
  catch (e){
    apiResponse.error = APIConstants.serverError;
  }
  return apiResponse;
}



