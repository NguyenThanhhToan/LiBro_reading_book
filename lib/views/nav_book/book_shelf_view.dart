import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Libro/utils/app_colors.dart';
import 'package:Libro/components/custom_tabbar.dart';
import 'package:Libro/components/custom_navbar.dart';
import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/viewmodels/bookmark_viewmodel.dart';
import 'package:Libro/widgets/book_shelf_item.dart';
import 'package:Libro/widgets/book_mark.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => BookmarkViewModel()..CurrentBook(),
        ),
        ChangeNotifierProvider(
          create: (_) => BookViewModel()
            ..fetchAllBooks()
            ..fetchFavoriteBooks(),
        ),
      ],
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundColor,
            ),
            child: Column(
              children: [
                const SizedBox(height: 22),
                const CustomTabBar(tabs: ['Sách gần đây', 'BST yêu thích']),
                Expanded(
                  child: TabBarView(
                    children: [
                      // Tab "Sách gần đây"
                      Consumer<BookmarkViewModel>(
                        builder: (context, vm, _) {
                          if (vm.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (vm.errorMessage != null) {
                            return Center(child: Text(vm.errorMessage!));
                          } else if (vm.currentBook.isEmpty) {
                            return const Center(child: Text('Chưa có sách nào được đọc gần đây.'));
                          } else {
                            return ListView.builder(
                              itemCount: vm.currentBook.length,
                              itemBuilder: (_, i) {
                                final bookmark = vm.currentBook[i];
                                return BookmarkItem(bookmark: bookmark);
                              },
                            );
                          }
                        },
                      ),
                      // Tab "BST yêu thích"
                      Consumer<BookViewModel>(
                        builder: (context, vm, _) {
                          if (vm.isLoading) {
                            return const Center(child: CircularProgressIndicator());
                          } else if (vm.errorMessage != null) {
                            return Center(child: Text(vm.errorMessage!));
                          } else if (vm.favoriteBooks.isEmpty) {
                            return const Center(child: Text('Không có sách yêu thích nào.'));
                          } else {
                            return ListView.builder(
                              itemCount: vm.favoriteBooks.length,
                              itemBuilder: (_, i) => BookShelfItem(book: vm.favoriteBooks[i]),
                            );
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
