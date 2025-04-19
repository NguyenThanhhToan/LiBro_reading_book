import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/widgets/book_item.dart';
import 'package:Libro/utils/app_colors.dart';

class BooksByCategoryScreen extends StatefulWidget {
  final String categoryName;

  const BooksByCategoryScreen({super.key, required this.categoryName});

  @override
  State<BooksByCategoryScreen> createState() => _BooksByCategoryScreenState();
}

class _BooksByCategoryScreenState extends State<BooksByCategoryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BookViewModel>(context, listen: false)
          .fetchBooksByCategories([widget.categoryName]);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookVM = Provider.of<BookViewModel>(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.backgroundColor,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: const BackButton(color: Colors.black),
          title: Text(
            widget.categoryName,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: bookVM.isLoading
              ? const Center(child: CircularProgressIndicator())
              : bookVM.categoryBooks.isEmpty
              ? const Center(
            child: Text(
              "Không tìm thấy sách nào trong danh mục này.",
              style: TextStyle(fontSize: 16),
            ),
          )
              : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.6,
            ),
            itemCount: bookVM.categoryBooks.length,
            itemBuilder: (context, index) {
              final book = bookVM.categoryBooks[index];
              return BookItem(book);
            },
          ),
        ),
      ),
    );
  }
}
