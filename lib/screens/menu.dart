import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

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
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = "2506600801";
  final String name = "Rheina Uliana";
  final String className = "PBP A";

  // Warna dari static/css/style.css: --accent, --ink, --text-muted, dan
  // accent dark (#9B0A00).
  final List<ItemHomepage> items = const [
    ItemHomepage("View Projects", Icons.folder, Color(0xFFEB1000)),
    ItemHomepage(
      "Add Project",
      Icons.add_circle,
      Color(0xFF151515),
      page: ProjectFormPage(),
    ),
    ItemHomepage(
      "Add Experience",
      Icons.work_outline,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'MyPortfolio',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // Ikon menu di AppBar muncul karena Scaffold punya drawer.
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final cards = [
                    InfoCard(title: 'NPM', content: npm),
                    InfoCard(title: 'Name', content: name),
                    InfoCard(title: 'Class', content: className),
                  ];

                  // Di layar sempit kartu ditumpuk agar teks identitas tetap
                  // terbaca utuh tanpa overflow.
                  if (constraints.maxWidth < 480) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        for (final card in cards)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: card,
                          ),
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(child: cards[0]),
                      const SizedBox(width: 8.0),
                      Expanded(child: cards[1]),
                      const SizedBox(width: 8.0),
                      Expanded(child: cards[2]),
                    ],
                  );
                },
              ),

              const SizedBox(height: 16.0),

              Center(
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0),
                      child: Text(
                        'Welcome to MyPortfolio Mobile!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                    ),

                    LayoutBuilder(
                      builder: (context, constraints) {
                        // Dua kolom di ponsel agar empat kartu tersusun
                        // rapi (2x2), empat kolom di layar lebar.
                        final columns = constraints.maxWidth < 600 ? 2 : 4;
                        return GridView.count(
                          crossAxisCount: columns,
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1.1,
                          children: items
                              .map((item) => ItemCard(item))
                              .toList(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Kartu berisi satu pasang judul dan isi, dipakai untuk NPM, nama, dan kelas.
class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    // Lebar mengikuti parent: Expanded di layar lebar, penuh saat ditumpuk di
    // layar sempit, sehingga teks identitas tidak memicu overflow.
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}