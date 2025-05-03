import 'package:dio/dio.dart';
import 'package:Libro/models/book_model.dart';
import 'package:Libro/services/api_constants.dart';
import 'package:Libro/services/storage_service.dart';

class BookService {
  final Dio _dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));
  final storageService = StorageService();

  Future<List<Book>> fetchSuggestedBooks() async {
    try {
      String? token = await storageService.getToken();
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
      String? token = await storageService.getToken();
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
      String? token = await storageService.getToken();
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
          "/book",
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
      String? token = await storageService.getToken();
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
      String? token = await storageService.getToken();
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
      String? token = await storageService.getToken();
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
        String? token = await storageService.getToken();
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
      String? token = await storageService.getToken();
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
      String? token = await storageService.getToken();
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

  Future<List<Book>> fetchBooksTopView() async {
    try {
      String? token = await storageService.getToken();
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "/book/search/top-viewed",
        queryParameters: {
          "limit": 10,
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

  Future<List<Book>> fetchBooksTopLike() async {
    try {
      String? token = await storageService.getToken();
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.get(
        "/book/search/top-liked",
        queryParameters: {
          "limit": 100,
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

  Future<bool> fetchLikeBook(int bookId) async {
    try {
      String? token = await storageService.getToken();
      if (token == null) throw Exception("Không tìm thấy token!");

      final response = await _dio.patch(
        "${ApiConstants.baseUrl}/book/like/$bookId",
        options: Options(
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/x-www-form-urlencoded",
          },
        ),
      );

      if (response.statusCode == 200) {
        if (response.data["status"] == 200) {
          print(" Like thành công ");
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
  Future<Book?> fetchBookById(int bookId) async {
  try {
    String? token = await _storage.read(key: 'token');
    if (token == null) throw Exception("Không tìm thấy token!");

    final response = await _dio.get(
      "${ApiConstants.baseUrl}/book/$bookId",
      options: Options(
        headers: {
          "Authorization": "Bearer $token",
          "Content-Type": "application/json",
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      return Book.fromJson(data['data']);
    } else {
      throw Exception("Lỗi HTTP: ${response.statusCode}");
    }
  } catch (e) {
    print("🔥 Lỗi khi gọi API fetchBookById: $e");
    return null;
  }
}

}
