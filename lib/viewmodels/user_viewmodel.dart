import 'package:Libro/models/user_update_model.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserViewmodel extends ChangeNotifier {
  final UserService _service = UserService();

  String userName = "";
  String email = "";
  String phoneNumber = "";
  String dob = "";

  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  // hàm lấy user info
  Future<void> fetchUserInfo() async {
    try {
      UserInfoModel user = await _service.fetchUserInfo();
      userName = user.userName;
      email = user.email;
      phoneNumber = user.phoneNumber;
      dob = user.dob;

      // Cập nhật giá trị của TextEditingController
      userNameController.text = userName;
      emailController.text = email;
      phoneController.text = phoneNumber;
      dobController.text = dob;

      notifyListeners();
    } catch (e) {
      print("Lỗi: $e");
    }
  }

  // 🆕 Hàm Update thông tin khi nhấn "Gửi"
  Future<void> updateUserInfo() async {
    try {
      UserUpdateModel updatedUser = UserUpdateModel(
        userName: userNameController.text.isNotEmpty ? userNameController.text : userName,
        phoneNumber: phoneController.text.isNotEmpty ? phoneController.text : phoneNumber,
        dob: dobController.text.isNotEmpty ? dobController.text : dob, // giữ giá trị cũ nếu không nhập mới
      );

      await _service.updateUserInfo(updatedUser);

      // Cập nhật lại dữ liệu hiển thị
      userName = updatedUser.userName;
      phoneNumber = updatedUser.phoneNumber;
      dob = updatedUser.dob;

      notifyListeners();
    } catch (e) {
      print("Lỗi cập nhật thông tin: $e");
    }
  }
}