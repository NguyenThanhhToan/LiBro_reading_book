import 'package:Libro/views/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Libro/utils/app_colors.dart';
import 'package:Libro/viewmodels/auth_viewmodel.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final registerVM = Provider.of<RegisterViewModel>(context);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: AppColors.backgroundColor,
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "Đăng kí",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Các trường nhập có hiển thị lỗi
                _buildTextField("Tên người dùng", "Nhập tên của bạn", registerVM.usernameController, registerVM.errors['username']),
                _buildTextField("Số điện thoại", "Số điện thoại của bạn", registerVM.phoneNumberController, registerVM.errors['phoneNumber'], keyboardType: TextInputType.phone),
                _buildTextField("Email", "Email của bạn", registerVM.emailController, registerVM.errors['email'], keyboardType: TextInputType.emailAddress),
                _buildDateField(registerVM),
                _buildPasswordField("Mật khẩu", registerVM.passwordController, registerVM.errors['password']),
                _buildPasswordField("Nhập lại mật khẩu", registerVM.confirmPasswordController, registerVM.errors['confirmPassword']),

                SizedBox(height: 20),
                if (registerVM.errorMessage.isNotEmpty)
                  Center(child: Text(registerVM.errorMessage, style: TextStyle(color: Colors.red))),

                ElevatedButton(
                  onPressed: registerVM.isLoading
                      ? null
                      : () {
                    setState(() {}); // Cập nhật UI khi có lỗi
                    registerVM.register(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: registerVM.isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text("Đăng kí", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),

                SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text("Đã có tài khoản? Đăng nhập ngay", style: TextStyle(color: AppColors.textColor)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, String hint, TextEditingController controller, String? errorText, {TextInputType keyboardType = TextInputType.text}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor)),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
            errorText: errorText, // Hiển thị lỗi nếu có
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller, String? errorText) {
    bool obscureText = true;
    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor)),
            SizedBox(height: 5),
            TextField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                hintText: "••••••••",
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                filled: true,
                fillColor: Colors.white,
                errorText: errorText, // Hiển thị lỗi nếu có
                suffixIcon: IconButton(
                  icon: Icon(obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 15),
          ],
        );
      },
    );
  }

  Widget _buildDateField(RegisterViewModel registerVM) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ngày sinh", style: TextStyle(fontWeight: FontWeight.bold, color: AppColors.textColor)),
        SizedBox(height: 5),
        TextField(
          controller: registerVM.dobController,
          readOnly: true,
          decoration: InputDecoration(
            hintText: "dd-MM-yyyy",
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            filled: true,
            fillColor: Colors.white,
            errorText: registerVM.errors['dob'], // Hiển thị lỗi nếu có
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (pickedDate != null) {
                  registerVM.dobController.text =
                  "${pickedDate.day.toString().padLeft(2, '0')}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.year}";
                }
              },
            ),
          ),
        ),
        SizedBox(height: 15),
      ],
    );
  }
}
