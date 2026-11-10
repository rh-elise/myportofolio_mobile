import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/menu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      theme: ThemeData(
        // Palet mengikuti portofolio Django: aksen merah dan ink hitam.
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFEB1000),
          secondary: const Color(0xFF151515),
        ),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}
