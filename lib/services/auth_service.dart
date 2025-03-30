import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'api_constants.dart';
class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "${ApiConstants.baseUrl}/auth"));
  final FlutterSecureStorage _storage = FlutterSecureStorage();

  Future<int?> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
    required String phoneNumber,
    required String dob,
  }) async {
    try {
      Response response = await _dio.post(
        "/register",
        data: {
          "username": username,
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
          "phoneNumber": phoneNumber,
          "dob": dob,
        },
      );

      if (response.statusCode == 200) {
        print("Phản hồi từ server: ${response.data}");

        // Kiểm tra xem phản hồi có chứa "data" hay không
        if (response.data.containsKey('data')) {
          String dataString = response.data['data']; // "Id: 9"
          int? id = int.tryParse(dataString.replaceAll(RegExp(r'[^0-9]'), ''));
          return id;
        }
      }
      return null;
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode == 400) {
          String errorMessage = e.response?.data['message'] ?? "Lỗi đăng ký!";
          print("Lỗi đăng ký: $errorMessage");
          throw Exception(errorMessage); // Ném lỗi để hiển thị trên UI
        }
      }
      print("Lỗi kết nối: ${e.message}");
      throw Exception("Không thể kết nối đến máy chủ!");
    }
  }

  Future<bool> confirmOtp({required String userId, required String otpCode}) async {
    try {
      final response = await _dio.post(
        "/confirm/$userId",
        data: {"otpCode": otpCode},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print("Phản hồi từ API: ${response.data}"); // 🛠 Debug phản hồi API

      // Kiểm tra nếu response.data không phải Map, ép kiểu
      final Map<String, dynamic> responseData = response.data is Map<String, dynamic>
          ? response.data
          : Map<String, dynamic>.from(response.data);

      if (response.statusCode == 200 && responseData["status"] == 200) {
        return true;
      } else {
        throw Exception(responseData["message"] ?? "Mã OTP không hợp lệ!");
      }
    } catch (e) {
      print("Lỗi xác thực OTP: $e");
      throw Exception("Lỗi hệ thống: ${e.toString()}");
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      final response = await _dio.post(
        "/login",
        data: {"email": email, "password": password},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print("📩 Phản hồi đăng nhập: ${response.data}"); // 🛠 Debug API

      if (response.statusCode == 200 && response.data["status"] == 200) {
        String token = response.data["data"]["token"];
        await _saveToken(token);
        return true; // Đăng nhập thành công
      } else {
        return false; // Đăng nhập thất bại
      }
    } catch (e) {
      print("🔥 Lỗi đăng nhập: $e");
      return false;
    }
  }

  // ✅ Lưu token vào Secure Storage
  Future<bool> _saveToken(String token) async {
    try {
      await _storage.write(key: 'token', value: token);
      return true;
    } catch (e) {
      print("⚠️ Lỗi lưu token: $e");
      return false;
    }
  }

  // ✅ Lấy token từ Secure Storage
  Future<String?> getToken() async {
    try {
      return await _storage.read(key: 'token');
    } catch (e) {
      print("⚠️ Lỗi lấy token: $e");
      return null;
    }
  }

}
