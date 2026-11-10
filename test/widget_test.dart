// Widget test dasar untuk halaman menu MyPortfolio.
//
// Memastikan aplikasi dapat dirender dan data pemilik portofolio tampil.

import 'package:flutter_test/flutter_test.dart';

import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('Halaman menu utama menampilkan data pemilik', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('2506600801'), findsOneWidget);
    expect(find.text('Rheina Uliana'), findsOneWidget);
    expect(find.text('PBP A'), findsOneWidget);
  });
}
