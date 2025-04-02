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
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Tìm kiếm sách, tác giả...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  prefixIcon: Icon(Icons.search),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 223, 223, 223),
                ),
              ),
            ),
            const CustomTabBar(tabs: ['Sách', 'Tác giả', 'Danh mục', 'Danh ngôn']),
            const Expanded(
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
      bottomNavigationBar: CustomNavBar(currentIndex: 2),
    ),
  );
}

}
