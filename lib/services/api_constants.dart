import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static String get host => dotenv.env['API_HOST'] ?? "default_host";
  static String get apiPath => dotenv.env['API_PATH'] ?? "/default_path";
  static String get baseUrl => "$host$apiPath";
}
