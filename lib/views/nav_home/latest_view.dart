import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/widgets/book_item.dart';

class LatestScreen extends StatefulWidget {
  @override
  _LatestScreenState createState() => _LatestScreenState();
}

class _LatestScreenState extends State<LatestScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookViewModel>(context, listen: false).LastedBooks();
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
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    double itemWidth = 120.0;
                    double spacing = 10.0;
                    int count = (constraints.maxWidth / (itemWidth + spacing)).floor();
                    double calculatedSpacing = (constraints.maxWidth - (itemWidth * count)) / (count - 1);
                    return Wrap(
                      spacing: calculatedSpacing,
                      runSpacing: 10,
                      children: bookViewModel.featuredBooks
                          .map((book) => SizedBox(
                                width: itemWidth,
                                child: BookItem(book),
                              ))
                          .toList(),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}

