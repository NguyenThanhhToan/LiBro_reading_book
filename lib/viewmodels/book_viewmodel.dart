import 'package:flutter/material.dart';
import 'package:Libro/app/app_snackbar.dart';
import 'package:Libro/models/book_model.dart';
import 'package:Libro/services/book_service.dart';

class BookViewModel extends ChangeNotifier {
  final BookService _bookService = BookService();
  List<Book> _suggestedBooks = [];
  List<Book> _lastedBooks = [];
  List<Book> _featuredBooks = [];
  List<Book> _categoryBooks = [];
  List<Book> _authorBooks = [];
  List<Book> _tittleBooks = [];
  List<Book> _favoriteBooks = []; // ✅ Thêm dòng này
  List<Book> topViewedBooks = [];
  List<Book> topLikedBooks = [];


  bool _isLoading = false;
  String? _errorMessage;

  List<Book> get suggestBooks => _suggestedBooks;

  List<Book> get lastedBooks => _lastedBooks;

  List<Book> get featuredBooks => _featuredBooks;

  List<Book> get categoryBooks => _categoryBooks;

  List<Book> get authorBooks => _authorBooks;

  List<Book> get tittleBooks => _tittleBooks;

  List<Book> get favoriteBooks => _favoriteBooks; // ✅ Getter

  bool get isLoading => _isLoading;

  String? get errorMessage => _errorMessage;

  Future<void> SuggestedBooks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _suggestedBooks = await _bookService.fetchSuggestedBooks();
    } catch (e) {
      _errorMessage = "Lỗi tải danh sách sách: $e";
      _suggestedBooks = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> LastedBooks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _lastedBooks = await _bookService.fetchLastedBooks();
    } catch (e) {
      _errorMessage = "Lỗi tải danh sách sách: $e";
      _lastedBooks = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> FeaturedBooks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _featuredBooks = await _bookService.fetchFeaturedBooks();
    } catch (e) {
      _errorMessage = "Lỗi tải danh sách sách: $e";
      _featuredBooks = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksByCategories(List<String> categoryNames) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _categoryBooks = await _bookService.fetchBooksByCategories(categoryNames);

      if (_categoryBooks.isEmpty) {
        _errorMessage = "Không tìm thấy sách thuộc danh mục đã chọn.";
      }
    } catch (e) {
      _categoryBooks = [];
      _errorMessage = "Lỗi khi tải sách theo danh mục: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksByAuthor(List<String> authorNames) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _authorBooks = await _bookService.fetchBooksByAuthor(authorNames);

      if (_authorBooks.isEmpty) {
        _errorMessage = "Không tìm thấy sách của tác giả đã chọn.";
      }
    } catch (e) {
      _authorBooks = [];
      _errorMessage = "Lỗi khi tải sách theo tác giả: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchBooksByTittle(List<String> title) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _tittleBooks = await _bookService.fetchBookByTittle(title);

      if (_tittleBooks.isEmpty) {
        _errorMessage = "Không tìm thấy sách.";
      }
    } catch (e) {
      _tittleBooks = [];
      _errorMessage = "Lỗi khi tải sách: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchAllBooks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _lastedBooks = await _bookService.fetchAllBooks();
      if (_lastedBooks.isEmpty) {
        _errorMessage = "Không tìm thấy sách.";
      }
    } catch (e) {
      _lastedBooks = [];
      _errorMessage = "Lỗi khi tải sách: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  // ✅ Thêm hàm lấy sách yêu thích
  Future<void> fetchFavoriteBooks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _favoriteBooks = await _bookService.fetchFavoriteBooks();

      if (_favoriteBooks.isEmpty) {
        _errorMessage = "Không có sách yêu thích nào.";
      }
    } catch (e) {
      _favoriteBooks = [];
      _errorMessage = "Lỗi khi tải sách yêu thích: $e";
    }

    _isLoading = false;
    notifyListeners();
  }

  bool isFavorite(Book book) {
    return _favoriteBooks.any((b) => b.bookId == book.bookId);
  }
  //hàm goi top-view
  Future<void> fetchTopViewedBooks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      topViewedBooks = await _bookService.fetchTopViewedBooks();
      if (topViewedBooks.isEmpty) {
        _errorMessage = "Không có sách nhiều lượt xem.";
      }
    } catch (e) {
      topViewedBooks = [];
      _errorMessage = "Lỗi khi tải sách nhiều lượt xem: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
  Future<void> toggleFavorite(BuildContext context, bool isInFavorite,
      int bookId) async {
    try {
      bool success = isInFavorite
          ? await _bookService.removeBookFromFavorite(bookId)
          : await _bookService.addBookToFavorite(bookId);

      if (success) {
        _errorMessage = "Thao tác thành công!";
        notifyListeners();
        AppSnackbar.showSuccess(context, _errorMessage!);
      } else {
        _errorMessage = "Lỗi khi thao tác với yêu thích.";
        notifyListeners();
        AppSnackbar.showSuccess(context, _errorMessage!);
      }
    } catch (e) {
      _errorMessage = "Lỗi khi thao tác với yêu thích: $e";
      notifyListeners();
      AppSnackbar.showSuccess(context, _errorMessage!);
    }
  }
  Future<void> fetchTopLikedBooks() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      topLikedBooks = await _bookService.fetchTopLikedBooks();
      if (topLikedBooks.isEmpty) {
        _errorMessage = "Không có sách nhiều lượt thích.";
      }
    } catch (e) {
      topLikedBooks = [];
      _errorMessage = "Lỗi khi tải sách nhiều lượt thích: $e";
    }

    _isLoading = false;
    notifyListeners();
  }
}