import 'dart:async';

import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:Libro/views/auth/otp_screen.dart';
import 'package:Libro/views/auth/login_screen.dart';
import 'package:Libro/views/nav_home/home_view.dart';
class AuthViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';
  Map<String, String?> errors = {};

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setError(String key, String? message) {
    if (message == null) {
      errors.remove(key);
    } else {
      errors[key] = message;
    }
    notifyListeners();
  }
  Future<void> logout(BuildContext context) async {
    setLoading(true);
    try {
      bool result = await _authService.logout();
      if (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("✅ Đăng xuất thành công")),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => LoginScreen()),
              (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("❌ Đăng xuất thất bại")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("⚠️ Lỗi: ${e.toString()}")),
      );
    } finally {
      setLoading(false);
    }
  }

  bool _validateInputs() {
    errors.clear();
    if (usernameController.text.isEmpty) setError('username', "Tên không được để trống.");
    if (phoneNumberController.text.isEmpty) {
      setError('phoneNumber', "Số điện thoại không được để trống.");
    } else if (!RegExp(r'^\d{10}$').hasMatch(phoneNumberController.text)) {
      setError('phoneNumber', "Số điện thoại không hợp lệ.");
    }
    if (emailController.text.isEmpty) {
      setError('email', "Email không được để trống.");
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
      setError('email', "Email không hợp lệ.");
    }
    if (dobController.text.isEmpty) setError('dob', "Ngày sinh không được để trống.");
    if (passwordController.text.isEmpty) setError('password', "Mật khẩu không được để trống.");
    if (confirmPasswordController.text.isEmpty) {
      setError('confirmPassword', "Xác nhận mật khẩu không được để trống.");
    } else if (passwordController.text != confirmPasswordController.text) {
      setError('confirmPassword', "Mật khẩu không khớp.");
    }
    return errors.isEmpty;
  }

  Future<void> register(BuildContext context) async {
    if (!_validateInputs()) return;

    setLoading(true);

    try {
      int? userId = await _authService.register(
        username: usernameController.text,
        phoneNumber: phoneNumberController.text,
        email: emailController.text,
        dob: dobController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text,
      );

      if (userId != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Đăng ký thành công! Vui lòng nhập OTP")),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OtpScreen(userId: userId.toString(), email: emailController.text),
          ),
        );
      }
    } catch (e) {
      setError('general', e.toString().replaceFirst("Exception: ", ""));
    } finally {
      setLoading(false);
    }
  }
}

class OtpViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final TextEditingController otpController = TextEditingController();

  bool isLoading = false;
  String errorMessage = '';

  int countdown = 60;
  Timer? _timer;

  OtpViewModel() {
    startCountdown();
  }

  void startCountdown() {
    countdown = 60;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (countdown > 0) {
        countdown--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    startCountdown();
    print("OTP đã được gửi lại!");
  }

  void setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void setError(String message) {
    errorMessage = message;
    notifyListeners();
  }

  Future<void> verifyOtp(BuildContext context, String userId) async {
    if (otpController.text.isEmpty) {
      setError("Vui lòng nhập mã OTP");
      return;
    }

    setLoading(true);

    try {
      bool success = await _authService.confirmOtp(userId: userId, otpCode: otpController.text);

      print("✅ Kết quả xác thực OTP: $success");

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("✅ Xác thực OTP thành công! Vui lòng đăng nhập.")),
        );

        await Future.delayed(Duration(seconds: 1));

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        setError("⚠️ Mã OTP không hợp lệ!");
      }
    } catch (e) {
      setError("⚠️ Lỗi hệ thống: ${e.toString()}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("❌ ${e.toString()}")),
      );
    } finally {
      setLoading(false);
    }
  }


}

class LoginViewModel extends ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> login(BuildContext context, String email, String password) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      var result = await _authService.login(email: email, password: password);
      if (result) {
        _isLoading = false;
        notifyListeners();

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeView()),
        );
        return true;
      } else {
        _isLoading = false;
        _errorMessage = "Đăng nhập thất bại. Vui lòng kiểm tra lại!";
        notifyListeners();
        return false; //
      }
    } catch (e) {
      _isLoading = false;
      _errorMessage = "Lỗi: ${e.toString()}";
      notifyListeners();
      return false;
    }
  }

}