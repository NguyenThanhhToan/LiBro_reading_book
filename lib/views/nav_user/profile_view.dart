import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_navbar.dart';
import 'change_info_view.dart';
import 'change_password_view.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.backgroundColor,
        ),
        child: Column(
          children: [
            const SizedBox(height: 40),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(''),
            ),
            const SizedBox(height: 10),
            const Text(
              'Lê Minh Phúc',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthViewModel>().logout(context);
              },
              child: const Text("Đăng xuất"),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildMenuItem(context, Icons.person, 'Thông tin của bạn', const ChangeInfoView()),
                  _buildMenuItem(context, Icons.lock, 'Đổi mật khẩu', const ChangePasswordView()),
                  _buildMenuItem(context, Icons.settings, 'Tuỳ chỉnh danh mục & thao tác', null),
                  _buildMenuItem(context, Icons.backup, 'Sao lưu & khôi phục', null),
                  _buildMenuItem(context, Icons.wallpaper, 'Hình nền', null),
                  _buildMenuItem(context, Icons.star, 'Đánh giá 5 ★', null),
                  _buildMenuItem(context, Icons.help, 'Hướng dẫn sử dụng', null),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Đăng ký tài khoản VIP'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                    ),
                    child: const Text('Xoá tài khoản'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavBar(currentIndex: 4),
    );
  }

  Widget _buildMenuItem(BuildContext context, IconData icon, String title, Widget? destination) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: () {
        if (destination != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        }
      },
    );
  }
}
