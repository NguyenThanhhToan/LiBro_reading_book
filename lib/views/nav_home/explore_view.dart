import 'package:flutter/material.dart';
import '../../widgets/home_item.dart';
import '../../models/book_model.dart';
class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox( height: 30),
          //banner
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
          SizedBox(height: 30,),
          Center(
            child: Container(
              padding: EdgeInsets.all(17),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.blue, width: 0.5),
              ),                child: Wrap( 
                spacing: 14, 
                runSpacing: 11,
                children: [
                  CategoryBox(imagePath: 'assets/images/cate_box1.png', label: 'Sách'),
                  CategoryBox(imagePath: 'assets/images/cate_box2.png', label: 'Truyện'),
                  CategoryBox(imagePath: 'assets/images/cate_box3.png', label: 'Cộng đồng'),
                  CategoryBox(imagePath: 'assets/images/cate_box4.png', label: 'Song ngữ'),
                  CategoryBox(imagePath: 'assets/images/cate_box5.png', label: 'Bộ sưu tập'),                    CategoryBox(imagePath: 'assets/images/cate_box6.png', label: 'Truyện ma'),
                  CategoryBox(imagePath: 'assets/images/cate_box7.png', label: 'Xem thêm'),
                ],
              ),
            ),
          ),
          SizedBox(height: 12,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Khoảng cách với lề trái
            child: Text(
              'Gần đây',
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ), 
          SizedBox(height: 8,),
          // gần đây
          Container(
            height: 100,
            child: GridView.builder(
              scrollDirection: Axis.horizontal,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 0.55,
                crossAxisSpacing: 10,
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return CurrentBook(books[index]);
              },
            ),
          ),
          SizedBox( height: 8,),
          Padding(
            padding: const EdgeInsets.only(left: 16.0), // Khoảng cách với lề trái
            child: Text(
              'Gợi ý cho bạn',
              style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ), 
       ],
      ),
    );
  } 
  @override
  void dispose() { 
    _pageController.dispose();
    super.dispose();
  }
}
