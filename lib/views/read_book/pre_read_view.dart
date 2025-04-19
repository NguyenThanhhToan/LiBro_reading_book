import 'dart:io';

import 'package:flutter/material.dart';
import '../../models/book_model.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/read_pdf_viewmodel.dart';
import '../../viewmodels/book_viewmodel.dart';
import 'pdf_screen.dart';
import '../../services/api_constants.dart';

class PreReadView extends StatelessWidget {
  final Book book;
  final int? initialPage;
  final int? fromBookmarkId;

  const PreReadView({
    Key? key,
    required this.book,
    this.initialPage,
    this.fromBookmarkId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookViewModel>(
      create: (_) => BookViewModel()..fetchFavoriteBooks(),
      child: _PreReadViewBody(
        book: book,
        initialPage: initialPage,
        fromBookmarkId: fromBookmarkId,
      ),
    );
  }
}


class _PreReadViewBody extends StatefulWidget {
  final Book book;
  final int? initialPage;
  final int? fromBookmarkId;

  const _PreReadViewBody({
    Key? key,
    required this.book,
    this.initialPage,
    this.fromBookmarkId,
  }) : super(key: key);
  @override
  State<_PreReadViewBody> createState() => _PreReadViewBodyState();
}

class _PreReadViewBodyState extends State<_PreReadViewBody> {
  bool inFavorite = false;
  bool isLoading = true;
  late Future<File> _pdfFile;

  @override
  void initState() {
    super.initState();

    // Tải PDF ngay khi vào trang
    final url = "${ApiConstants.host}${widget.book.pdfFilePath}";
    _pdfFile = createFileOfPdfUrl(url); // Tải và cache file

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final favoriteVM = Provider.of<BookViewModel>(context, listen: false);

      if (favoriteVM.favoriteBooks.isEmpty) {
        await favoriteVM.fetchFavoriteBooks();
      }

      final isFavorited = favoriteVM.isFavorite(widget.book);

      setState(() {
        inFavorite = isFavorited;
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 60),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network( 
                      widget.book.imagePath,
                      width: 140,
                      height: 230,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.book.title,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis, // Cắt chữ nếu quá dài
                              maxLines: 2, // Giới hạn số dòng
                        ),
                        const SizedBox(height: 35),
                        Text(
                          'Tác giả: ${widget.book.authorName}',
                          style: const TextStyle(
                              fontSize: 16, fontStyle: FontStyle.italic),
                              overflow: TextOverflow.ellipsis, // Cắt chữ nếu quá dài
                              maxLines: 2,
                        ),
                        const SizedBox(height: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.visibility, color: Colors.black),
                                const SizedBox(width: 5),
                                Text('${widget.book.totalViews} lượt xem'),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(Icons.favorite, color: Colors.black),
                                const SizedBox(width: 5),
                                Text('${widget.book.totalLikes} lượt thích'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DefaultTabController(
                  length: 2, 
                  child: Column(
                    children: [
                      // 🟢 TabBar
                      TabBar(
                        labelColor: Colors.black,
                        indicatorColor: Color(0xFFA37200),
                        indicatorWeight: 4.0,
                        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        tabs: const [
                          Tab(text: "Mô tả",),
                          Tab(text: "Bình luận"),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: TabBarView(
                          children: [
                            // Nội dung tab 1: Mô tả sách
                            SingleChildScrollView(
                              child: Text(
                                "Đây là mô tả của sách. Nội dung giới thiệu về cuốn sách này...",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),

                            // Nội dung tab 2: Đánh giá sách
                            Center(
                              child: Text(
                                "Chưa có đánh giá nào.",
                                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8,),
            // Nút "Đọc ngay"
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(), // Bo tròn nếu muốn
                    padding: const EdgeInsets.all(12),
                  ),
                  child: const Icon(Icons.favorite, color: Colors.red),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    try {
                      final file = await _pdfFile;
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(path: file.path, initialPage: widget.initialPage,bookId: widget.book.bookId,)
                        ),
                      );
                    } catch (e) {
                      print("PDF URL: ${widget.book.pdfFilePath}");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Không thể mở sách. Vui lòng thử lại.")),
                      );
                    }
                  },
                  label: Text(
                    widget.initialPage != null ? "Đọc tiếp" : "Đọc sách",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFA37200),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await context.read<BookViewModel>().toggleFavorite(context,inFavorite, widget.book.bookId);
                    setState(() {
                      inFavorite = !inFavorite;
                    });
                  },
                  icon: Icon(
                    inFavorite == true ? Icons.delete : Icons.bookmark_add,
                    color: Colors.white,
                  ),
                  label: Text(
                    inFavorite == true ? "Xoá khỏi BST" : "Thêm vào BST",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFA37200),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
