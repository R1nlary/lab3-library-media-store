abstract class MediaItem {
  final String id;
  final String title;
  final double price;

  MediaItem({required this.id, required this.title, required this.price});

  String getDetails();
}

mixin Downloadable {
  void download(String title) {
    print('Downloading "$title"...');
  }
}

class Audiobook extends MediaItem with Downloadable {
  final double durationHours;
  final String narrator;

  Audiobook({
    required String id,
    required String title,
    required double price,
    required this.durationHours,
    required this.narrator,
  }) : super(id: id, title: title, price: price);

  @override
  String getDetails() => 'Audiobook: "$title" narrated by $narrator, '
      '${durationHours}h, \$${price.toStringAsFixed(2)}';
}

class EBook extends MediaItem with Downloadable {
  final double fileSizeMB;
  final String author;

  EBook({
    required String id,
    required String title,
    required double price,
    required this.fileSizeMB,
    required this.author,
  }) : super(id: id, title: title, price: price);

  @override
  String getDetails() => 'EBook: "$title" by $author, '
      '${fileSizeMB}MB, \$${price.toStringAsFixed(2)}';
}

class ShoppingCart {
  final List<MediaItem> _items = [];

  void addItem(MediaItem item) {
    _items.add(item);
  }

  // Sums up every item's price and adds tax on top.
  double calculateTotalWithTax({double taxRate = 0.12}) {
    final double subtotal = _items.fold(
      0.0,
      (total, item) => total + item.price,
    );
    return subtotal + subtotal * taxRate;
  }

  // Items priced at or below maxPrice.
  List<MediaItem> filterByMaxPrice(double maxPrice) {
    return _items.where((item) => item.price <= maxPrice).toList();
  }

  void printReceipt() {
    print('----- RECEIPT -----');
    for (final item in _items) {
      print(item.getDetails());
      if (item is Downloadable) {
        (item as Downloadable).download(item.title);
      }
    }
    print('Total with tax: \$${calculateTotalWithTax().toStringAsFixed(2)}');
    print('--------------------');
  }
}

void main() {
  final cart = ShoppingCart();

  cart.addItem(
    Audiobook(
      id: 'A1',
      title: 'Atomic Habits',
      price: 12.0,
      durationHours: 5.5,
      narrator: 'James Clear',
    ),
  );
  cart.addItem(
    EBook(
      id: 'E1',
      title: 'Dart in Action',
      price: 9.0,
      fileSizeMB: 4.2,
      author: 'Chris Buckett',
    ),
  );
  cart.addItem(
    EBook(
      id: 'E2',
      title: 'Clean Code',
      price: 15.0,
      fileSizeMB: 6.0,
      author: 'Robert C. Martin',
    ),
  );

  print('Items \$10 or cheaper:');
  for (final item in cart.filterByMaxPrice(10.0)) {
    print('- ${item.getDetails()}');
  }

  print('');
  cart.printReceipt();
}
