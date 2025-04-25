import 'package:Libro/models/user_changepassword_model.dart';
import 'package:Libro/models/user_update_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Libro/models/http_response.dart';
import 'package:Libro/models/user_model.dart';
import 'package:Libro/services/api_constants.dart';
import 'package:Libro/services/storage_service.dart';

class UserService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  final storageService = StorageService();

  // hàm get user Info
  Future<UserInfoModel> fetchUserInfo() async {
    try {
      String? token = await storageService.getToken();
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "/user/me",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );
      return UserInfoModel.fromJson(response.data['data']);
    } catch (e) {
      throw Exception("Lỗi lấy thông tin người dùng: $e");
    }
  }

  // 🆕 Hàm cập nhật thông tin người dùng
  Future<void> updateUserInfo(UserUpdateModel user) async {
    try {
      String? token = await storageService.getToken();
      if (token == null) throw Exception("Không tìm thấy token!");

      await _dio.put(
        "/user",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
        data: {
          "userName": user.userName,
          "phoneNumber": user.phoneNumber,
          "dob": user.dob,
        },
      );
    } catch (e) {
      throw Exception("Lỗi cập nhật thông tin người dùng: $e");
    }
  }

  Future<HttpResponse> changePassword(UserChangepasswordModel user) async {
    try {
      String? token = await storageService.getToken();
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.patch(
        "/user/change-password",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
        data: {
          "oldPassword": user.oldPassword,
          "newPassword": user.newPassword,
          "confirmPassword": user.confirmPassword,
        },
      );

      if (response.statusCode == 200) {
        // Return success message if password change is successful
        return HttpResponse(
          status: 200,
          message: 'Đổi mật khẩu thành công!',
        );
      } else {
        // Return failure message with status if password change fails
        return HttpResponse(
          status: response.statusCode ?? 500,
          message: response.statusMessage ?? 'Lỗi không xác định',
        );
      }
    } catch (e) {
      throw Exception("Lỗi cập nhật mật khẩu: $e");
    }
  }
  Future<HttpResponse> forgotPassword(String email) async {
    try {
      final response = await _dio.post(
        "/auth/forgot",
        data: {
          "email": email,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        return HttpResponse(
          status: 200,
          message: response.data["message"],
          data: response.data["data"],
        );
      } else {
        return HttpResponse(
          status: response.statusCode ?? 500,
          message: response.statusMessage ?? 'Lỗi không xác định',
        );
      }
    } catch (e) {
      throw Exception("Lỗi khi gọi API quên mật khẩu: $e");
    }
  }
  Future<HttpResponse> confirmForgotPassword(String id, String otpCode) async {
    try {
      final response = await _dio.post(
        "/auth/confirm-forgot/$id",  // Đảm bảo đường dẫn chứa id
        data: {
          "otpCode": otpCode,  // Gửi OTP làm tham số
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
          },
        ),
      );
      print("Response: ${response.data}");
      if (response.statusCode == 200) {
        return HttpResponse(
          status: 200,
          message: response.data["message"],
        );
      } else {
        return HttpResponse(
          status: response.statusCode ?? 500,
          message: response.statusMessage ?? 'Lỗi không xác định',
        );
      }
    } catch (e) {
      throw Exception("Lỗi khi gọi API xác nhận OTP: $e");
    }
  }

}