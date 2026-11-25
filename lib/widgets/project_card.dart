import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/item_homepage.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/theme/app_theme.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

/// Kartu aksi pada halaman utama: kotak putih bergaris tinta, tanpa bayangan.
///
/// Garis berubah merah saat kursor berada di atas kartu atau kartu ditekan.
class ItemCard extends StatefulWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool _highlighted = false;

  /// Menjalankan aksi kartu: konfirmasi (jika perlu), SnackBar, lalu navigasi.
  Future<void> _handleTap(BuildContext context) async {
    final item = widget.item;

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

    if (item.name == 'Logout') {
      final auth = context.read<AuthState>();
      final messenger = ScaffoldMessenger.of(context);
      await auth.logout();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(const SnackBar(content: Text('You have logged out.')));
      return;
    }

    final destination = item.page;

    if (destination is ProjectFormPage || destination is ExperienceFormPage) {
      final loggedIn = await ensureLoggedIn(context);
      if (!loggedIn || !context.mounted) return;
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

    if (destination == null) return;

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => destination),
    );
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    final borderColor = _highlighted ? AppColors.accent : AppColors.ink;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _highlighted = true),
      onExit: (_) => setState(() => _highlighted = false),
      child: Material(
        color: AppColors.paper,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: borderColor, width: 2.0),
        ),
        child: InkWell(
          onTap: () => _handleTap(context),
          onHighlightChanged: (value) => setState(() => _highlighted = value),
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
      ),
    );
  }
}
