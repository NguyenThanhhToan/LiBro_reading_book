import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/widgets/book_item.dart';
import 'package:Libro/utils/app_colors.dart';

class BooksTopLikeScreen extends StatefulWidget {

  const BooksTopLikeScreen({super.key});

  @override
  State<BooksTopLikeScreen> createState() => _BooksByCategoryScreenState();
}

class _BooksByCategoryScreenState extends State<BooksTopLikeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BookViewModel>(context, listen: false)
          .fetchTopViewBooks();
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
            "Sách nhiều lượt xem nhất",
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          child: bookVM.isLoading
              ? const Center(child: CircularProgressIndicator())
              : bookVM.topViewBooks.isEmpty
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
            itemCount: bookVM.topViewBooks.length,
            itemBuilder: (context, index) {
              final book = bookVM.topViewBooks[index];
              return BookItem(book);
            },
          ),
        ),
      ),
    );
  }
}
