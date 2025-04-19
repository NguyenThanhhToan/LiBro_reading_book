import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../services/notification_service.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationService _notificationService = NotificationService();

  String? _deviceToken;
  String? get deviceToken => _deviceToken;

  Future<void> initFCM() async {
    try {
      // Lấy FCM token
      _deviceToken = await FirebaseMessaging.instance.getToken();
      if (_deviceToken != null) {
        print("📲 FCM Token: $_deviceToken");

        // Gửi token đến server
        await _notificationService.sendFcmTokenToServer(_deviceToken!);
        print("✅ Đã gửi token đến server.");
      } else {
        print("⚠️ Không lấy được FCM token.");
      }
    } catch (e) {
      print("🔥 Lỗi trong initFCM: $e");
    }
  }
}
