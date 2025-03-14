import 'package:flutter/material.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.black,
      selectedItemColor: Color(0xFFA37200),
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/home_icon_black.png')),
          label: 'Trang chủ,'
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/book_icon_black.png')),
          label: 'Kệ sách',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/search_icon_black.png')),
          label: 'Tìm kiếm',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/notic_icon_black.png')),
          label: 'Thông báo',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/user_icon_black.png')),
          label: 'Tài khoản',
        ),
      ],
    );
  }
}