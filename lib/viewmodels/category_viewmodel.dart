import 'package:flutter/material.dart';
import '../models/category_model.dart';
import '../services/category_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  List<Category> categories = [];
  bool isLoading = false;

  // ✅ Hàm lấy danh mục
  Future<void> fetchCategories() async {
    print("🔍 fetchCategories() đã được gọi");
    isLoading = true;
    notifyListeners();

    categories = await _categoryService.fetchGetCategories();
    print("📌 Số danh mục lấy được: ${categories.length}");

    isLoading = false;
    notifyListeners();
  }

}
