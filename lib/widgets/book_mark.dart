import 'package:flutter/material.dart';
import 'package:Libro/models/bookmark_model.dart';
import 'package:Libro/views/read_book/pre_read_view.dart';

class BookmarkItem extends StatelessWidget {
  final Bookmark bookmark;

  const BookmarkItem({Key? key, required this.bookmark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final book = bookmark.book;
    final page = bookmark.pageNumber;

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreReadView(
              bookId: book.bookId,
              // Có thể truyền page nếu PreReadView hỗ trợ
              // initialPage: page,
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFE2D8D8),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.shade100),
        ),
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                book.imagePath,
                width: 60,
                height: 90,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    Icon(Icons.image_not_supported, size: 115, color: Colors.grey),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    book.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    book.authorName,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Row(
              children: [
                const Icon(Icons.favorite, color: Colors.black),
                const SizedBox(width: 4),
                Text(
                  page.toString(),
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
