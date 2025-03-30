import 'package:flutter/material.dart';
import '../models/book_model.dart';
import '../views/read_book/pre_read_view.dart';
import 'dart:math';

class BookItem extends StatelessWidget {
  final Book book;
  const BookItem(this.book, {Key? key}) : super(key: key);

  Color getRandomColor() {
    List<Color> colors = [
      Colors.red, Colors.blue, Colors.green, Colors.grey, 
      Colors.orange, Colors.purple, Colors.pink
    ];
    return colors[Random().nextInt(colors.length)];
  }

  String getRandomCategory(List<String> categories) {
    if (categories.isNotEmpty) {
      return categories[Random().nextInt(categories.length)];
    }
    return "Chưa có thể loại";
  }

  @override
  Widget build(BuildContext context) {
    String randomCategory = getRandomCategory(book.categories);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreReadView(book: book),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: 120,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(book.imagePath,
                    width: 115,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 5,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: getRandomColor(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      randomCategory, 
                      style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                book.title,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: Text(
                'Tác giả: ' + book.authorName,
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
