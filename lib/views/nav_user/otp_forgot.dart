import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Libro/utils/app_colors.dart';
import 'package:Libro/viewmodels/user_viewmodel.dart';

class OtpForgot extends StatefulWidget {
  final String id;
  final String email;

  const OtpForgot({Key? key, required this.id, required this.email}) : super(key: key);

  @override
  _OtpForgotState createState() => _OtpForgotState();
}

class _OtpForgotState extends State<OtpForgot> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewmodel>(context, listen: false);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.backgroundColor),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Nút quay lại
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.textColor),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                const SizedBox(height: 20),
                // Tiêu đề
                const Text(
                  "Nhập mã OTP",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 10),
                // Thông báo email
                Text(
                  "Mã OTP đã được gửi qua địa chỉ email của bạn\nhãy kiểm tra trong tin nhắn nhé!",
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16, color: AppColors.textColor),
                ),
                const SizedBox(height: 20),
                // Ô nhập OTP
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 24, letterSpacing: 8),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "••••••",
                      counterText: "",
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Nút Gửi
                ElevatedButton(
                  onPressed: () {
                    // Gọi hàm confirmForgotPassword từ UserViewmodel
                    userViewModel.confirmForgotPassword(
                      widget.id,
                      _otpController.text.trim(),
                      context,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9AD0AE),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: const Text(
                    "Gửi",
                    style: TextStyle(color: AppColors.textColor, fontSize: 18),
                  ),
                ),
                const Spacer(),
                // Footer
                Center(
                  child: RichText(
                    text: const TextSpan(
                      text: 'Đã có tài khoản? ',
                      style: TextStyle(color: AppColors.textColor),
                      children: [
                        TextSpan(
                          text: 'Đăng nhập ngay',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}