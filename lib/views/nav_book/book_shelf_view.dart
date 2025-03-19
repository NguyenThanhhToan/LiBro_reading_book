import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_tabbar.dart';
import '../../components/custom_navbar.dart';

class Bookshelf extends StatelessWidget {
  const Bookshelf({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundColor,
          ),
          child: const Column(
            children: [
              SizedBox(height: 22),
              CustomTabBar(tabs: ['Khám phá', 'Nổi bật', 'Mới nhất', 'Danh mục', 'adfas']),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text("Nội dung Khám phá")),
                    Center(child: Text("Nội dung Nổi bật")),
                    Center(child: Text("Nội dung Mới nhất")),
                    Center(child: Text("Nội dung Danh mục")),
                    Center(child: Text("Nội dung Danh mục")),
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
