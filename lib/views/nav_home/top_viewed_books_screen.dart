import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/widgets/book_item.dart'; // Đảm bảo import BookItem

class TopViewedBooksScreen extends StatefulWidget {
  const TopViewedBooksScreen({super.key});

  @override
  State<TopViewedBooksScreen> createState() => _TopViewedBooksScreenState();
}

class _TopViewedBooksScreenState extends State<TopViewedBooksScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<BookViewModel>(context, listen: false).fetchTopViewedBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bookViewModel = Provider.of<BookViewModel>(context);
    final topViewedBooks = bookViewModel.topViewedBooks;

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
                    "Sách nhiều lượt xem",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              /// Loading / Error / List state
              if (bookViewModel.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (bookViewModel.errorMessage != null)
                Center(child: Text(bookViewModel.errorMessage!))
              else
                Expanded(
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: topViewedBooks.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final book = topViewedBooks[index];
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
