class UserInfoModel {
  final String userName;
  final String email;
  final String phoneNumber;
  final String dob;

  UserInfoModel({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.dob,
  });

  factory UserInfoModel.fromJson(Map<String, dynamic> json) {
    return UserInfoModel(
      userName: json['userName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      dob: json['dob'],
    );
  }
}
