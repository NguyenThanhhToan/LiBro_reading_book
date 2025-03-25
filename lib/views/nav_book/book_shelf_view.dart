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
          child: const Column(
            children: [
              SizedBox(height: 22),
              CustomTabBar(tabs: ['BST cá nhân', 'BST yêu thích', 'Sách', 'BST yêu thích', 'BST yêu thích', 'BST yêu thích', 'BST yêu thích',]),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text("Nội dung Khám phá")),
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
        bottomNavigationBar: CustomNavBar(currentIndex: 1)),
    );
  }
}
