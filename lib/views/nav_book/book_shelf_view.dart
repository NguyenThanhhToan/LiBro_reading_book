import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Libro/utils/app_colors.dart';
import 'package:Libro/components/custom_tabbar.dart';
import 'package:Libro/components/custom_navbar.dart';
import 'package:Libro/widgets/book_list.dart';
import 'package:Libro/viewmodels/book_viewmodel.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BookViewModel()
        ..fetchAllBooks()
        ..fetchFavoriteBooks(),
      child: DefaultTabController(
        length: 2, // Chỉnh lại chỉ còn 2 tab như bạn đang dùng
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundColor,
            ),
            child: Column(
              children: [
                const SizedBox(height: 22),
                const CustomTabBar(tabs: [
                  'Sách', 'BST yêu thích',
                ]),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Tab "Sách" - hiển thị dữ liệu từ API
                      Consumer<BookViewModel>(
                        builder: (context, viewModel, _) {
                          if (viewModel.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (viewModel.errorMessage != null) {
                            return Center(child: Text(viewModel.errorMessage!));
                          } else {
                            return BookListWidget(books: viewModel.lastedBooks);
                          }
                        },
                      ),
                      // Tab "BST yêu thích" (hiện tại để tạm)
                      Consumer<BookViewModel>(
                        builder: (context, viewModel, _) {
                          if (viewModel.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (viewModel.errorMessage != null) {
                            return Center(child: Text(viewModel.errorMessage!));
                          } else {
                            return BookListWidget(books: viewModel.favoriteBooks);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const CustomNavBar(currentIndex: 1),
        ),
      ),
    );
  }
}
