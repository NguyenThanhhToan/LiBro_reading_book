import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;

  const CustomTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        tabAlignment: TabAlignment.center,
        isScrollable: true,
        indicatorColor: const Color(0xFFA37200) ,// Ẩn đường kẻ ngăn cách
        labelColor: const Color(0xFFA37200),
        unselectedLabelColor: Colors.black,
        labelStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}