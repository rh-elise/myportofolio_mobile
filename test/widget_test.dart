// Test halaman menu, navigasi, validasi form, dan alur login.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

void main() {
  testWidgets('Home page shows the owner data', (WidgetTester tester) async {
    await tester.pumpWidget(_buildApp());

    expect(find.text('MyPortfolio'), findsOneWidget);
    expect(find.text('2506600801'), findsOneWidget);
    expect(find.text('Rheina Uliana'), findsOneWidget);
    expect(find.text('PBP A'), findsOneWidget);
  });

  testWidgets('Home page shows all action cards', (WidgetTester tester) async {
    await tester.pumpWidget(_buildApp());

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

  testWidgets('Add Project card asks for login before opening the form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await tester.tap(find.text('Add Project'));
    await tester.pumpAndSettle();

    // LoginScreen punya 2 field; form proyek punya 4 field.
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('PROJECT TITLE'), findsNothing);
  });

  testWidgets('Project form rejects empty input', (WidgetTester tester) async {
    await tester.pumpWidget(_buildApp());

    await _openProjectForm(tester);

    // SnackBar dari halaman menu menutupi tombol submit, jadi ditutup lebih
    // dulu.
    await _dismissSnackBar(tester);
    await _submitProjectForm(tester);

    expect(find.text('Project title cannot be empty!'), findsOneWidget);
    expect(find.text('Project description cannot be empty!'), findsOneWidget);
  });

  testWidgets('Project form shows the summary dialog after a valid submit', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _openProjectForm(tester);
    await _dismissSnackBar(tester);

    // Setelah login, form proyek terbuka otomatis.
    expect(find.text('PROJECT TITLE'), findsOneWidget);

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

  testWidgets('Add Experience card asks for login before opening the form', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await tester.tap(find.text('Add Experience'));
    await tester.pumpAndSettle();

    // LoginScreen punya 2 field; form pengalaman punya 4 field.
    expect(find.byType(TextFormField), findsNWidgets(2));
    expect(find.text('Experience Title'), findsNothing);
  });

  testWidgets('Experience form opens after a successful login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _openExperienceForm(tester);
    await _dismissSnackBar(tester);

    expect(find.text('Experience Title'), findsOneWidget);
    expect(find.text('Experience Thumbnail'), findsOneWidget);
  });

  testWidgets('Experience form rejects empty input', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildApp());

    await _openExperienceForm(tester);
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
    await tester.pumpWidget(_buildApp());

    await _openExperienceForm(tester);
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
    await tester.pumpWidget(_buildApp());

    await _openExperienceForm(tester);
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
    await tester.pumpWidget(_buildApp());

    await _openExperienceForm(tester);
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
    await tester.pumpWidget(_buildApp());

    await _openExperienceForm(tester);

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

    await tester.pumpWidget(_buildApp());

    await _openExperienceForm(tester);
    await _dismissSnackBar(tester);

    // Tombol Save harus tetap bisa dijangkau dengan menggulir.
    await tester.ensureVisible(find.text('Save'));
    await tester.pumpAndSettle();

    expect(find.text('Save'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

/// TextFormField ke-[index] pada form yang sedang terbuka.
///
/// Urutan field project: title, description, cover, link.
/// Urutan field experience: title, description, year, thumbnail.
Finder _field(int index) => find.byType(TextFormField).at(index);

/// Membuka form Add Project, melewati LoginScreen bila diminta.
Future<void> _openProjectForm(WidgetTester tester) async {
  await tester.tap(find.text('Add Project'));
  await tester.pumpAndSettle();

  if (find.text('PROJECT TITLE').evaluate().isNotEmpty) return;

  await tester.enterText(find.byType(TextFormField).at(0), 'owner');
  await tester.enterText(find.byType(TextFormField).at(1), 'secret');
  await tester.tap(find.widgetWithText(FilledButton, 'Login'));
  await tester.pumpAndSettle();
}

/// Membuka form Add Experience, melewati LoginScreen bila diminta.
Future<void> _openExperienceForm(WidgetTester tester) async {
  final card = find.text('Add Experience');
  await tester.ensureVisible(card);
  await tester.pumpAndSettle();
  await tester.tap(card);
  await tester.pumpAndSettle();

  if (find.text('Experience Title').evaluate().isNotEmpty) return;

  await tester.enterText(find.byType(TextFormField).at(0), 'owner');
  await tester.enterText(find.byType(TextFormField).at(1), 'secret');
  await tester.tap(find.widgetWithText(FilledButton, 'Login'));
  await tester.pumpAndSettle();
}

/// Menekan tombol submit pada form project. Dicari lewat tipe agar tidak
/// bentrok dengan judul "Add Project" di AppBar.
Future<void> _submitProjectForm(WidgetTester tester) async {
  final submit = find.widgetWithText(FilledButton, 'Add Project');
  await tester.ensureVisible(submit);
  await tester.pumpAndSettle();
  await tester.tap(submit);
  await tester.pumpAndSettle();
}

/// Menutup SnackBar dari halaman menu agar tidak menutupi tombol di bawah.
Future<void> _dismissSnackBar(WidgetTester tester) async {
  final dismiss = find.text('Dismiss');
  if (dismiss.evaluate().isEmpty) return;

  await tester.tap(dismiss);
  await tester.pumpAndSettle();
}

/// Membangun aplikasi dengan ApiClient palsu agar test tidak bergantung pada
/// server Django.
Widget _buildApp() {
  final client = MockClient((request) async {
    final path = request.url.path;

    if (path.endsWith('/auth/token/')) {
      return http.Response(
        '{"token": "test-token"}',
        200,
        headers: {'content-type': 'application/json'},
      );
    }

    if (request.method == 'POST' && path.contains('/experience/')) {
      return http.Response(
        '{"id": 5, "title": "Test", "description": "Test description", '
        '"category": "full-time", "thumbnail": null, "year": 2026, '
        '"status": "ongoing", "star_count": 0, "is_starred": false, '
        '"starred_by_names": ""}',
        201,
        headers: {'content-type': 'application/json'},
      );
    }

    if (request.method == 'POST') {
      return http.Response(
        '{"id": 1, "title": "Test", "description": "Test description", '
        '"image": "/static/img/test.png", "link": "", '
        '"star_count": 0, "is_starred": false}',
        201,
        headers: {'content-type': 'application/json'},
      );
    }

    return http.Response(
      '[]',
      200,
      headers: {'content-type': 'application/json'},
    );
  });

  return MyApp(apiClient: ApiClient(client: client));
}
