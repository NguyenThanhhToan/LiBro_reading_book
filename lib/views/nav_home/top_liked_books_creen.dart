import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/widgets/book_item.dart'; // Đảm bảo import BookItem

class TopLikedBooksScreen extends StatefulWidget {
  const TopLikedBooksScreen({super.key});

  @override
  State<TopLikedBooksScreen> createState() => _TopLikedBooksScreenState();
}

class _TopLikedBooksScreenState extends State<TopLikedBooksScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BookViewModel>(context, listen: false).fetchTopLikedBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookViewModel = Provider.of<BookViewModel>(context);
    final topLikedBooks = bookViewModel.topLikedBooks;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE3A7FF), Color(0xFFA0EACF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    "Sách nhiều lượt thích",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              /// Trạng thái Loading / Lỗi / Danh sách
              if (bookViewModel.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (bookViewModel.errorMessage != null)
                Center(child: Text(bookViewModel.errorMessage!))
              else
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: topLikedBooks.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final book = topLikedBooks[index];
                      return BookItem(book);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
