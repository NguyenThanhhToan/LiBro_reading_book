import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

// save pdf to temp cache
Future<File> createFileOfPdfUrl(String url) async {
  final filename = url.substring(url.lastIndexOf("/") + 1);
  final dir = await getApplicationDocumentsDirectory();
  final file = File("${dir.path}/$filename");

  // 🔍 Nếu file đã tồn tại => trả về luôn
  if (await file.exists()) {
    print("📄 Đã tồn tại file: ${file.path}");
    return file;
  }

  // 🆕 Nếu chưa có => tiến hành tải về
  try {
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);

    await file.writeAsBytes(bytes, flush: true);

    // 🕒 Lưu thời gian tải vào SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("pdf_download_time_${file.path}", DateTime.now().toString());

    print("✅ Tải file thành công: ${file.path}");
    return file;
  } catch (e) {
    throw Exception('❌ Lỗi khi tải file PDF: $e');
  }
}

Future<void> printCachedBooks() async {
  final prefs = await SharedPreferences.getInstance();
  final allKeys = prefs.getKeys();

  final pdfKeys = allKeys.where((key) => key.startsWith("pdf_download_time_"));

  if (pdfKeys.isEmpty) {
    print("📭 Không có sách nào được lưu trong cache.");
    return;
  }

  print("📚 Danh sách sách đã được lưu:");

  for (var key in pdfKeys) {
    final path = key.replaceFirst("pdf_download_time_", "");
    final time = prefs.getString(key);
    print("- $path (tải lúc: $time)");
  }
}

Future<void> cleanOldPdfFiles() async {
  final dir = await getApplicationDocumentsDirectory();
  final files = dir.listSync();
  final currentDate = DateTime.now();

  final prefs = await SharedPreferences.getInstance();

  for (var file in files) {
    if (file is File && file.path.endsWith('.pdf')) {
      // Lấy thời gian tải từ SharedPreferences
      final downloadTimeString = prefs.getString("pdf_download_time_${file.path}");
      if (downloadTimeString != null) {
        final downloadTime = DateTime.parse(downloadTimeString);
        final duration = currentDate.difference(downloadTime);

        // Nếu file đã được tải quá 7 ngày
        if (duration.inDays > 7) {
          try {
            await file.delete();
            print("Deleted old PDF file: ${file.path}");
            await prefs.remove("pdf_download_time_${file.path}"); // Xóa thông tin thời gian tải
          } catch (e) {
            print("Error deleting file: ${file.path}, $e");
          }
        }
      }
    }
  }
}
