// lib/main.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/cart_provider.dart';
import 'screens/splash_screen.dart';
import 'theme.dart'; // Importamos nuestro tema personalizado

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Usamos ChangeNotifierProvider para que el carrito esté
    // disponible en toda la app.
    return ChangeNotifierProvider(
      create: (ctx) => CartProvider(),
      child: MaterialApp(
        title: 'Tasty Bakery',
        theme: appTheme, // Aplicamos el tema profesional
        home: const SplashScreen(), // Empezamos con el Splash animado
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}