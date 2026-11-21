import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/theme/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyPortfolio',
      debugShowCheckedModeBanner: false,
      // Satu tema untuk seluruh layar agar palet dan sudut tetap konsisten.
      theme: AppTheme.light,
      home: const MyHomePage(),
    );
  }
}
