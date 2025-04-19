import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Libro/viewmodels/category_viewmodel.dart';
import 'package:Libro/utils/app_colors.dart';
import 'package:Libro/views/nav_home/books_by_category_screen.dart';


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CategoryViewModel>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Nền gradient
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundColor,
      ),
      child: Scaffold(
        // Đặt Scaffold nền trong suốt để thấy gradient
        backgroundColor: Colors.transparent,

        // Không dùng AppBar => nội dung nằm sát TabBar
        body: Consumer<CategoryViewModel>(builder: (context, categoryViewModel, child) {
          if (categoryViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (categoryViewModel.categories.isEmpty) {
            return const Center(
              child: Text("Không có danh mục nào!"),
            );
          }

          // Hiển thị 2 cột, mỗi ô là 1 danh mục
          return GridView.builder(
            // Tùy chỉnh padding để căn lề sát TabBar
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            itemCount: categoryViewModel.categories.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,        // 2 ô ngang
              mainAxisSpacing: 12,      // Khoảng cách giữa các hàng
              crossAxisSpacing: 12,     // Khoảng cách giữa các cột
              childAspectRatio: 3.5,    // Tỉ lệ chiều rộng / chiều cao (2.0 = rộng gấp đôi cao)
            ),
            itemBuilder: (context, index) {
              final category = categoryViewModel.categories[index];
              return GestureDetector(
                onTap: () {
                  // Điều hướng sang màn hình BooksByCategoryScreen khi nhấn vào danh mục
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BooksByCategoryScreen(
                        categoryName: category.categoryName,
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.secondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    category.categoryName,
                    style: const TextStyle(
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
