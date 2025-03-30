import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_tabbar.dart';
import '../../components/custom_navbar.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundColor,
          ),
          child: const Column(
            children: [
              SizedBox(height: 22),
              CustomTabBar(tabs: ['Khám phá', 'Nổi bật', 'Mới nhất', 'Danh mục']),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text("Nội dung Khám phá")),
                    Center(child: Text("Nội dung Nổi bật")),
                    Center(child: Text("Nội dung Mới nhất")),
                    Center(child: Text("Nội dung Danh mục")),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavBar(currentIndex: 2)),
    );
  }
}
