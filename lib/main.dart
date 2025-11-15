import 'package:flutter/material.dart';
// --- Modelo de Datos para un Producto ---
class Product {
  final int id;
  final String name;
  final double price;
  final String imageUrl; // Ahora será una ruta local (ej: "assets/images/laptop.png")

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

// --- Modelo de Datos para un Item en el Carrito ---
class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

void main() {
  runApp(const OrderApp());
}

class OrderApp extends StatelessWidget {
  const OrderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestor de Pedidos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter', // Asegúrate de agregar la fuente 'Inter' a tu pubspec.yaml si la quieres
      ),
      home: const OrderScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  // --- Estado de la App ---

  // Datos de ejemplo - ¡ACTUALIZADOS CON RUTAS LOCALES!
  // Asegúrate de que estos nombres de archivo coincidan EXACTAMENTE
  // con los archivos en tu carpeta assets/images/
  final List<Product> _products = [
    Product(id: 1, name: "Combo Sandwich", price: 5.50, imageUrl: "assets/images/combo_de_sandwitch.jpg"),
    Product(id: 2, name: "Crepa", price: 45.50, imageUrl: "assets/images/crepa.jpg"),
    Product(id: 3, name: "Galletas", price: 3.00, imageUrl: "assets/images/galletas_preparadas.jpg"),
    Product(id: 4, name: "Pastel Azul", price: 20.00, imageUrl: "assets/images/pastel_azul.jpg"),
    Product(id: 5, name: "Pastel Decorativo", price: 5.59, imageUrl: "assets/images/pastel_decorativo.jpg"),
    Product(id: 6, name: "Fresa con crema", price: 5.00, imageUrl: "assets/images/fresas_con_crema.jpg"), // Dejé este como png por si acaso
  ];

  final List<String> _companies = ["TechCorp S.A.", "Foodies Express", "FashionHub"];
  final List<String> _paymentTypes = ["Tarjeta de Crédito", "PayPal", "Efectivo (Contra entrega)"];
  
  String? _selectedCompany;
  String? _selectedPaymentType;

  // El carrito usa el ID del producto como clave
  final Map<int, CartItem> _cart = {};

  // --- Lógica del Carrito ---

  void _addToCart(Product product) {
    setState(() {
      if (_cart.containsKey(product.id)) {
        // Incrementar cantidad si ya existe
        _cart[product.id]!.quantity++;
      } else {
        // Agregar nuevo producto al carrito
        _cart[product.id] = CartItem(product: product);
      }
    });

    // Mostrar una confirmación visual
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${product.name} agregado al carrito.'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  double _calculateTotal() {
    double total = 0.0;
    _cart.forEach((key, item) {
      total += item.product.price * item.quantity;
    });
    return total;
  }

  // --- Lógica del Pedido ---
  void _placeOrder() {
    if (_cart.isEmpty) {
      _showAlertDialog("Carrito Vacío", "Tu carrito está vacío. Agrega productos antes de realizar un pedido.");
      return;
    }

    if (_selectedCompany == null || _selectedPaymentType == null) {
      _showAlertDialog("Datos Incompletos", "Por favor, selecciona una empresa y un método de pago.");
      return;
    }

    // Si todo está bien
    _showAlertDialog("¡Éxito!", "Pedido realizado con éxito.");

    // Resetear estado
    setState(() {
      _cart.clear();
      _selectedCompany = null;
      _selectedPaymentType = null;
    });
  }

  // --- Helper para mostrar Diálogo ---
  void _showAlertDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              child: const Text('Entendido'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // --- Construcción de la UI ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Pedido'),
      ),
      // Usamos un ListView para que todo sea deslizable
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildOrderDetailsSection(),
          const SizedBox(height: 24),
          _buildCatalogSection(),
          const SizedBox(height: 24),
          _buildCartSection(),
        ],
      ),
      // Footer con el botón de realizar pedido
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: _placeOrder,
          child: const Text('Realizar Pedido', style: TextStyle(fontSize: 16)),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            backgroundColor: Colors.green[600],
            foregroundColor: Colors.white,
          ),
        ),
      ),
    );
  }

  // Widget para la sección "Detalles del Pedido"
  Widget _buildOrderDetailsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Detalles del Pedido', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        // Dropdown para Empresa
        DropdownButtonFormField<String>(
          value: _selectedCompany,
          hint: const Text('Seleccione una empresa...'),
          isExpanded: true,
          items: _companies.map((company) {
            return DropdownMenuItem(
              value: company,
              child: Text(company),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedCompany = value;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Empresa',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        // Dropdown para Tipo de Pago
        DropdownButtonFormField<String>(
          value: _selectedPaymentType,
          hint: const Text('Seleccione un método...'),
          isExpanded: true,
          items: _paymentTypes.map((payment) {
            return DropdownMenuItem(
              value: payment,
              child: Text(payment),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedPaymentType = value;
            });
          },
          decoration: const InputDecoration(
            labelText: 'Tipo de Pago',
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }

  // Widget para la sección "Catálogo"
  Widget _buildCatalogSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Catálogo de Productos', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        // Grid para los productos
        GridView.builder(
          itemCount: _products.length,
          // Evita que el GridView intente scrollear por sí mismo
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), 
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columnas
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 0.7, // Ajusta esto para el tamaño de la tarjeta
          ),
          itemBuilder: (context, index) {
            final product = _products[index];
            return ProductCard(
              product: product,
              onAddToCart: () => _addToCart(product),
            );
          },
        ),
      ],
    );
  }

  // Widget para la sección "Mi Pedido"
  Widget _buildCartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mi Pedido', style: Theme.of(context).textTheme.headlineSmall),
        const SizedBox(height: 16),
        _cart.isEmpty
            ? const Center(child: Text('Tu carrito está vacío.', style: TextStyle(color: Colors.grey)))
            : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _cart.length,
                itemBuilder: (context, index) {
                  final item = _cart.values.elementAt(index);
                  final itemTotal = item.product.price * item.quantity;
                  return ListTile(
                    title: Text(item.product.name),
                    subtitle: Text('Cantidad: ${item.quantity}'),
                    trailing: Text('\$${itemTotal.toStringAsFixed(2)}'),
                  );
                },
              ),
        const Divider(height: 32),
        // Total
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            'Total: \$${_calculateTotal().toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

// --- Widget para la Tarjeta de Producto ---
class ProductCard extends StatelessWidget {
  final Product product;
  final VoidCallback onAddToCart;

  const ProductCard({
    Key? key,
    required this.product,
    required this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                // ¡CAMBIO AQUÍ! Usamos Image.asset para cargar desde la carpeta local
                child: Image.asset(
                  product.imageUrl,
                  fit: BoxFit.cover,
                  // Icono de error si falla (ej: ruta incorrecta)
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[200],
                      child: Icon(Icons.broken_image, color: Colors.grey[400]),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: onAddToCart,
              child: const Text('Agregar'),
            ),
          ],
        ),
      ),
    );
  }
}

