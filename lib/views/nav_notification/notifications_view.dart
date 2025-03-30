import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_tabbar.dart';
import '../../components/custom_navbar.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.backgroundColor,
          ),
          child: const Column(
            children: [
              SizedBox(height: 22),
              CustomTabBar(tabs: ['Hệ Thống','Cá nhân']),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(child: Text("Nội dung Khám phá")),
                    Center(child: Text("Nội dung Nổi bật")),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomNavBar(currentIndex: 3)),
    );
  }
}
