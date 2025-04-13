import 'package:Libro/models/user_update_model.dart';
import 'package:flutter/material.dart';
import '../models/user_changepassword_model.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';

class UserViewmodel extends ChangeNotifier {
  final UserService _service = UserService();

  String userName = "";
  String email = "";
  String phoneNumber = "";
  String dob = "";

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
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
      usernameController.text = userName;
      emailController.text = email;
      phoneNumberController.text = phoneNumber;
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
        userName: usernameController.text.isNotEmpty ? usernameController.text : userName,
        phoneNumber: phoneNumberController.text.isNotEmpty ? phoneNumberController.text : phoneNumber,
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

  // Hàm đổi mật khẩu nhận các giá trị từ UI và BuildContext để xử lý giao diện
  Future<void> changePasswordWithValues(
      String oldPass,
      String newPass,
      String confirmPass,
      BuildContext context,
      ) async {
    try {
      final model = UserChangepasswordModel(
        oldPassword: oldPass,
        newPassword: newPass,
        confirmPassword: confirmPass,
      );

      final response = await _service.changePassword(model);

      if (response.status == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Lỗi: ${response.message}")),
        );
      }
    } catch (e) {
      // Handle any exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Lỗi: $e")),
      );
    }
  }

}
