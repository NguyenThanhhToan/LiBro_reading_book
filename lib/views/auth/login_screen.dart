import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Libro/utils/app_colors.dart';
import 'package:Libro/views/auth/register_screen.dart';
import 'package:Libro/viewmodels/auth_viewmodel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(gradient: AppColors.backgroundColor),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Đăng nhập",
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 24),
                _buildTextField(emailController, "Nhập email của bạn ...", false),
                SizedBox(height: 12),
                _buildTextField(passwordController, "Mật khẩu", true),
                SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Thêm logic quên mật khẩu
                    },
                    child: Text("Quên mật khẩu?", style: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(height: 12),
                loginViewModel.isLoading
                    ? CircularProgressIndicator()
                    : _buildLoginButton(context, loginViewModel),
                SizedBox(height: 12),
                _buildGoogleLoginButton(),
                SizedBox(height: 12),
                _buildRegisterLink(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Widget tạo ô nhập liệu
  Widget _buildTextField(TextEditingController controller, String hintText, bool isPassword) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  /// Nút đăng nhập
  Widget _buildLoginButton(BuildContext context, LoginViewModel loginViewModel) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () async {
        bool success = await loginViewModel.login(
          context,
          emailController.text,
          passwordController.text,
        );

        if (success) {
          print("Đăng nhập thành công");
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(loginViewModel.errorMessage ?? "Đăng nhập thất bại!")),
          );
        }
      },
      child: Text("Đăng nhập", style: TextStyle(fontSize: 16, color: Colors.white)),
    );
  }

  /// Nút đăng nhập bằng Google
  Widget _buildGoogleLoginButton() {
    return GestureDetector(
      onTap: () {
        print("Đăng nhập bằng Google");
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        ),
        child: FaIcon(
          FontAwesomeIcons.google,
          size: 30,
          color: Colors.red,
        ),
      ),
    );
  }

  /// Dòng chữ "Chưa có tài khoản?"
  Widget _buildRegisterLink(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Chưa có tài khoản?"),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RegisterScreen()),
            );
          },
          child: Text("Đăng ký ngay", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ],
    );
  }
}
