import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../services/book_service.dart';

class BookViewModel extends ChangeNotifier {
  final BookService _bookService = BookService();
  List<Book> _suggestedBooks = [];
  List<Book> _lastedBooks = [];
  List<Book> _featuredBooks =[];
  List<Book> _categoryBooks = [];
  List<Book> _authorBooks = [];
  List<Book> _tittleBooks = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<Book> get suggestBooks => _suggestedBooks;
  List<Book> get lastedBooks => _lastedBooks;
  List<Book> get featuredBooks => _featuredBooks;
  List<Book> get categoryBooks => _categoryBooks;
  List<Book> get authorBooks => _authorBooks;
  List<Book> get tittleBooks => _tittleBooks;

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
}
