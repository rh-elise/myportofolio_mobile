import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/screens/menu.dart';

/// Kartu aksi pada halaman utama.
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () async {
          // Konfirmasi dibutuhkan untuk aksi destruktif.
          if (item.requiresConfirmation) {
            // Hanya bernilai true jika pengguna menekan Confirm.
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
                      child: const Text('Batal'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.of(dialogContext).pop(true),
                      child: const Text('Konfirmasi'),
                    ),
                  ],
                );
              },
            );

            // Klik area luar dialog dibatalkan.
            if (confirmed != true) return;
          }

          // Pastikan widget masih terpasang setelah await.
          if (!context.mounted) return;

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Anda menekan tombol ${item.name}!'),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16.0),
                action: SnackBarAction(
                  label: 'Tutup',
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ),
            );

          // Tujuan navigasi dari item.page. Push menambah halaman baru,
          // tombol Back kembali ke menu utama.
          final destination = item.page;
          if (destination != null) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );
          }
        },
        child: Container(
          padding: const EdgeInsets.all(8),
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