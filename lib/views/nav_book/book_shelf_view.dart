import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_tabbar.dart';
import '../../components/custom_navbar.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
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
                    Center(child: Text("Nội dung Nổi bật")),
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
}
