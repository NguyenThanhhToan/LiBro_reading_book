import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_tabbar.dart';
import '../../components/custom_navbar.dart';
import '../../widgets/book_shelf_item.dart';
import '../../models/book_model.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    // Giả lập dữ liệu JSON từ API
    List<Map<String, dynamic>> bookJsonData = [
      {
        "bookId": 1,
        "title": "Doraemon Tập 1",
        "categories": ["Truyện tranh", "Thiếu nhi"],
        "authorName": "Fujiko F. Fujio",
        "createdAt": "2024-03-15",
        "totalLikes": 120,
      },
      {
        "bookId": 2,
        "title": "One Piece Tập 101",
        "categories": ["Hành động", "Phiêu lưu"],
        "authorName": "Eiichiro Oda",
        "createdAt": "2023-12-10",
        "totalLikes": 350,
      },
      {
        "bookId": 3,
        "title": "Harry Potter và Hòn đá Phù thủy",
        "categories": ["Viễn tưởng", "Phiêu lưu"],
        "authorName": "J.K. Rowling",
        "createdAt": "2001-06-26",
        "totalLikes": 500,
      },
    ];

    // Chuyển đổi JSON thành danh sách đối tượng Book
    List<Book> books = Book.fromJsonList(bookJsonData);

    return DefaultTabController(
      length: 7,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundColor,
          ),
          child: Column(
            children: [
              const SizedBox(height: 22),
              const CustomTabBar(tabs: [
                'Tải xuống','Sách','BST cá nhân', 'BST yêu thích',
              ]),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildBookList(books), // Hiển thị danh sách sách trong tab đầu tiên
                    Center(child: Text("Nội dung Nổi bật")),
                    Center(child: Text("Nội dung Mới nhất")),
                    Center(child: Text("Nội dung Mới nhất")),
                    Center(child: Text("Nội dung Mới nhất")),
                    Center(child: Text("Nội dung Mới nhất")),
                    Center(child: Text("Nội dung Mới nhất")),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomNavBar(currentIndex: 1),
      ),
    );
  }

  // Widget hiển thị danh sách sách
  Widget _buildBookList(List<Book> books) {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: books.length,
      itemBuilder: (context, index) {
        return BookShelfItem(book: books[index]);
      },
    );
  }
}
