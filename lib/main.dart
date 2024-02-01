import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:places/screens/places.dart';

import 'theme/body_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.background,
        textTheme:GoogleFonts.aboretoTextTheme().copyWith(
          titleSmall: GoogleFonts.aboreto(
            fontWeight: FontWeight.bold,
          ),
          titleMedium: GoogleFonts.aboreto(
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.aboreto(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const PlacesScreen(),
    );
  }
}
