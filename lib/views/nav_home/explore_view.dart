import 'dart:async';

import 'package:Libro/utils/app_timer_banner.dart';
import 'package:Libro/views/nav_home/top_like_view.dart';
import 'package:Libro/views/nav_home/top_view_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:Libro/viewmodels/bookmark_viewmodel.dart';
import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/widgets/home_item.dart';
import 'package:Libro/widgets/book_item.dart';
import 'package:Libro/views/nav_book/book_shelf_view.dart'; // ✅ Import màn hình kệ sách nếu chưa có

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  Timer? _bannerTimer;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _fetchData();
    _bannerTimer = startAutoScrollTimer(
      controller: _pageController,
      itemCount: 3,
    );
  }

  void _fetchData() {
    Future.microtask(() {
      Provider.of<BookViewModel>(context, listen: false).SuggestedBooks();
      Provider.of<BookmarkViewModel>(context, listen: false).CurrentBook();
    });
  }

  @override
  void dispose() {
    _bannerTimer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bookViewModel = Provider.of<BookViewModel>(context);
    var bookmarkViewModel = Provider.of<BookmarkViewModel>(context);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            // 📌 Banner
            SizedBox(
              height: 150.0,
              child: PageView.builder(
                controller: _pageController,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 300.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: AssetImage('assets/images/banner${index + 1}.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            // 📌 Category boxes
            Center(
              child: Container(
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.blue, width: 0.5),
                ),
                child: Wrap(
                  spacing: 13.4,
                  runSpacing: 11,
                  children: [
                    CategoryBox(
                      imagePath: 'assets/images/cate_box1.png',
                      label: 'Sách đang đọc',
                      // ✅ Truyền màn hình mới (BookShelfScreen) với tab "Sách gần đây"
                      pushToScreen: const BookShelfScreen(initialTabIndex: 0),
                    ),
                    CategoryBox(
                      imagePath: 'assets/images/cate_box2.png',
                      label: 'Sách nhiều lượt xem',
                      pushToScreen: const BooksTopViewScreen(),
                    ),
                    CategoryBox(
                      imagePath: 'assets/images/cate_box3.jpg',
                      label: 'Sách nhiều lượt thích',
                      pushToScreen: const BooksTopLikeScreen(),
                    ),
                    CategoryBox(
                      imagePath: 'assets/images/cate_box5.png',
                      label: 'Bộ sưu tập Yêu thích',
                      pushToScreen: const BookShelfScreen(initialTabIndex: 1),
                    ),
                    CategoryBox(imagePath: 'assets/images/cate_box4.png', label: 'Song ngữ'),
                    CategoryBox(imagePath: 'assets/images/cate_box6.png', label: 'Truyện ma'),
                    CategoryBox(imagePath: 'assets/images/cate_box7.png', label: 'Xem thêm'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 12),

            // 📌 Gần đây
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Gần đây',
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 8),

            SizedBox(
              height: 100,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 0.55,
                  crossAxisSpacing: 10,
                ),
                itemCount: bookmarkViewModel.currentBook.length,
                itemBuilder: (context, index) {
                  return CurrentBook(bookmarkViewModel.currentBook[index]);
                },
              ),
            ),

            const SizedBox(height: 8),

            // 📌 Gợi ý
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Gợi ý cho bạn',
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
              ),
            ),
            SizedBox(
              height: 380,
              child: GridView.builder(
                scrollDirection: Axis.horizontal,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                ),
                itemCount: bookViewModel.suggestBooks.length,
                itemBuilder: (context, index) {
                  return BookItem(bookViewModel.suggestBooks[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
