import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/theme/app_theme.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:myportofolio_mobile/widgets/project_card.dart';

/// Halaman utama: identitas pemilik portofolio dan kartu aksi.
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = "2506600801";
  final String name = "Rheina Uliana";
  final String className = "PBP A";

  /// Aksi utama memakai aksen merah; aksi biasa memakai tinta.
  final List<ItemHomepage> items = const [
    ItemHomepage("View Projects", Icons.folder_outlined, AppColors.ink),
    ItemHomepage("View Experience", Icons.work_outline, AppColors.ink),
    ItemHomepage("View Artworks", Icons.palette_outlined, AppColors.ink),
    ItemHomepage(
      "Add Project",
      Icons.add_circle_outline,
      AppColors.accent,
      page: ProjectFormPage(),
    ),
    ItemHomepage(
      "Add Experience",
      Icons.add_task,
      AppColors.accent,
      page: ExperienceFormPage(),
    ),
    ItemHomepage(
      "Logout",
      Icons.logout,
      AppColors.accentDark,
      requiresConfirmation: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(title: const Text('MyPortfolio')),
      drawer: isMobile ? const LeftDrawer() : null,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 32.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 680.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Tabel identitas ringkas: label kecil, nilai tebal.
                  Container(height: 2.0, color: AppColors.ink),
                  _InfoRow(title: 'NPM', content: npm),
                  _InfoRow(title: 'Name', content: name),
                  _InfoRow(
                    title: 'Class',
                    content: className,
                    showDivider: false,
                  ),

                  const SizedBox(height: 24.0),
                  const Text(
                    'Welcome to MyPortfolio Mobile!',
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 6.0),
                  const Text(
                    'Projects, experience, and artworks in one place.',
                    style: TextStyle(
                      color: AppColors.textMuted,
                      fontSize: 13.0,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 20.0),

                  // Grid kartu aksi: 2 kolom di ponsel, 4 kolom di layar lebar.
                  GridView.count(
                    crossAxisCount: isMobile ? 2 : 4,
                    shrinkWrap: true,
                    primary: false,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 1.35,
                    children: items.map((item) => ItemCard(item)).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Baris identitas dengan garis pemisah tipis.
class _InfoRow extends StatelessWidget {
  final String title;
  final String content;
  final bool showDivider;

  const _InfoRow({
    required this.title,
    required this.content,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 13.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: showDivider ? AppColors.lineSoft : AppColors.ink,
            width: showDivider ? 1.0 : 2.0,
          ),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 76.0,
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 11.0,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Expanded(
            child: Text(
              content,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 16.0,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
