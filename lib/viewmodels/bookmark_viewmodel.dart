import 'package:Libro/models/bookmark_model.dart';
import 'package:flutter/material.dart';
import '../services/bookmark_service.dart';

class BookmarkViewModel extends ChangeNotifier {
  final BookmarkService _bookmarkService = BookmarkService();
  List<Bookmark> _currentBooks = [];

  bool _isLoading = false;
  String? _errorMessage;

  List<Bookmark> get currentBook => _currentBooks;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> CurrentBook() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _currentBooks = await _bookmarkService.fetchCurrentBooks();
    } catch (e) {
      _errorMessage = "Lỗi tải danh sách sách: $e";
      _currentBooks = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> addBookmark(int page, int bookId) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      bool success = await _bookmarkService.fetchAddBookmark(page, bookId);
      if (success) {
        print("Bookmark đã được thêm thành công.");
      } else {
        _errorMessage = "Không thể thêm bookmark.";
      }
    } catch (e) {
      _errorMessage = "Lỗi khi thêm bookmark: $e";
    }

    _isLoading = false;
    notifyListeners();
    return _errorMessage == null;
  }
}