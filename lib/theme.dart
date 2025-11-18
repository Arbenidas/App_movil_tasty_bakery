// lib/theme.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Color principal extraído de tus menús
const Color tastyPink = Color(0xFFF06292); // Un rosa fuerte
const Color tastyLightPink = Color(0xFFF8BBD0); // Un rosa claro

final appTheme = ThemeData(
  primaryColor: tastyPink,
  scaffoldBackgroundColor: Colors.white,
  
  // Define el esquema de colores
  colorScheme: ColorScheme.fromSeed(
    seedColor: tastyPink,
    primary: tastyPink,
    secondary: tastyLightPink,
    background: Colors.white,
  ),

  // Define la tipografía profesional
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    headlineSmall: GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      color: tastyPink,
      fontSize: 24,
    ),
    titleLarge: GoogleFonts.poppins(
      fontWeight: FontWeight.bold,
      fontSize: 20,
    ),
     titleMedium: GoogleFonts.poppins(
      fontWeight: FontWeight.w600,
      fontSize: 16,
    ),
    bodyMedium: GoogleFonts.poppins(
      fontSize: 14,
      color: Colors.black87,
    ),
  ),

  // Estilo de la AppBar
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: tastyPink),
    titleTextStyle: GoogleFonts.poppins(
      color: tastyPink,
      fontSize: 18,
      fontWeight: FontWeight.w600,
    ),
  ),

  // Estilo de los botones
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: tastyPink,
      foregroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
);