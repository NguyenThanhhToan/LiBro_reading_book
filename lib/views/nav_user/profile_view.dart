import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_navbar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundColor,
        )        
      ),
      bottomNavigationBar: CustomNavBar(currentIndex: 4)
    );
  }
}
