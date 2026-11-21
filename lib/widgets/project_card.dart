import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/theme/app_theme.dart';

/// Kartu aksi pada halaman utama: kotak putih bergaris tinta, tanpa bayangan.
class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  /// Menjalankan aksi kartu: konfirmasi (jika perlu), SnackBar, lalu navigasi.
  Future<void> _handleTap(BuildContext context) async {
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
      if (confirmed != true || !context.mounted) return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('You have clicked the ${item.name} button!'),
          margin: const EdgeInsets.all(16.0),
          action: SnackBarAction(
            label: 'Dismiss',
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );

    final destination = item.page;
    if (destination != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => destination),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.paper,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
        side: BorderSide(color: AppColors.ink, width: 2.0),
      ),
      child: InkWell(
        onTap: () => _handleTap(context),
        overlayColor: const WidgetStatePropertyAll(Color(0x14EB1000)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(item.icon, color: item.color, size: 28.0),
              const SizedBox(height: 10.0),
              Text(
                item.name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.ink,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
