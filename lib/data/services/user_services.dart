
// register
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cmbapp/utils/constants/api_constants.dart';
import '../repositories/api_response.dart';
import '../repositories/user.dart';


class UserService{


static UserData userProfile = UserData(id: 0, firstName: '', lastName: '', mobile: '', email: '',code: '',today: '', yesterday: '', month: '',year: '');


Future<ApiResponse> loginUser (String email, String password) async {

  print('iniciando chamada de login');


  ApiResponse apiResponse = ApiResponse();
  try{
    final response = await http.post(
      Uri.parse(APIConstants.loginURL),
      headers: {'Accept':'application/json'},
      body: {
        'email':email,
        'password':password
      }
    );

    print(response.body);

    

    




    switch (response.statusCode) {
      case 200:
        apiResponse.data = UserData.fromJson(jsonDecode(response.body));
        break;
      
      case 422:
       final errors = jsonDecode(response.body)['errors'];
      //  apiResponse.error = errors[errors.keys.elementAt(0)[0]];
       apiResponse.error = errors.toString();
       break;

      case 403:
      apiResponse.error = jsonDecode(response.body)['message'];
      break;

      default:
      apiResponse.error = APIConstants.serverError;
    }
  }catch (e){

    
    apiResponse.error = APIConstants.serverError;
    print(e);
  
  }

  return apiResponse;
}



Future<ApiResponse> registerUser (String firstName,String lastName, String email, String mobile, String password) async {

  
  ApiResponse apiResponse = ApiResponse();

  try{
    final response = await http.post(
      Uri.parse(APIConstants.registerURL),
      headers: {'Accept':'application/json'},
      body: {
        'first_name':firstName,
        'last_name':lastName,
        'email':email,
        'mobile':mobile,
        'password':password,
        'password_confirmation':password,
        'pro_start_timestamp':'0',
        'pro_end_timestamp':'0',
        'lp_start_timestamp':'0',
        'lp_end_timestamp':'0',

      }
    );

    print(response.body);



    switch (response.statusCode) {
      case 200:
        apiResponse.data = UserData.fromJson(jsonDecode(response.body));
        
        break;
      
      case 422:
       
       final errors = jsonDecode(response.body)['errors'];

       apiResponse.error = errors.toString();
      

       
       break;

      case 403:
      apiResponse.error = jsonDecode(response.body)['message'];
      
      break;

      default:
      apiResponse.error = APIConstants.serverError;
    }
  }catch (e){
    print(e);
    apiResponse.error = APIConstants.serverError;
  }

  return apiResponse;
}

}