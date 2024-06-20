class UserData {
  int id;
  String firstName;
  String lastName;
  String mobile;
  String email;
  String code;
  var today;
  var yesterday;
  var month;
  var year;


  UserData({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.mobile,
    required this.email,
    required this.code,
    required this.today,
    required this.year,
    required this.yesterday,
    required this.month,

  });


  factory UserData.fromJson(Map<String, dynamic> json){
    return UserData(
      id: json['user']['id'],
      firstName: json['user']['first_name'],
      lastName: json['user']['last_name'],
      mobile: json['user']['mobile'],
      email: json['user']['email'],
      code: json['user']['code'],
      today: json['dashboard']['today'],
      yesterday: json['dashboard']['yesterday'],
      month: json['dashboard']['month'],
      year: json['dashboard']['year'],

    );
  }
}