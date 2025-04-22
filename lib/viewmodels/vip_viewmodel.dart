import 'package:flutter/foundation.dart';
import 'package:Libro/services/vip_service.dart';

class VipViewModel extends ChangeNotifier {
  final VipService _vipService = VipService();

  // Trạng thái loading
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Thông báo lỗi
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  // URL thanh toán (nếu có)
  String? _paymentUrl;
  String? get paymentUrl => _paymentUrl;

  Future<bool> registerVip({required int time, required int amount}) async {
    try {
      // Bắt đầu loading
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      // Gọi service
      final success = await _vipService.registerVip(time: time, amount: amount);

      // Kết thúc loading
      _isLoading = false;

      if (success) {
        // Xử lý thành công
        // (Nếu service trả về URL, bạn có thể lưu vào _paymentUrl)
        notifyListeners();
        return true;
      } else {
        // Xử lý khi service trả về false
        _errorMessage = 'Đăng ký VIP không thành công';
        notifyListeners();
        return false;
      }
    } catch (e) {
      // Xử lý lỗi
      _isLoading = false;
      _errorMessage = 'Lỗi khi đăng ký VIP: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }
}