class RegisterModel {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;
  final String phoneNumber;
  final String dob;

  RegisterModel({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
    required this.dob,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username.trim(),
      "email": email.toLowerCase().trim(),
      "password": password,
      "confirmPassword": confirmPassword,
      "phoneNumber": phoneNumber.replaceAll(RegExp(r'[^0-9]'), ''),
      "dob": dob,
    };
  }

}