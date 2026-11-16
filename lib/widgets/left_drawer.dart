import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

/// Drawer yang dipakai bersama oleh halaman utama dan halaman formulir,
/// sehingga isi menu tidak pernah berbeda antar halaman.
class LeftDrawer extends StatelessWidget {
  const LeftDrawer({super.key});

  /// Menutup drawer lalu membuka [page] di atas halaman saat ini.
  void _openPage(BuildContext context, Widget page) {
    final navigator = Navigator.of(context);
    navigator.pop(); // tutup drawer lebih dulu
    navigator.push(MaterialPageRoute(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          // Header memakai warna ink agar tetap kontras dengan AppBar merah.
          // Teks dibatasi jumlah barisnya agar tidak overflow di layar
          // sempit maupun saat orientasi lanskap.
          const DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF151515)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'MyPortfolio',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Flexible(
                  child: Text(
                    'Explore projects, experience, and artworks!',
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home_outlined),
            title: const Text('Home'),
            // pop menutup drawer, lalu popUntil membuang semua halaman di
            // atas Home sehingga halaman utama tidak dibuat ulang.
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
