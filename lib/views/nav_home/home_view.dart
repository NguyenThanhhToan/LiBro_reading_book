import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_tabbar.dart';
import '../../components/custom_navbar.dart';
import 'explore_view.dart';
import 'featured_view.dart';
import 'latest_view.dart';
import 'categories_view.dart';
import 'package:provider/provider.dart';
import 'package:Libro/viewmodels/book_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookViewModel(), // ✅ Cung cấp BookViewModel
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: AppColors.backgroundColor,
            ),
            child: Column(
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
          bottomNavigationBar: CustomNavBar(currentIndex: 0),
        ),
      ),
    );
  }
}