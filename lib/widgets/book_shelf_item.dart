import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../views/read_book/pre_read_view.dart';

class BookShelfItem extends StatelessWidget {
  final Book book;

  const BookShelfItem({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PreReadView(book: book)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE2D8D8),
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
                width: 115,
                height: 140,
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
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
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
                  book.totalLikes.toString(),
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
