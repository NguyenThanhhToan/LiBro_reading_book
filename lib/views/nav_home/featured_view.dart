import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/widgets/book_item.dart';

class FeaturedScreen extends StatefulWidget {
  @override
  _FeaturedBooksScreenState createState() => _FeaturedBooksScreenState();
}

class _FeaturedBooksScreenState extends State<FeaturedScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookViewModel>(context, listen: false).FeaturedBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookViewModel = context.watch<BookViewModel>(); // ✅ Theo dõi trạng thái

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            // 🔥 Kiểm tra trạng thái để hiển thị Loading, Lỗi, hoặc Danh sách sách
            if (bookViewModel.isLoading)
              Center(child: CircularProgressIndicator()) // Hiển thị khi đang tải

            else if (bookViewModel.errorMessage != null)
              Center(child: Text(bookViewModel.errorMessage!)) // Hiển thị lỗi

            else
              SizedBox(
                width: double.infinity,
                child: Wrap(
                  spacing: -4.5,
                  runSpacing: 10,
                  children: bookViewModel.featuredBooks
                      .map((book) => BookItem(book)) // ✅ Hiển thị danh sách từ API
                      .toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

