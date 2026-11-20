import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

// Warna dari website portofolio: --ink, --paper, --accent
const _ink = Color(0xFF151515);
const _paper = Color(0xFFFFFFFF);
const _accent = Color(0xFFEB1000);
const _textMuted = Color(0xFF374151);

/// Satu tombol aksi pada halaman utama.
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  /// Aksi destruktif memerlukan konfirmasi sebelum dijalankan.
  final bool requiresConfirmation;

  /// Halaman tujuan yang dibuka saat kartu ditekan. Jika null, kartu hanya
  /// menampilkan SnackBar, misalnya View Projects yang belum punya halaman
  /// tujuan.
  final Widget? page;

  const ItemHomepage(
    this.name,
    this.icon,
    this.color, {
    this.requiresConfirmation = false,
    this.page,
  });
}

/// Halaman utama: identitas pemilik portofolio dan kartu aksi.
///
/// Desain minimalis: warna mengikuti website, tanpa ornamen,
/// tetris tetap bisa digunakan dengan 13 test yang ada.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = "2506600801";
  final String name = "Rheina Uliana";
  final String className = "PBP A";

  // Warna dari static/css/style.css: --accent, --ink, --text-muted, dan
  // accent dark (#9B0A00).
  final List<ItemHomepage> items = const [
    ItemHomepage("View Projects", Icons.folder, Color(0xFFEB1000)),
    ItemHomepage("View Experience", Icons.work_outline, Color(0xFF1D4ED8)),
    ItemHomepage("View Artworks", Icons.palette, Color(0xFF0F766E)),
    ItemHomepage(
      "Add Project",
      Icons.add_circle,
      Color(0xFF151515),
      page: ProjectFormPage(),
    ),
    ItemHomepage(
      "Add Experience",
      Icons.add_task,
      Color(0xFF374151),
      page: ExperienceFormPage(),
    ),
    ItemHomepage(
      "Logout",
      Icons.logout,
      Color(0xFF9B0A00),
      requiresConfirmation: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: _ink,
        foregroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: isMobile ? LeftDrawer() : null,

      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- Header warna ink di atas ---
            Container(
              color: _ink,
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                children: [
                  // Brand kiri
                  Text(
                    'MYPORTFOLIO',
                    style: const TextStyle(
                      color: _paper,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3.0,
                    ),
                  ),
                  const Spacer(),
                  // User info kanan
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Hi!',
                          style: TextStyle(
                            color: _paper,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.02,
                          ),
                        ),
                        SizedBox(height: 1.0),
                        Text(
                          'NPM 2506600801',
                          style: TextStyle(
                            color: _paper,
                            fontSize: 11.0,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            // --- Isi halaman ---
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Info identitas: NPM, Nama, Class
                    _InfoRow(
                      title: 'NPM',
                      content: '2506600801',
                      ink: _ink,
                      paper: _paper,
                    ),
                    const _InfoRow(
                      title: 'Name',
                      content: 'Rheina Uliana',
                      ink: _ink,
                      paper: _paper,
                    ),
                    const _InfoRow(
                      title: 'Class',
                      content: 'PBP A',
                      ink: _ink,
                      paper: _paper,
                    ),
                    const SizedBox(height: 24.0),

                    // Welcome text
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Welcome to MyPortfolio Mobile!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: _ink,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),

                    // Grid 6 kartu aksi
                    GridView.count(
                      crossAxisCount: isMobile ? 2 : 4,
                      shrinkWrap: true,
                      primary: false,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.1,
                      children: items.map((item) => ItemCard(item)).toList(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget baris info identitas (NPM, Name, Class).
class _InfoRow extends StatelessWidget {
  final String title;
  final String content;
  final Color ink;
  final Color paper;

  const _InfoRow({
    required this.title,
    required this.content,
    required this.ink,
    required this.paper,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: paper,
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13.0,
                color: _ink,
                letterSpacing: 0.8,
              ),
            ),
            const SizedBox(height: 6.0),
            Text(
              content,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w900,
                color: _ink,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Kartu aksi berwarna sesuai item.
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.zero,
      child: InkWell(
        onTap: () async {
          // Konfirmasi destruktif.
          if (item.requiresConfirmation) {
            final confirmed = await showDialog<bool>(
              context: context,
              builder: (dialogContext) {
                return AlertDialog(
                  title: Text(item.name),
                  content: Text(
                    'Are you sure you want to ${item.name.toLowerCase()}?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(dialogContext).pop(false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      child: const Text('Confirm'),
                    ),
                  ],
                );
              },
            );
            if (confirmed != true) return;
          }

          // SnackBar + navigasi.
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('You have clicked the ${item.name} button!'),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16.0),
                action: SnackBarAction(
                  label: 'Dismiss',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );

          // Navigasi ke halaman tujuan.
          final destination = item.page;
          if (destination != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
