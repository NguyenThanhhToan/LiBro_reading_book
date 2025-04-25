import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Libro/models/category_model.dart';
import 'package:Libro/services/api_constants.dart';
import 'package:Libro/services/storage_service.dart';

class CategoryService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  final storageService = StorageService();

  Future<List<Category>> fetchGetCategories() async {

    try {
      String? token = await storageService.getToken();

      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "${ApiConstants.baseUrl}/category",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

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
