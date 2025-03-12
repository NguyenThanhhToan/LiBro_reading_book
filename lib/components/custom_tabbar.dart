import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<String> tabs;

  const CustomTabBar({super.key, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorColor: Color(0xFFA37200),
      labelColor: Color(0xFFA37200),
      unselectedLabelColor: Color.fromARGB(255, 0, 0, 0),
      labelStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      tabs: tabs.map((tab) => Tab(text: tab)).toList(),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100.0);
}
