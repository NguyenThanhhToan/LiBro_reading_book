class UserChangepasswordModel {
  final String oldPassword;
  final String newPassword;
  final String confirmPassword;

  UserChangepasswordModel({
    required this.oldPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      "oldPassword": oldPassword,
      "newPassword": newPassword,
      "confirmPassword": confirmPassword,
    };
  }
}
