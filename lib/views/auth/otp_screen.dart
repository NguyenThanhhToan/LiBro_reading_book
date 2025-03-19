import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Libro/utils/app_colors.dart';
import 'package:Libro/viewmodels/auth_viewmodel.dart';

class OtpScreen extends StatelessWidget {
  final String userId;
  final String email;

  const OtpScreen({Key? key, required this.userId, required this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundColor),
        child: Center(
          child: Consumer<OtpViewModel>(
            builder: (context, otpViewModel, child) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    const Text(
                      "Nhập mã OTP",
                      style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Mã OTP đã được gửi qua email $email của bạn\nhãy kiểm tra trong Gmail nhé!",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 16, color: AppColors.textColor),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Còn lại ${otpViewModel.countdown} giây trước khi OTP hết hạn",
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textColor),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: TextField(
                        controller: otpViewModel.otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontSize: 24, letterSpacing: 8),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: otpViewModel.errorMessage.isNotEmpty ? Colors.red : Colors.transparent,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: otpViewModel.errorMessage.isNotEmpty ? Colors.red : Colors.transparent,
                            ),
                          ),
                          hintText: "••••••",
                          counterText: "",
                        ),
                      ),
                    ),
                    if (otpViewModel.errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          otpViewModel.errorMessage,
                          style: const TextStyle(color: Colors.red, fontSize: 14),
                        ),
                      ),
                    TextButton(
                      onPressed: otpViewModel.resendOtp,
                      child: const Text(
                        "Không nhận được OTP? Gửi lại ngay",
                        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: otpViewModel.isLoading
                          ? null
                          : () => otpViewModel.verifyOtp(context, userId),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: otpViewModel.isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Gửi", style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
