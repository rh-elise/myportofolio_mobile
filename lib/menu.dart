import 'package:flutter/material.dart';

class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;
  final bool requiresConfirmation;

  const ItemHomepage(
    this.name,
    this.icon,
    this.color, {
    this.requiresConfirmation = false,
  });
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  final String npm = "2506600801";
  final String name = "Rheina Uliana";
  final String className = "PBP A";

  // Palet dari static/css/style.css: accent, ink, accent dark.
  final List<ItemHomepage> items = const [
    ItemHomepage("View Projects", Icons.folder, Color(0xFFEB1000)),
    ItemHomepage("Add Project", Icons.add_circle, Color(0xFF151515)),
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
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InfoCard(title: 'NPM', content: npm),
                  InfoCard(title: 'Name', content: name),
                  InfoCard(title: 'Class', content: className),
                ],
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
                        final columns = constraints.maxWidth < 600 ? 3 : 4;
                        return GridView.count(
                          crossAxisCount: columns,
                          shrinkWrap: true,
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
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

class InfoCard extends StatelessWidget {
  final String title;
  final String content;

  const InfoCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Container(
        // Dibagi 3.5 agar tiga kartu tetap muat sejajar di layar kecil.
        width: MediaQuery.of(context).size.width / 3.5,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8.0),
            Text(content),
          ],
        ),
      ),
    );
  }
}

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
          // Aksi destruktif perlu konfirmasi.
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

            // Tap di luar dialog dianggap batal.
            if (confirmed != true) return;
          }

          // Context bisa tidak valid lagi setelah await.
          if (!context.mounted) return;

          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text('Kamu telah menekan tombol ${item.name}!'),
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
