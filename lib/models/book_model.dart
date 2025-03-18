class Book {
  final int id;
  final String name;
  final String author;
  final String image;
  final String category;

  Book({required this.id, required this.author, required this.name, required this.image, required this.category});
}

final List<Book> books = [
  Book(id: 1, name: 'truyện Doraemon tập 1', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
  Book(id: 2, name: 'Sách 2', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
  Book(id: 3, name: 'Sách 3', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
  Book(id: 4, name: 'Sách 4', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
  Book(id: 5, name: 'Sách 5', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
  Book(id: 6, name: 'Sách 6', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
  Book(id: 7, name: 'Sách 7', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
  Book(id: 8, name: 'Sách 8', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
  Book(id: 8, name: 'Sách 9', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
  Book(id: 8, name: 'Sách 10', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
  Book(id: 8, name: 'Sách 11', author: 'tôi', image: 'assets/images/Doraemon1.jpg',category: 'cartoon'),
];