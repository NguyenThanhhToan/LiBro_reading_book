import 'package:flutter/material.dart';
import '../../models/book_model.dart';
import '../../viewmodels/read_pdf_viewmodel.dart';
import 'pdf_screen.dart';
import '../../services/api_constants.dart';

class PreReadView extends StatefulWidget {
  final Book book;

  const PreReadView({Key? key, required this.book}) : super(key: key);

  @override
  _PreReadViewState createState() => _PreReadViewState();
}

class _PreReadViewState extends State<PreReadView> {
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
                    final url = "${ApiConstants.host}${widget.book.pdfFilePath}";
                    try {
                      final file = await createFileOfPdfUrl(url);
                      if (!mounted) return;
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PDFScreen(path: file.path),
                        ),
                      );
                    } catch (e) {
                      print("PDF URL: $url");
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Không thể mở sách.aaaa Vui lòng thử lại.")),
                      );
                    }
                  },
                  label: const Text(
                    "Đọc sách",
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
                  onPressed: () {},
                  label: const Text("Thêm vào BST",style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold,),),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFA37200),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
