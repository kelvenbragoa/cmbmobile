class LicenceModel{
  int id;
  var amount;
  String name;



 


  LicenceModel({
    required this.id,
    required this.amount,
    required this.name,

   
  });


  factory LicenceModel.fromJson(Map<String, dynamic> json){
    return LicenceModel(
      id: json['id'],
      name: json['name'],
      amount: json['amount'],

      
    );
  }
}