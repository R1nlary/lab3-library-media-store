class Book {
  final String title;
  final String author;
  final double price;
  bool isBorrowed;

  Book({
    required this.title,
    required this.author,
    required this.price,
    this.isBorrowed = false,
  });

  @override
  String toString() => '"$title" by $author (\$${price.toStringAsFixed(2)})';
}

class Library {
  final List<Book> _books = [];

  void addBook(Book book) {
    _books.add(book);
  }

  // Every book that is currently on the shelf (not borrowed).
  List<Book> getAvailableBooks() {
    return _books.where((book) => book.isBorrowed == false).toList();
  }

  // Total price of every book in the collection.
  double getTotalValue() {
    return _books.fold(0.0, (total, book) => total + book.price);
  }
}

void main() {
  final library = Library();

  library.addBook(
    Book(title: 'Clean Code', author: 'Robert C. Martin', price: 35.0),
  );
  library.addBook(
    Book(title: 'Dart in Action', author: 'Chris Buckett', price: 28.5),
  );
  library.addBook(
    Book(
      title: 'Atomic Habits',
      author: 'James Clear',
      price: 22.0,
      isBorrowed: true,
    ),
  );
  library.addBook(Book(title: '1984', author: 'George Orwell', price: 15.0));

  print('Available books:');
  for (final book in library.getAvailableBooks()) {
    print('- $book');
  }

  print(
    '\nTotal collection value: \$${library.getTotalValue().toStringAsFixed(2)}',
  );
}
