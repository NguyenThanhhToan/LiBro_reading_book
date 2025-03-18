import 'package:Libro/widgets/book_item.dart';
import 'package:flutter/material.dart';
import '../../models/book_model.dart';
class FeaturedScreen extends StatelessWidget {
  const FeaturedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                spacing: -4.5,
                runSpacing: 10,
                children: books.map((book) => BookItem(book)).toList(),
              ),
            ),
         ]
        ),
      ),
    );
  }
}
