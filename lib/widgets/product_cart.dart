// lib/widgets/product_card.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/cart_provider.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isHorizontal; // Para la lista de recomendaciones

  const ProductCard({
    super.key,
    required this.product,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cart = Provider.of<CartProvider>(context, listen: false);

    return Container(
      width: isHorizontal ? 220 : null,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Imagen
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Hero(
                    tag: product.id,
                    child: Container(
                      width: double.infinity,
                      child: Image.asset(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            Icon(Icons.broken_image, color: Colors.grey[300]),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black54,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '\$${product.price.toStringAsFixed(2)}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Detalles
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        product.name,
                        style: theme.textTheme.titleMedium,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        product.description,
                        style: theme.textTheme.bodySmall,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Expanded(child: ElevatedButton.icon(
                        onPressed: () {
                          cart.addItem(product);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('${product.name} agregado al carrito.'),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        icon: const Icon(Icons.add_shopping_cart, size: 18),
                        label: const Text('Agregar'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          minimumSize: const Size(double.infinity, 36),
                        ),
                      ),)
                      
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    )
        // Esta es la animación profesional que pediste
        .animate()
        .fadeIn(duration: 500.ms, curve: Curves.easeOut)
        .slideY(begin: 0.2, duration: 400.ms, curve: Curves.easeOut);
  }
}