import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../services/book_service.dart';

class BookViewModel extends ChangeNotifier {
  final BookService _bookService = BookService();
  List<Book> _suggestedBooks = [];
  List<Book> _lastedBooks = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<Book> get suggestBooks => _suggestedBooks;
  List<Book> get lastedBooks => _lastedBooks;
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
}
