
import 'package:cmbapp/common/custom_shapes/containers/primary_head_container.dart';
import 'package:cmbapp/common/widgets/search_container.dart';
import 'package:cmbapp/common/widgets/section_heading.dart';
import 'package:cmbapp/common/widgets/vertical_image_text.dart';
import 'package:cmbapp/data/repositories/api_response.dart';
import 'package:cmbapp/data/repositories/dashboard.dart';
import 'package:cmbapp/data/repositories/licence_model.dart';
import 'package:cmbapp/data/services/home_service.dart';
import 'package:cmbapp/data/services/user_services.dart';
import 'package:cmbapp/features/cmbhome/screens/fees/fees.dart';
import 'package:cmbapp/features/cmbhome/screens/fees/fees_detail.dart';
import 'package:cmbapp/features/cmbhome/screens/home/widgets/dashboard_card.dart';
import 'package:cmbapp/navigation_menu.dart';
import 'package:cmbapp/utils/constants/api_constants.dart';
import 'package:cmbapp/utils/constants/colors.dart';
import 'package:cmbapp/utils/constants/sizes.dart';
import 'package:cmbapp/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'widgets/home_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

    List<dynamic> homeDashboard = [];
    List<dynamic> licenceDashboard = [];
    bool _loading = true;
    late DashboardData home;
    late LicenceModel licence;

    Future<void> retrieveData()async{

    
  
    List<ApiResponse> response = await getHomeData(UserService.userProfile.id);
   



   

    if(response[0].error == null){
      setState(() {
        homeDashboard = response[0].data as List<dynamic>;
        home = homeDashboard[0];

        licenceDashboard = response[1].data as List<dynamic>;

         _loading = _loading ? !_loading : _loading;

      });



  

    }else if(response[0].error == APIConstants.serverError){
      // logout().then((value)  {
      //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>const LoginPage()), (route) => false);
      // });
    }else{
      
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('${response[0].error}')));
    } 

    

   

  }

  void initState() {
    // TODO: implement initState
     retrieveData();
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
               children: [
                const THomeAppBar(),
                const SizedBox(height: TSizes.spaceBetwSections,),
                GestureDetector(
                  onTap: (){
                    Get.to(NavigationMenu());
                  },
                  child: const TSearchContainer(text: "Procurar",)),
                const SizedBox(height: TSizes.spaceBetwSections,),
                Padding(
                  padding: EdgeInsets.only(left: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      const TSectionHeading(title: "Principais Taxas",showActionButton: false,textColor: TColors.white,),
                      const SizedBox(height: TSizes.spaceBetwItems,),
                      //categorias
                      SizedBox(
                        height: 80,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: licenceDashboard.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_,index){
                            LicenceModel licence = licenceDashboard[index];
                            return  TVerticalImageText(
                              title: licence.name,
                              onTap: (){
                                Get.to(FeesDetailScreen(id: licence.id));
                              },);
                          },
                          
                          ),
                      )
                      
                    ],
                  ),
                  )
               ],
              )
            ),
            _loading ? const Padding(padding: EdgeInsets.all(8),
                      child: Center(child: Column(
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: TColors.primary,
                          ),
                          Text(TText.pleaseWait)
                          
                        ],
                      )),
                    ) : Column(
              children: [
            DashboardCard(
              title: 'Taxas Cobradas Hoje', 
              amount: home.today.toDouble(),),
            DashboardCard(
              title: 'Taxas Cobradas Ontem', 
              amount: home.yesterday.toDouble(),),
            
            DashboardCard(
              title: 'Taxas Cobradas Mês', 
              amount: home.month.toDouble(),),

            DashboardCard(
              title: 'Taxas Cobradas Ano', 
              amount: home.year.toDouble(),)
              ],
            )
            
  
          ],
        ),
      ),
    );
  }
}




