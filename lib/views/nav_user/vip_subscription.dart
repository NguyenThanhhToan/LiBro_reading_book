import 'package:flutter/material.dart';
import 'package:Libro/utils/app_colors.dart';
import 'package:Libro/viewmodels/vip_viewmodel.dart'; // tạo file này như trên
import 'package:Libro/widgets/vip_option_card.dart';
import 'package:provider/provider.dart';
import 'package:Libro/models/vip_model.dart';

class VipSubscription extends StatelessWidget {

  void _handleVipRegister(BuildContext context, int time, int amount) async {
    final viewModel = Provider.of<VipViewModel>(context, listen: false);

    final success = await viewModel.registerVip(time: time, amount: amount);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Chuyển hướng đến trang thanh toán...')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(viewModel.errorMessage ?? 'Có lỗi xảy ra')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(gradient: AppColors.backgroundColor),
        padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Đăng ký VIP", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: const [
                  Text("Chọn gói phù hợp với bạn", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  SizedBox(height: 5),
                  Text("Xem sách dành cho VIP", style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
            const SizedBox(height: 30),
            VipOptionCard(
              vipModel: VipModel(time: 1, amount: 24500, backgroundColor: Colors.deepOrange),
              onPressed: () => _handleVipRegister(context, 1, 24500),
            ),
            const SizedBox(height: 20),
            VipOptionCard(
              vipModel: VipModel(time: 6, amount: 119000, backgroundColor: Colors.blue),
              onPressed: () => _handleVipRegister(context, 6, 119000),
            ),
            const SizedBox(height: 20),
            VipOptionCard(
              vipModel: VipModel(time: 12, amount: 189000, backgroundColor: Colors.green),
              onPressed: () => _handleVipRegister(context, 12, 189000),
            ),
            const SizedBox(height: 20),
            const Text(
              "* Quý khách có thể liên hệ admin để thanh toán chuyển khoản",
              style: TextStyle(color: Colors.red, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

