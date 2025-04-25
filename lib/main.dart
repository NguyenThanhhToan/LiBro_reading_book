import 'package:Libro/viewmodels/notification_viewmodel.dart';
import 'package:Libro/viewmodels/read_pdf_viewmodel.dart';
import 'package:Libro/viewmodels/user_viewmodel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:Libro/viewmodels/book_viewmodel.dart';
import 'package:Libro/viewmodels/auth_viewmodel.dart';
import 'package:Libro/viewmodels/category_viewmodel.dart';
import 'package:Libro/views/auth/login_screen.dart';
import 'package:Libro/viewmodels/bookmark_viewmodel.dart';
import 'package:Libro/viewmodels/vip_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // 🔥 Khởi tạo Firebase ở đây
  await cleanOldPdfFiles();
  await printCachedBooks();
  await dotenv.load(fileName: "assets/.env");

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => OtpViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        ChangeNotifierProvider(create: (_) => BookViewModel()),
        ChangeNotifierProvider(create: (_) => CategoryViewModel()),
        ChangeNotifierProvider(create: (context) => UserViewmodel()),
        ChangeNotifierProvider(create: (_) => BookmarkViewModel()),
        ChangeNotifierProvider(create: (_) => NotificationViewModel()),
        ChangeNotifierProvider(create: (_) => VipViewModel())
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Libro App',
      home: LoginScreen(), // ✅ Trang chính
    );
  }
}