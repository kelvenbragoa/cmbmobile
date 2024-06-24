class PaymentModel{
  int id;
  var amount;
  var total;
  var quantity;
  String name;
  String title;
  String obs;
  String createdAt;
  String firstName;
  String lastName;
  String latitude;
  String longitude;
  String method;
  String uuid;
  int status;



 


  PaymentModel({
    required this.id,
    required this.amount,
    required this.name,
    required this.title,
    required this.obs,
    required this.createdAt,
    required this.firstName,
    required this.lastName,
    required this.latitude,
    required this.longitude,
    required this.method,
    required this.total,
    required this.quantity,
    required this.uuid,
    required this.status



   
  });


  factory PaymentModel.fromJson(Map<String, dynamic> json){
    return PaymentModel(
      id: json['id'],
      name: json['fee']['name'],
      amount: json['amount'],
      total: json['total'],
      quantity: json['quantity'],
      title: json['title'],
      obs: json['obs'],
      method: json['method'],
      createdAt: json['created_at'],
      firstName: json['user']['first_name'],
      lastName: json['user']['last_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      status: json['status'],
      uuid: json['uuid']
    );
  }
}