// lib/screens/home_screen.dart
import 'package:app_gestion_pedidos/widgets/product_cart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/product_data.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Asegúrate de iniciar con una categoría que tenga productos
  ProductCategory _selectedCategory = ProductCategory.pasteles; 

  List<Product> get _filteredProducts {
    return DUMMY_PRODUCTS
        .where((product) =>
            product.category == _selectedCategory && !product.isRecommended)
        .toList();
  }

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
      // --- CAMBIOS PARA WEB ---
      // Centramos el contenido y le damos un ancho máximo
      // para que no se vea raro en pantallas muy anchas.
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: ListView(
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
                height: 320,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _recommendedProducts.length,
                  // Agregamos padding horizontal para web
                  padding: const EdgeInsets.symmetric(horizontal: 16), 
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
                  'Nuestro Catálogo', // Título actualizado
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(color: theme.primaryColor),
                ),
              ),
              _buildCategoryChips(),

              // --- GRID DE PRODUCTOS FILTRADOS (RESPONSIVO) ---
              GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _filteredProducts.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                // --- CAMBIO DE GRID PARA WEB ---
                // Reemplazamos SliverGridDelegateWithFixedCrossAxisCount
                // por SliverGridDelegateWithMaxCrossAxisExtent.
                // Esto crea tantas columnas como quepan, con un ancho
                // máximo de 350px por tarjeta.
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 350, // Ancho máx. de cada tarjeta
                  childAspectRatio: 0.8, // Ratio Ancho/Alto (ajustado)
                  crossAxisSpacing: 20, // Espacio horizontal (aumentado)
                  mainAxisSpacing: 20,  // Espacio vertical (aumentado)
                ),
                itemBuilder: (ctx, i) => ProductCard(
                  product: _filteredProducts[i],
                ),
              ),
              // Mensaje si la categoría está vacía (después de filtrar)
              if (_filteredProducts.isEmpty)
                Container(
                  padding: const EdgeInsets.all(50),
                  alignment: Alignment.center,
                  child: Text(
                    'No hay productos en esta categoría (que no sean recomendados).',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey[600]
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChips() {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      // En Web, es mejor que esto sea un ListView que un Wrap,
      // para mantener el diseño limpio.
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: ProductCategory.values.map((category) {
          final isSelected = _selectedCategory == category;
          // Capitaliza la primera letra, el resto en minúscula
          String categoryName = category.toString().split('.').last;
          categoryName =
              '${categoryName[0].toUpperCase()}${categoryName.substring(1)}';

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