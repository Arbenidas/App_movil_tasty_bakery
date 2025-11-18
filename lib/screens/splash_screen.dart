// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    // Duración total de la animación + espera
    await Future.delayed(const Duration(milliseconds: 3000));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Usando el color de tu tema
    final Color tastyPink = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: tastyPink,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo (Fresa de "Tasty Bakery") animado
            Icon(
              Icons.cake, // Icono que simula tu logo de fresa
              color: Colors.white,
              size: 100,
            )
                .animate()
                .fadeIn(duration: 900.ms)
                .scale(
                  delay: 200.ms,
                  duration: 700.ms,
                  curve: Curves.easeOutBack,
                )
                .then(delay: 1500.ms) // Espera antes de la siguiente animación
                .shake(duration: 500.ms, hz: 3), // Pequeño saludo

            // Texto "Tasty Bakery" animado
            Text(
              'Tasty Bakery',
              style: GoogleFonts.pacifico( // Una fuente divertida para el logo
                fontSize: 40,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
                .animate()
                .fadeIn(delay: 700.ms, duration: 900.ms)
                .slideY(
                  begin: 0.5,
                  duration: 700.ms,
                  curve: Curves.easeInOut,
                ),
          ],
        ),
      ),
    );
  }
}