import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../components/custom_navbar.dart';
import '../../viewmodels/user_viewmodel.dart';

class ChangeInfoView extends StatelessWidget {
  const ChangeInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserViewmodel()..fetchUserInfo(),
      child: Scaffold(
        body: Consumer<UserViewmodel>(
          builder: (context, viewModel, child) {
            return Container(
              decoration: const BoxDecoration(
                gradient: AppColors.backgroundColor,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => Navigator.pop(context),
                    ),

                    Center(
                      child: Column(
                        children: [
                          const CircleAvatar(
                            radius: 50,
                            backgroundImage: AssetImage(''),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber),
                            child: const Text('Chỉnh sửa'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    _buildTextField("Tên người dùng", viewModel.usernameController),
                    _buildTextField("Email", viewModel.emailController, isEditable: false),
                    _buildTextField("Số điện thoại", viewModel.phoneNumberController),
                    _buildTextField("Ngày sinh", viewModel.dobController),

                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          await viewModel.updateUserInfo();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Cập nhật thành công!')),
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        child: const Text('Gửi'),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: CustomNavBar(currentIndex: 4),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool isEditable = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        enabled: isEditable,  // Control if the field is editable or not
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          suffixIcon: isEditable ? const Icon(Icons.edit) : null,
        ),
      ),
    );
  }

}
