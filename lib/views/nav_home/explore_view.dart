import 'package:flutter/material.dart';
import '../../widgets/category_box.dart';
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
        children: [
          SizedBox( height: 30),
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
                ),
                child: Wrap( 
                  spacing: 14, 
                  runSpacing: 11,
                  children: [
                    CategoryBox(imagePath: 'assets/images/cate_box1.png', label: 'Sách'),
                    CategoryBox(imagePath: 'assets/images/cate_box2.png', label: 'Truyện'),
                    CategoryBox(imagePath: 'assets/images/cate_box3.png', label: 'Cộng đồng'),
                    CategoryBox(imagePath: 'assets/images/cate_box4.png', label: 'Song ngữ'),
                    CategoryBox(imagePath: 'assets/images/cate_box5.png', label: 'Bộ sưu tập'),
                    CategoryBox(imagePath: 'assets/images/cate_box6.png', label: 'Truyện ma'),
                    CategoryBox(imagePath: 'assets/images/cate_box7.png', label: 'Xem thêm'),
                  ],
                ),
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
