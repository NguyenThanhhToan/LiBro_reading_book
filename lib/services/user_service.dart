import 'package:Libro/models/user_update_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user_model.dart';
import '../services/api_constants.dart';

class UserService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // hàm get user Info
  Future<UserInfoModel> fetchUserInfo() async {
    try {
      String? token = await _storage.read(key: 'token');
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
      String? token = await _storage.read(key: 'token');
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
}