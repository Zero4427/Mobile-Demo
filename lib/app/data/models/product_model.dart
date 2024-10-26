class Product {
  final String name;
  final String color;
  final int price;
  bool isFavorite;

  Product({
    required this.name,
    required this.color,
    required this.price,
    this.isFavorite = false,
  });
}