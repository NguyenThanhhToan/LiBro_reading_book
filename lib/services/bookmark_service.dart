import 'package:dio/dio.dart';
import 'package:Libro/models/bookmark_model.dart';
import 'package:Libro/services/api_constants.dart';
import 'package:Libro/services/storage_service.dart';

class BookmarkService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  final storageService = StorageService();

  Future<List<Bookmark>> fetchCurrentBooks() async {
    try {
      String? token = await storageService.getToken();
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "${ApiConstants.baseUrl}/book/bookmark/me",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );
      
      if (response.statusCode == 200) {
        if (response.data["status"] == 200) {
          return Bookmark.fromJsonList(response.data["data"]);
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

  Future<bool> fetchAddBookmark(int page, int bookId) async {
    try {
      String? token = await storageService.getToken();
      if (token == null) throw Exception("Không tìm thấy token!");

      final data = {
        "bookId": bookId,
        "page": page,
      };

      // Gửi yêu cầu POST
      final response = await _dio.post(
        "${ApiConstants.baseUrl}/book/bookmark/add",
        data: data, // Gửi dữ liệu vào body
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json",
          },
        ),
      );
      
      if (response.statusCode == 200) {
        if (response.data["status"] == 200) {
          print("✅ Lưu vị trí đang đọc thành công");
          return true;
        } else {
          throw Exception("Lỗi từ server: ${response.data['message']}");
        }
      } else {
        throw Exception("Lỗi HTTP: ${response.statusCode}");
      }
    } catch (e) {
      print("🔥 Lỗi khi gọi API: $e");
      return false;
    }
  }

}
