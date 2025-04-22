import 'package:flutter/material.dart';
import 'package:Libro/models/vip_model.dart';

class VipOptionCard extends StatelessWidget {
  final VipModel vipModel;
  final VoidCallback onPressed;

  const VipOptionCard({
    super.key,
    required this.vipModel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: vipModel.backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(vipModel.displayAmount, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(vipModel.displayTime, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white, size: 18),
                    SizedBox(width: 5),
                    Text("Xem được sách dành cho vip", style: TextStyle(fontSize: 14, color: Colors.white)),
                  ],
                ),
                const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.white, size: 18),
                    SizedBox(width: 5),
                    Text("Không giới hạn hàng tháng", style: TextStyle(fontSize: 14, color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text("Đăng ký"),
          ),
        ],
      ),
    );
  }
}
