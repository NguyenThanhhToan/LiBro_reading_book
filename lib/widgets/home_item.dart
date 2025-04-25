import 'package:Libro/app/app_snackbar.dart';
import 'package:Libro/models/bookmark_model.dart';
import 'package:flutter/material.dart';
import 'package:Libro/views/read_book/pre_read_view.dart';

class CategoryBox extends StatelessWidget {
  final String imagePath;
  final String label;
  final Widget? pushToScreen;

  const CategoryBox({
    Key? key,
    required this.imagePath,
    required this.label,
    this.pushToScreen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (pushToScreen != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => pushToScreen!),
          );
        } else {
          AppSnackbar.showInfo(context, "Tính năng đang được phát triển");
        }
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 3),
          Container(
            width: 60,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 11.6,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrentBook extends StatelessWidget {
  final Bookmark bookmark;

  const CurrentBook(this.bookmark, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PreReadView(
            book: bookmark.book,
            initialPage: bookmark.pageNumber,
            fromBookmarkId: bookmark.bookmarkId,
          ),
        ),
      );
    },
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: const Color.fromARGB(255, 253, 253, 253).withOpacity(0.2), spreadRadius: 1, blurRadius: 5),
        ],
        border: Border.all(color: const Color.fromARGB(255, 197, 196, 196), width: 1),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(bookmark.book.imagePath),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            child: Text(
              bookmark.book.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
