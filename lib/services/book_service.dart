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

  Future<List<Book>> fetchLastedBooks() async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "${ApiConstants.baseUrl}/book/latest",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

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

  Future<List<Book>> fetchFeaturedBooks() async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "${ApiConstants.baseUrl}/book/top-interact",
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

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

    Future<List<Book>> fetchAllBooks() async {
      try {
        final response = await _dio.get(
          "/book", // vì baseUrl đã là http://localhost:8080/api/v1
          options: Options(headers: {
            "Content-Type": "application/json",
          }),
        );

        if (response.statusCode == 200) {
          if (response.data["status"] == 200) {
            final List<dynamic> rawList = response.data["data"]["content"];
            return Book.fromJsonList(rawList);
          } else {
            throw Exception("Lỗi từ server: ${response.data['message']}");
          }
        } else {
          throw Exception("Lỗi HTTP: ${response.statusCode}");
        }
      } catch (e) {
        print("🔥 Lỗi khi gọi API lấy tất cả sách: $e");
        return [];
      }
    }

  Future<List<Book>> fetchBooksByCategories(List<String> categoryNames) async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "/book/search/category",
        queryParameters: {
          'categoryNames': categoryNames, // truyền list như query repeat
        },
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

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
      print("🔥 Lỗi khi gọi API theo danh mục: $e");
      return [];
    }
  }
  Future<List<Book>> fetchBooksByAuthor(List<String> authorNames) async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "/book/search/author",
        queryParameters: {
          'authorNames': authorNames,
        },
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

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
      print("🔥 Lỗi khi gọi API theo tác giả: $e");
      return [];
    }
  }
  Future<List<Book>> fetchBookByTittle(List<String> title) async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "/book/search/title",
        queryParameters: {
          'title': title,
        },
        options: Options(headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        }),
      );

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
      print("🔥 Lỗi khi gọi API theo tên sách: $e");
      return [];
    }
  }
}
