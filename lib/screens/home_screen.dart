// lib/screens/home_screen.dart
import 'package:app_gestion_pedidos/widgets/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart'; // Crearemos esta pantalla a continuación

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductCategory _selectedCategory = ProductCategory.combos;

 // DESPUÉS (Corregido)
List<Product> get _filteredProducts {
  return DUMMY_PRODUCTS
      .where((product) =>
          product.category == _selectedCategory &&
          !product.isRecommended) // <-- AÑADE ESTA LÍNEA
      .toList();
}

  // Obtiene los productos recomendados
  List<Product> get _recommendedProducts {
    return DUMMY_PRODUCTS.where((product) => product.isRecommended).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasty Bakery'),
        actions: [
          // Botón del carrito con contador
          Consumer<CartProvider>(
            builder: (_, cart, ch) => Badge(
              label: Text(cart.itemCount.toString()),
              isLabelVisible: cart.itemCount > 0,
              child: ch,
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (ctx) => const CartScreen()),
                );
              },
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: ListView(
        children: [
          // --- SECCIÓN DE RECOMENDACIONES ---
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Te Recomendamos',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(color: theme.primaryColor),
            ),
          ),
          Container(
            height: 320, // Altura fija para la lista horizontal
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _recommendedProducts.length,
              itemBuilder: (ctx, i) => ProductCard(
                product: _recommendedProducts[i],
                isHorizontal: true,
              ),
            ),
          ),

          // --- SECCIÓN DE CATEGORÍAS ---
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
            child: Text(
              'Categorías',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(color: theme.primaryColor),
            ),
          ),
          _buildCategoryChips(),

          // --- GRID DE PRODUCTOS FILTRADOS ---
          GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _filteredProducts.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 2 columnas
              childAspectRatio: 0.65, // Ajusta esto para el tamaño
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemBuilder: (ctx, i) => ProductCard(
              product: _filteredProducts[i],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ProductCategory.values.map((category) {
          final isSelected = _selectedCategory == category;
          String categoryName =
              category.toString().split('.').last.toUpperCase();

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(categoryName),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedCategory = category;
                  });
                }
              },
              backgroundColor: Colors.grey[100],
              selectedColor: Theme.of(context).primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black87,
                fontWeight: FontWeight.w600,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? Theme.of(context).primaryColor
                      : Colors.grey[300]!,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}