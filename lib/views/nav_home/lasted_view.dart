import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/book_viewmodel.dart';

class LatestScreen extends StatefulWidget {
  const LatestScreen({super.key});

  @override
  _LatestScreenState createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    Future.microtask(() {
      Provider.of<BookViewModel>(context, listen: false).fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    var bookViewModel = Provider.of<BookViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Danh sách sách mới nhất")),
      backgroundColor: Colors.transparent,
      body: bookViewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : bookViewModel.books.isEmpty
              ? Center(
                  child: Text(
                    bookViewModel.errorMessage ?? "⚠️ Không có sách nào được trả về.",
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: bookViewModel.books.length,
                  itemBuilder: (context, index) {
                    var book = bookViewModel.books[index];
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text(
                          book.title,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(book.authorName),
                      ),
                    );
                  },
                ),
    );
  }
}
