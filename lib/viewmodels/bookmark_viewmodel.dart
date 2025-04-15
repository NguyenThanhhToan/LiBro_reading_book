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
}