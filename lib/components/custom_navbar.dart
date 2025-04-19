import 'package:flutter/material.dart';
import 'package:Libro/views/nav_home/home_view.dart';
import 'package:Libro/views/nav_book/book_shelf_view.dart';
import 'package:Libro/views/nav_notification/notifications_view.dart';
import 'package:Libro/views/nav_search/search_view.dart';
import 'package:Libro/views/nav_user/profile_view.dart';

class CustomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomNavBar({
    super.key,
    required this.currentIndex,
  });

  void _onItemTapped(BuildContext context, int index) {
    if (index == currentIndex) return;
    Widget destination;
    switch (index) {
      case 0:
        destination = const HomeView();
        break;
      case 1:
        destination = const Bookshelf();
        break;
      case 2:
        destination = const SearchView();
        break;
      case 3:
        destination = const NotificationsView();
        break;
      case 4:
        destination = const ProfileView();
        break;
      default:
        return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      backgroundColor: Colors.black,
      selectedItemColor: const Color(0xFFA37200),
      unselectedItemColor: Colors.black,
      showUnselectedLabels: true,
      onTap: (index) => _onItemTapped(context, index),
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/icons/home_icon_black.png')),
          label: 'Trang chủ',
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