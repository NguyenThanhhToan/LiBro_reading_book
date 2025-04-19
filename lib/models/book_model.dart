import 'dart:math';
import 'package:Libro/services/api_constants.dart';

class Book {
  final int bookId;
  final String title;
  final List<String> categories;
  final String authorName;
  final String imagePath;
  final String createdAt;
  final String? pdfFilePath;
  final int? totalViews;
  final int totalLikes;

  Book({
    required this.bookId,
    required this.title,
    required this.categories,
    required this.authorName,
    required this.imagePath,
    required this.createdAt,
    this.pdfFilePath,
    this.totalViews,
    required this.totalLikes,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
  return Book(
    bookId: json['bookId'] ?? 0,
    title: json['title'] ?? "Không có tiêu đề",
    categories: (json['categories'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    authorName: json['authorName'] ?? "Không rõ tác giả",
    imagePath: json['imagePath'] != null && json['imagePath'].startsWith("http")
          ? json['imagePath']: "${ApiConstants.host}${json['imagePath'] ?? ''}",
    createdAt: json['createdAt'] ?? "",
    pdfFilePath: json['pdfFilePath'],
    totalViews: json['totalViews'] ?? 0,
    totalLikes: json['totalLikes'] ?? 0,
  );
}

  Map<String, dynamic> toJson() {
    return {
      'bookId': bookId,
      'title': title,
      'categories': categories,
      'authorName': authorName,
      'imagePath': imagePath,
      'createdAt': createdAt,
      'pdfFilePath': pdfFilePath,
      'totalViews': totalViews,
      'totalLikes': totalLikes,
    };
  }

  static List<Book> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Book.fromJson(json)).toList();
  }

  String getRandomCategory() {
    if (categories.isNotEmpty) {
      return categories[Random().nextInt(categories.length)];
    }
    return "Không có thể loại";
  }
}


