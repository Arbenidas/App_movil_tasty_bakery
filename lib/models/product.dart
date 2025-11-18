// lib/models/product.dart
enum ProductCategory {
  pasteles,
  crepas,
  bebidas,
  combos,
  dulces
}

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final ProductCategory category;
  final bool isRecommended; // Para la sección "Te recomendamos"

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isRecommended = false,
  });
}