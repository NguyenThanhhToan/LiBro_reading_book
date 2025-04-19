import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Libro/models/category_model.dart';
import 'package:Libro/services/api_constants.dart';

class CategoryService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<List<Category>> fetchGetCategories() async {
    print("🟢 Đang gọi API: ${ApiConstants.baseUrl}/category");

    try {
      String? token = await _storage.read(key: 'token');
      print("🔑 Token: $token"); // In token để kiểm tra

      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "${ApiConstants.baseUrl}/category",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

      print("📡 API Response: ${response.data}");

      if (response.statusCode == 200) {
        return Category.fromJsonList(response.data["data"]);
      } else {
        throw Exception("Lỗi từ server: ${response.data['message']}");
      }
    } catch (e) {
      print("🔥 Lỗi khi gọi API: $e");
      return [];
    }
  }

}
