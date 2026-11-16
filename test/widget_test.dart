// Test halaman menu dan alur tambah proyek.

import 'package:flutter_test/flutter_test.dart';

import 'package:myportofolio_mobile/main.dart';

void main() {
  testWidgets('Home page shows the owner data', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('2506600801'), findsOneWidget);
    expect(find.text('Rheina Uliana'), findsOneWidget);
    expect(find.text('PBP A'), findsOneWidget);
  });

  testWidgets('Add Project card opens the form page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    expect(find.text('Project URL (optional)'), findsOneWidget);
  });

  testWidgets('Form rejects empty input', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    // SnackBar dari halaman menu menutupi tombol Save, tutup dulu.
    await tester.tap(find.text('Dismiss'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Save'));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Project name cannot be empty!'), findsOneWidget);
    expect(find.text('Project description cannot be empty!'), findsOneWidget);
  });
}
