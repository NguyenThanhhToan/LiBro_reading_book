import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Libro/services/api_constants.dart';

class NotificationService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> sendFcmTokenToServer(String fcmToken) async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token == null) throw Exception("Không tìm thấy token đăng nhập!");

      final response = await _dio.post(
        "/notification/fcm-token",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
        data: {
          "token": fcmToken,
        },
      );

      if (response.statusCode == 200) {
        print("✅ Gửi FCM token thành công.");
      } else {
        print("⚠️ Lỗi khi gửi FCM token: ${response.statusCode}");
      }
    } catch (e) {
      print("🔥 Lỗi khi gửi FCM token: $e");
    }
  }
}