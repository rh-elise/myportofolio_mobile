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
        // Warna diambil dari website portofolio.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEB1000),
          primary: const Color(0xFFEB1000),
          secondary: const Color(0xFF151515),
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
