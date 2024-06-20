class DashboardData {
  int today;
  int yesterday;
  int month;
  int year;
 
  DashboardData({
    required this.today,
    required this.year,
    required this.yesterday,
    required this.month,

  });

  factory DashboardData.fromJson(Map<String, dynamic> json){
    return DashboardData(
      today: json['today'],
      yesterday: json['yesterday'],
      month: json['month'],
      year: json['year'],

    );
  }
}