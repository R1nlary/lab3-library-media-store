# LAB3 — Library Book Management System & Digital E-Commerce Media Store

Two independent Dart scripts covering both parts of the assignment.

## Part 1 — In-Class Lab Exercise (LW3): Library Book Management System

```bash
dart run bin/library.dart
```

* `Book` — `title`, `author`, `price`, `isBorrowed` (defaults to `false`).
* `Library` — keeps a private `List<Book> _books`:
  * `addBook(Book book)` — adds a book.
  * `getAvailableBooks()` — uses `.where()` to return books that aren't borrowed.
  * `getTotalValue()` — uses `.fold()` to sum up the price of every book.

`main()` adds 4 sample books (one of them borrowed), prints the available
ones and the total collection value.

## Part 2 — Homework 3: Digital E-Commerce Media Store

```bash
dart run bin/media_store.dart
```

* `MediaItem` — abstract class with `id`, `title`, `price` and the abstract
  method `getDetails()`.
* `Audiobook` / `EBook` — extend `MediaItem`, each adding its own fields
  (`durationHours`/`narrator` and `fileSizeMB`/`author`) and implementing
  `getDetails()`.
* `Downloadable` — a mixin with `download(String title)`, applied to both
  subclasses with `with Downloadable`.
* `ShoppingCart` — keeps a private `List<MediaItem> _items`:
  * `addItem(MediaItem item)` — adds an item to the cart.
  * `calculateTotalWithTax({double taxRate = 0.12})` — uses `.fold()` to sum
    prices and adds tax on top (12% by default).
  * `filterByMaxPrice(double maxPrice)` — uses `.where()` to filter items
    priced at or below `maxPrice`.
  * `printReceipt()` — prints every item's details and calls `download()`
    for items that are `Downloadable`.

`main()` fills the cart with an audiobook and two ebooks, prints the items
under $10, then prints the full receipt with tax.
