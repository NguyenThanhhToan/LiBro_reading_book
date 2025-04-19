import 'package:flutter/material.dart';
import 'package:Libro/utils/app_colors.dart';
import 'package:Libro/components/custom_tabbar.dart';
import 'package:Libro/components/custom_navbar.dart';
import 'package:Libro/views/nav_home/explore_view.dart';
import 'package:Libro/views/nav_home/featured_view.dart';
import 'package:Libro/views/nav_home/latest_view.dart';
import 'package:Libro/views/nav_home/categories_view.dart';
import 'package:provider/provider.dart';
import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/viewmodels/bookmark_viewmodel.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => BookViewModel()),
        ChangeNotifierProvider(create: (context) => BookmarkViewModel()),
      ],
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