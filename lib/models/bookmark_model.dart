import 'book_model.dart';

class Bookmark {
  final int bookmarkId;
  final int pageNumber;
  final Book book;

  Bookmark({
    required this.bookmarkId,
    required this.pageNumber,
    required this.book,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
      bookmarkId: json['bookmarkId'] ?? 0,
      pageNumber: json['pageNumber'] ?? 0,
      book: Book.fromJson(json),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'bookmarkId': bookmarkId,
      'pageNumber': pageNumber,
      ...book.toJson(),
    };
  }

  static List<Bookmark> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Bookmark.fromJson(json)).toList();
  }
}
