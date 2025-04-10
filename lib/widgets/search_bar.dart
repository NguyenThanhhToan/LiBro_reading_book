import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function(String)? onSubmitted; // ✅ Thêm callback

  const SearchBarWidget({super.key, this.onSubmitted}); // ✅ Constructor

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Color(0xFFE6D9F3),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              onSubmitted: onSubmitted, // ✅ Gọi khi người dùng nhấn Enter
              decoration: const InputDecoration(
                hintText: 'Nhập tên sách, tác giả...',
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}