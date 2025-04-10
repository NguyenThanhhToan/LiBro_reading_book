import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/widgets/book_shelf_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_tabbar.dart';
import '../../components/custom_navbar.dart';
import '../../widgets/search_bar.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> with TickerProviderStateMixin {
  late final TabController _tabController;
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _onSearch(String keyword) {
    final viewModel = Provider.of<BookViewModel>(context, listen: false);
    final trimmed = keyword.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      searchQuery = trimmed;
    });

    final selectedIndex = _tabController.index;

    switch (selectedIndex) {
      case 0:
        viewModel.fetchBooksByTittle([trimmed]);
        break;
      case 1:
        viewModel.fetchBooksByAuthor([trimmed]);
        break;
      case 2:
        viewModel.fetchBooksByCategories([trimmed]);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            SearchBarWidget(onSubmitted: _onSearch),
            CustomTabBar(tabs: const ['Sách', 'Tác giả', 'Danh mục'], controller: _tabController),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  Consumer<BookViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (viewModel.tittleBooks.isEmpty) {
                        return const Center(child: Text("Tìm kiếm theo tên sách."));
                      }
                      return ListView.builder(
                        itemCount: viewModel.tittleBooks.length,
                        itemBuilder: (context, index) {
                          final book = viewModel.tittleBooks[index];
                          return BookShelfItem(book: book);
                        },
                      );
                    },
                  ),
                  Consumer<BookViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (viewModel.authorBooks.isEmpty) {
                        return const Center(child: Text("Tìm kiếm theo tác giả."));
                      }
                      return ListView.builder(
                        itemCount: viewModel.authorBooks.length,
                        itemBuilder: (context, index) {
                          final book = viewModel.authorBooks[index];
                          return BookShelfItem(book: book);
                        },
                      );
                    },
                  ),
                  Consumer<BookViewModel>(
                    builder: (context, viewModel, child) {
                      if (viewModel.isLoading) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (viewModel.categoryBooks.isEmpty) {
                        return const Center(child: Text("Tìm kiếm theo danh mục"));
                      }
                      return ListView.builder(
                        itemCount: viewModel.categoryBooks.length,
                        itemBuilder: (context, index) {
                          final book = viewModel.categoryBooks[index];
                          return BookShelfItem(book: book);
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomNavBar(currentIndex: 2),
    );
  }
}
