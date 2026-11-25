import 'package:flutter/material.dart';

/// Satu tombol aksi pada halaman utama.
class ItemHomepage {
  final String name;
  final IconData icon;

  /// Warna ikon. Nilainya dibatasi ke palet website (ink, accent, accentDark).
  final Color color;

  /// Aksi destruktif memerlukan konfirmasi sebelum dijalankan.
  final bool requiresConfirmation;

  /// Halaman tujuan saat kartu ditekan. Jika null, kartu hanya menampilkan
  /// SnackBar.
  final Widget? page;

  const ItemHomepage(
    this.name,
    this.icon,
    this.color, {
    this.requiresConfirmation = false,
    this.page,
  });
}
