import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:Libro/services/api_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class VipService {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,
    connectTimeout: const Duration(seconds: 30),
  ));

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<bool> registerVip({required int time, required int amount}) async {
    try {
      final token = await _storage.read(key: 'token');
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.post(
        "/vip",
        queryParameters: {"time": time},
        data: {"amount": amount},
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
            "Accept": "application/json",
          },
        ),
      );

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is! Map<String, dynamic>) {
          throw Exception('Dữ liệu response không hợp lệ');
        }

        if (responseData['status'] == 200) {
          final rawData = responseData['data'];
          final data = rawData is String ? jsonDecode(rawData) : rawData;

          final payUrl = data['payUrl']?.toString();

          if (payUrl == null || payUrl.isEmpty) {
            throw Exception('Không tìm thấy URL thanh toán');
          }

          return await launchUrl(
            Uri.parse(payUrl),
            mode: LaunchMode.externalApplication,
          );
        } else {
          throw Exception('Lỗi từ server: ${responseData['message']}');
        }
      }

      throw Exception('Lỗi không mong muốn: ${response.statusCode}');
    } on DioException catch (e) {
      print("Lỗi kết nối API: ${e.message}");
      return false;
    } catch (e) {
      print("Lỗi không xác định: $e");
      return false;
    }
  }
}
