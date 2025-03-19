import 'package:dio/dio.dart';

class AuthService {
  final Dio _dio = Dio(BaseOptions(baseUrl: "http://10.0.2.2:8080/api/v1/auth"));

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

  Future<Map<String, dynamic>?> login({required String email, required String password}) async {
    try {
      final response = await _dio.post(
        "/login",
        data: {"email": email, "password": password},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      print("📩 Phản hồi đăng nhập: ${response.data}"); // 🛠 Debug phản hồi API

      if (response.statusCode == 200 && response.data["status"] == 200) {
        return {
          "userId": response.data["data"]["id"],
          "token": response.data["data"]["token"],
          "userName": response.data["data"]["userName"],
        };
      } else {
        return null;
      }
    } catch (e) {
      print("🔥 Lỗi đăng nhập: $e");
      return null;
    }
  }


}
