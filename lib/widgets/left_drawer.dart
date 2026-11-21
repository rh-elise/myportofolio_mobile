import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/theme/app_theme.dart';

/// Drawer bersama untuk halaman utama dan formulir.
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  /// Buka halaman dengan tutup drawer terlebih dahulu.
  void _openPage(BuildContext context, Widget page) {
    final navigator = Navigator.of(context);
    navigator.pop();
    navigator.push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header tinta dengan nama aplikasi.
          Container(
            color: AppColors.ink,
            padding: const EdgeInsets.fromLTRB(20.0, 28.0, 20.0, 22.0),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MyPortfolio',
                  style: TextStyle(
                    color: AppColors.paper,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.5,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  'Explore projects, experience, and artworks!',
                  style: TextStyle(
                    color: Color(0xCCFFFFFF),
                    fontSize: 12.0,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4.0),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // Pop drawer, lalu kembali ke halaman pertama.
            onTap: () {
              final navigator = Navigator.of(context);
              navigator.pop();
              navigator.popUntil((route) => route.isFirst);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_circle_outline),
            title: const Text('Add Project'),
            onTap: () => _openPage(context, const ProjectFormPage()),
          ),
          ListTile(
            leading: const Icon(Icons.work_outline),
            title: const Text('Add Experience'),
            onTap: () => _openPage(context, const ExperienceFormPage()),
          ),
        ],
      ),
    );
  }
}
