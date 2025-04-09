import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../../viewmodels/user_viewmodel.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  _ChangePasswordViewState createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewmodel>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[100],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Đổi mật khẩu',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple[100]!, Colors.purple[300]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Ô nhập mật khẩu cũ
            Positioned(
              left: 24,
              top: 224,
              child: _buildTextField(_oldPasswordController, 'Nhập mật khẩu cũ...', 327, 48),
            ),
            // Ô nhập mật khẩu mới
            Positioned(
              left: 24,
              top: 304,
              child: _buildTextField(_newPasswordController, 'Nhập mật khẩu mới...', 327, 48),
            ),
            // Ô nhập lại mật khẩu mới
            Positioned(
              left: 24,
              top: 381,
              child: _buildTextField(_confirmPasswordController, 'Nhập lại mật khẩu mới...', 327, 48),
            ),
            // Nút Gửi
            Positioned(
              left: (MediaQuery.of(context).size.width - 150) / 2, // Căn giữa chiều ngang
              top: 470, // Vị trí dưới các ô nhập
              child: SizedBox(
                width: 150,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await userViewModel.changePasswordWithValues(
                        _oldPasswordController.text,
                        _newPasswordController.text,
                        _confirmPasswordController.text,
                        context,
                      );
                    }
                  },
                  child: const Text(
                    'Gửi',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText, double width, double height) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        controller: controller,
        obscureText: true,
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: Colors.purple[50],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.blue),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 2),
          ),
        ),
        validator: (value) {
          if (controller == _oldPasswordController && value!.isEmpty) {
            return 'Vui lòng nhập mật khẩu cũ';
          } else if (controller == _newPasswordController && value!.length < 6) {
            return 'Mật khẩu ít nhất 6 ký tự';
          } else if (controller == _confirmPasswordController && value != _newPasswordController.text) {
            return 'Mật khẩu không khớp';
          }
          return null;
        },
      ),
    );
  }
}