  import 'package:dio/dio.dart';
  import 'package:flutter_secure_storage/flutter_secure_storage.dart';
  import '../models/book_model.dart';
  import 'api_constants.dart';

  class BookService {
    final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
    final FlutterSecureStorage _storage = const FlutterSecureStorage();

    Future<List<Book>> fetchSuggestedBooks() async {
  try {
    String? token = await _storage.read(key: 'token');
    if (token == null) throw Exception("Không tìm thấy token!");

    final response = await _dio.get(
      "${ApiConstants.baseUrl}/book/suggested",
      options: Options(headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      }),
    );

    // 📡 Debug: In ra dữ liệu nhận được từ API
    print("📡 API Response: ${response.data}");

    if (response.statusCode == 200) {
      if (response.data["status"] == 200) {
        return Book.fromJsonList(response.data["data"]);
      } else {
        throw Exception("Lỗi từ server: ${response.data['message']}");
      }
    } else {
      throw Exception("Lỗi HTTP: ${response.statusCode}");
    }
  } catch (e) {
    print("🔥 Lỗi khi gọi API: $e");
    return [];
  }
}
}
