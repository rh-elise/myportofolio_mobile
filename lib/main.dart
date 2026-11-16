import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        // Palet dari style.css.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEB1000),
          // AppBar pakai #EB1000 persis, bukan warna turunan fromSeed.
          primary: const Color(0xFFEB1000),
          secondary: const Color(0xFF151515),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
