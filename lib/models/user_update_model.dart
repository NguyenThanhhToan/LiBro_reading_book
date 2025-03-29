class UserUpdateModel {
  final String userName;
  final String phoneNumber;
  final String dob;

  UserUpdateModel({
    required this.userName,
    required this.phoneNumber,
    required this.dob,
  });

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "phoneNumber": phoneNumber,
      "dob": dob,
    };
  }
}
