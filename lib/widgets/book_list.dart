import 'package:flutter/material.dart';
import 'package:Libro/models/book_model.dart';
import 'package:Libro/widgets/book_shelf_item.dart';

class BookListWidget extends StatelessWidget {
  final List<Book> books;

  const BookListWidget({super.key, required this.books});

  @override
  Widget build(BuildContext context) {
    if (books.isEmpty) {
      return const Center(child: Text("Không có sách nào."));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return BookShelfItem(book: book); // Thay thế bằng BookShelfItem
      },
    );
  }
}
