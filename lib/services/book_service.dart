import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:Libro/models/book_model.dart';
import 'package:Libro/services/api_constants.dart';


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
    Future<List<Book>> fetchFavoriteBooks() async {
      try {
        String? token = await _storage.read(key: 'token');
        if (token == null) throw Exception("Không tìm thấy token!");

        final response = await _dio.get(
          "/book/favorite",
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
        print("🔥 Lỗi khi gọi API sách yêu thích: $e");
        return [];
      }
    }
  Future<bool> addBookToFavorite(int bookId) async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.post(
        "${ApiConstants.baseUrl}/book/favorite/add/$bookId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data["status"] == 200) {
          print("✅ Thêm sách vào yêu thích thành công!");
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

  Future<bool> removeBookFromFavorite(int bookId) async {
    try {
      String? token = await _storage.read(key: 'token');
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.post(
        "${ApiConstants.baseUrl}/book/favorite/remove/$bookId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data["status"] == 200) {
          print("✅ Thêm sách vào yêu thích thành công!");
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
    Future<List<Book>> fetchTopViewedBooks() async {
      try {
        final response = await _dio.get('${ApiConstants.baseUrl}/book/search/top-viewed');
        print('Status code: ${response.statusCode}');
        print('Raw response: ${response.data}');

        if (response.statusCode == 200) {
          if (response.data is Map<String, dynamic> && response.data['data'] is List) {
            final List<dynamic> data = response.data['data'];
            return data.map((json) => Book.fromJson(json)).toList();
          } else {
            throw Exception('Phản hồi API không đúng định dạng mong đợi.');
          }
        } else {
          throw Exception('Lỗi server: ${response.statusCode}');
        }
      } catch (e) {
        print('Lỗi khi gọi API Top-viewed: $e');
        throw Exception('Không thể tải danh sách top-view');
      }
    }
    Future<List<Book>> fetchTopLikedBooks() async {
      try {
        final response = await _dio.get('${ApiConstants.baseUrl}/book/search/top-liked');
        print('Status code: ${response.statusCode}');
        print('Raw response: ${response.data}');

        if (response.statusCode == 200) {
          if (response.data is Map<String, dynamic> && response.data['data'] is List) {
            final List<dynamic> data = response.data['data'];
            return data.map((json) => Book.fromJson(json)).toList();
          } else {
            throw Exception('Phản hồi API không đúng định dạng mong đợi.');
          }
        } else {
          throw Exception('Lỗi server: ${response.statusCode}');
        }
      } catch (e) {
        print('Lỗi khi gọi API Top-liked: $e');
        throw Exception('Không thể tải danh sách sách nhiều lượt thích');
      }
    }
  }
