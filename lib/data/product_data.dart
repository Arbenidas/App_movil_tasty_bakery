// lib/data/product_data.dart
import '../models/product.dart';

// Usando los datos de tus imágenes de menú y los assets de tu proyecto
final List<Product> DUMMY_PRODUCTS = [
  Product(
    id: 'p1',
    name: 'Triple Tentación',
    description: 'Deliciosa crepa con nutella, banano y fresa.',
    price: 4.00,
    imageUrl: 'assets/images/crepa.jpg', // Imagen de tu proyecto
    category: ProductCategory.crepas,
    isRecommended: true,
  ),
  Product(
    id: 'p2',
    name: 'Pastel Azul "Dancing Queen"',
    description: 'Pastel personalizado para 17 años.',
    price: 20.00,
    imageUrl: 'assets/images/pastel_azul.jpg', // Imagen de tu proyecto
    category: ProductCategory.pasteles,
  ),
  Product(
    id: 'p3',
    name: 'Combo Sandwich de Pollo',
    description: 'Sandwich de pollo con papas fritas.',
    // El menú dice S. de Pollo $3.50 + Papas $1.00
    price: 4.50, 
    imageUrl: 'assets/images/combo_de_sandwitch.jpg', // Imagen de tu proyecto
    category: ProductCategory.combos,
    isRecommended: true,
  ),
  Product(
    id: 'p4',
    name: 'Fresas con Crema',
    description: 'Vaso mediano (12 oz) con 2 frutas, 2 toppings y 1 salsa.',
    price: 4.00, // Precio de "Mixto" 12 oz
    imageUrl: 'assets/images/fresas_con_crema.jpg', // Imagen de tu proyecto
    category: ProductCategory.bebidas,
    isRecommended: true,
  ),
  Product(
    id: 'p5',
    name: 'Galletas Preparadas',
    description: 'Galleta con chispas de chocolate y drizzle.',
    price: 3.00, // Asumiendo precio de "Brownie" o similar
    imageUrl: 'assets/images/galletas_preparadas.jpg', // Imagen de tu proyecto
    category: ProductCategory.dulces,
  ),
  Product(
    id: 'p6',
    name: 'Pastel Decorativo "Plim Plim"',
    description: 'Pastel de cumpleaños temático.',
    price: 25.00, // Precio de ejemplo
    imageUrl: 'assets/images/pastel_decorativo.jpg', // Imagen de tu proyecto
    category: ProductCategory.pasteles,
  ),
];