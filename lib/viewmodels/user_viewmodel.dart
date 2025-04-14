import 'package:Libro/models/user_update_model.dart';
import 'package:flutter/material.dart';
import '../models/user_changepassword_model.dart';
import '../models/user_model.dart';
import '../services/user_service.dart';
import '../views/auth/login_screen.dart';
import '../views/nav_user/otp_forgot.dart';

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

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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

  Future<void> changePassword(
      String oldPass,
      String newPass,
      String confirmPass,
      BuildContext context,
      ) async {
    // ✅ Kiểm tra dữ liệu đầu vào
    if (oldPass.isEmpty) {
      _showSnackBar(context, 'Vui lòng nhập mật khẩu cũ');
      return;
    }
    if (newPass.length < 6) {
      _showSnackBar(context, 'Mật khẩu mới phải có ít nhất 6 ký tự');
      return;
    }
    if (newPass != confirmPass) {
      _showSnackBar(context, 'Mật khẩu xác nhận không khớp');
      return;
    }

    try {
      final model = UserChangepasswordModel(
        oldPassword: oldPass,
        newPassword: newPass,
        confirmPassword: confirmPass,
      );

      final response = await _service.changePassword(model);

      if (response.status == 200) {
        _showSnackBar(context, response.message);
      } else {
        _showSnackBar(context, "Lỗi: ${response.message}");
      }
    } catch (e) {
      _showSnackBar(context, "Lỗi: $e");
    }
  }
  Future<void> forgotPassword(String email, BuildContext context) async {
    if (email.isEmpty) {
      _showSnackBar(context, 'Vui lòng nhập email');
      return;
    }

    try {
      final response = await _service.forgotPassword(email);

      if (response.status == 200) {
        _showSnackBar(context, response.message);
        String id = '';
        if (response.data != null && response.data is String) {
          final dataString = response.data as String;
          if (dataString.startsWith("Id: ")) {
            id = dataString.substring(4).trim();
          } else {
            print("Data does not start with 'Id: '");
          }
        } else {
          print("Data is null or not a string");
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpForgot(
              id: id,
              email: email,
            ),
          ),
        );
      } else {
        _showSnackBar(context, "Lỗi: ${response.message}");
      }
    } catch (e) {
      _showSnackBar(context, "Lỗi: $e");
    }
  }

  Future<void> confirmForgotPassword(String id, String otpCode, BuildContext context) async {
    // Kiểm tra OTP không rỗng
    if (otpCode.isEmpty) {
      _showSnackBar(context, 'Vui lòng nhập mã OTP');
      return;
    }

    try {
      // Gọi API xác nhận OTP và truyền id và otpCode làm tham số
      final response = await _service.confirmForgotPassword(id, otpCode);

      if (response.status == 200) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        _showSnackBar(context, response.message); // Hiển thị thông báo thành công
      } else {
        _showSnackBar(context, "Lỗi: ${response.message}"); // Hiển thị thông báo lỗi
      }
    } catch (e) {
      _showSnackBar(context, "Lỗi: $e");
    }
  }
}
