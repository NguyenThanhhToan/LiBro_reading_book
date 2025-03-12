import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_tabbar.dart';
import '../../components/custom_navbar.dart';
import 'explore_view.dart';
import 'lasted_view.dart';
import 'featured_view.dart';
import 'categories_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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
                    ExploreScreen(),
                    FeaturedScreen(),
                    LatestScreen(),
                    CategoriesScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavBar(currentIndex: 0)),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomeView(),
  ));
}
