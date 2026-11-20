// Widget test untuk halaman menu dan alur formulir.
//
// Memastikan data pemilik tampil, navigasi ke formulir berjalan, validasi
// aktif, dan dialog ringkasan hanya muncul setelah semua isian valid.

import 'package:flutter/material.dart';
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

  testWidgets('Home page shows all action cards', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    const labels = [
      'View Projects',
      'View Experience',
      'View Artworks',
      'Add Project',
      'Add Experience',
      'Logout',
    ];

    for (final label in labels) {
      expect(find.text(label), findsOneWidget);
    }
  });

  testWidgets('Add Project card opens the form page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    // Label field mengikuti form project pada website.
    expect(find.text('PROJECT TITLE'), findsOneWidget);
    expect(find.text('PROJECT DESCRIPTION'), findsOneWidget);
    expect(find.text('PROJECT COVER'), findsOneWidget);
    expect(find.text('PROJECT LINK'), findsOneWidget);
  });

  testWidgets('Project form rejects empty input', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    // SnackBar dari halaman menu menutupi tombol submit, jadi ditutup lebih
    // dulu.
    await _dismissSnackBar(tester);
    await _submitProjectForm(tester);

    expect(find.text('Project title cannot be empty!'), findsOneWidget);
    expect(find.text('Project description cannot be empty!'), findsOneWidget);
  });

  testWidgets('Project form rejects a cover that is not a URL', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    await _dismissSnackBar(tester);

    // Urutan field: title, description, cover, link.
    await tester.enterText(_field(2), 'bukan url');
    await tester.pumpAndSettle();

    await _submitProjectForm(tester);

    expect(
      find.text('Cover must be a /static/... path or http(s) URL.'),
      findsOneWidget,
    );
  });

  testWidgets('Project form shows the summary dialog after a valid submit', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();
    await _dismissSnackBar(tester);

    await tester.enterText(_field(0), 'Portofolio Mobile');
    await tester.enterText(
      _field(1),
      'Aplikasi Flutter yang terhubung dengan website portofolio.',
    );
    await tester.enterText(_field(2), '/static/img/project-cover.png');
    await tester.enterText(_field(3), 'https://example.com/project');
    await tester.pumpAndSettle();

    await _submitProjectForm(tester);

    expect(find.text('Project added.'), findsOneWidget);
    expect(find.text('Title: Portofolio Mobile'), findsOneWidget);
    expect(find.text('Cover: /static/img/project-cover.png'), findsOneWidget);
    expect(find.text('Link: https://example.com/project'), findsOneWidget);
  });

  testWidgets('Add Experience card opens the experience form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();

    expect(find.text('Experience Title'), findsOneWidget);
    expect(find.text('Experience Thumbnail'), findsOneWidget);
  });

  testWidgets('Experience form rejects empty input', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();
    await _dismissSnackBar(tester);

    await tester.ensureVisible(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Experience title cannot be empty!'), findsOneWidget);
    expect(
      find.text('Experience description cannot be empty!'),
      findsOneWidget,
    );
    expect(
      find.text('Please pick a year for this experience.'),
      findsOneWidget,
    );
  });

  testWidgets('Experience form rejects a thumbnail that is not a URL', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();
    await _dismissSnackBar(tester);

    await tester.enterText(_field(3), 'bukan url');
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(
      find.text('Thumbnail must be a /static/ path or http(s) URL.'),
      findsOneWidget,
    );
  });

  testWidgets('Experience form shows the summary dialog after a valid submit', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();
    await _dismissSnackBar(tester);

    await tester.enterText(_field(0), 'Bangkit Academy 2026');
    await tester.enterText(
      _field(1),
      'Mengikuti program mobile development selama satu semester.',
    );
    await tester.enterText(_field(3), '/static/img/experience-cover.png');
    await tester.pumpAndSettle();

    // Field tahun hanya bisa diisi lewat date picker.
    await tester.tap(_field(2));
    await tester.pumpAndSettle();
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Experience added.'), findsOneWidget);
    expect(find.text('Title: Bangkit Academy 2026'), findsOneWidget);
    expect(find.text('Status: Ongoing'), findsOneWidget);
    expect(
      find.text('Thumbnail: /static/img/experience-cover.png'),
      findsOneWidget,
    );
  });

  testWidgets('Experience form rejects a title shorter than 3 characters', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();
    await _dismissSnackBar(tester);

    await tester.enterText(_field(0), 'ab');
    await tester.pumpAndSettle();

    await tester.ensureVisible(find.text('Save'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(
      find.text('Experience title must be at least 3 characters.'),
      findsOneWidget,
    );
  });

  testWidgets('Home option in the drawer returns to the home page', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MyApp());

    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Open navigation menu'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Home'));
    await tester.pumpAndSettle();

    expect(find.text('Welcome to MyPortfolio Mobile!'), findsOneWidget);
  });

  testWidgets('Experience form stays usable on a narrow phone screen', (
    WidgetTester tester,
  ) async {
    // Ukuran layar ponsel agar tata letak sempit ikut diuji.
    tester.view.physicalSize = const Size(375, 667);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MyApp());

    await tester.ensureVisible(find.text('Add Experience'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();
    await _dismissSnackBar(tester);

    // Tombol Save harus tetap bisa dijangkau dengan menggulir.
    await tester.ensureVisible(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Save'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

/// Mengambil TextFormField berdasarkan urutan kemunculannya di halaman
/// formulir.
///
/// Urutan pada formulir project: title, description, cover, link.
/// Urutan pada formulir pengalaman: title, description, year, thumbnail.
Finder _field(int index) => find.byType(TextFormField).at(index);

/// Menekan tombol submit pada formulir project.
///
/// Tombol dicari lewat tipe agar tidak bentrok dengan judul "Add Project"
/// pada AppBar.
Future<void> _submitProjectForm(WidgetTester tester) async {
  final submit = find.widgetWithText(FilledButton, 'Add Project');
  await tester.ensureVisible(submit);
  await tester.pumpAndSettle();
  await tester.tap(submit);
  await tester.pumpAndSettle();
}

/// Menutup SnackBar yang muncul dari halaman menu agar tidak menutupi
/// tombol di bagian bawah formulir.
Future<void> _dismissSnackBar(WidgetTester tester) async {
  final dismiss = find.text('Dismiss');
  if (dismiss.evaluate().isEmpty) return;

  await tester.tap(dismiss);
  await tester.pumpAndSettle();
}
