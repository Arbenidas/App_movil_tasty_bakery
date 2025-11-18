// lib/screens/cart_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Carrito'),
      ),
      body: Column(
        children: [
          Expanded(
            child: cart.items.isEmpty
                ? Center(
                    child: Text(
                      'Tu carrito está vacío.',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (ctx, i) {
                      final item = cart.items.values.toList()[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(item.product.imageUrl),
                          ),
                          title: Text(item.product.name, style: theme.textTheme.titleMedium),
                          subtitle: Text('Total: \$${(item.product.price * item.quantity).toStringAsFixed(2)}'),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.remove, color: theme.primaryColor),
                                onPressed: () {
                                  cart.removeSingleItem(item.product.id);
                                },
                              ),
                              Text('${item.quantity} x', style: theme.textTheme.bodyLarge),
                              IconButton(
                                icon: Icon(Icons.add, color: theme.primaryColor),
                                onPressed: () {
                                  cart.addItem(item.product);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (cart.items.isNotEmpty)
            _buildTotalCard(context, cart),
        ],
      ),
    );
  }

  Widget _buildTotalCard(BuildContext context, CartProvider cart) {
    final theme = Theme.of(context);
    return Card(
      elevation: 10,
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total', style: theme.textTheme.titleLarge),
                Chip(
                  label: Text(
                    '\$${cart.totalAmount.toStringAsFixed(2)}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                  backgroundColor: theme.colorScheme.secondary.withOpacity(0.2),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Lógica para pagar
                cart.clearCart();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('¡Pedido realizado con éxito!'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Realizar Pedido'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            )
          ],
        ),
      ),
    );
  }
}