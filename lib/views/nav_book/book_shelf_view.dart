import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Libro/utils/app_colors.dart';
import 'package:Libro/components/custom_tabbar.dart';
import 'package:Libro/components/custom_navbar.dart';
import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/viewmodels/bookmark_viewmodel.dart';
import 'package:Libro/widgets/book_shelf_item.dart';
import 'package:Libro/widgets/book_mark.dart';

class BookShelfScreen extends StatefulWidget {
  final int initialTabIndex;
  const BookShelfScreen({super.key, this.initialTabIndex = 0});

  @override
  State<BookShelfScreen> createState() => _BookShelfScreenState();
}

class _BookShelfScreenState extends State<BookShelfScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    int safeIndex = (widget.initialTabIndex >= 0 && widget.initialTabIndex < 2)
        ? widget.initialTabIndex
        : 0;
    _tabController = TabController(length: 2, vsync: this, initialIndex: safeIndex);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
      child: Scaffold(
        body: SafeArea(
          child: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundColor,
            ),
            child: Column(
              children: [
                const SizedBox(height: 12),
                CustomTabBar(
                  tabs: const ['Sách gần đây', 'BST yêu thích'],
                  controller: _tabController,
                ),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
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
                              padding: const EdgeInsets.all(10),
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
                              padding: const EdgeInsets.all(10),
                              itemCount: vm.favoriteBooks.length,
                              itemBuilder: (_, i) =>
                                  BookShelfItem(book: vm.favoriteBooks[i]),
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
        ),
        bottomNavigationBar: const CustomNavBar(currentIndex: 1),
      ),
    );
  }
}
