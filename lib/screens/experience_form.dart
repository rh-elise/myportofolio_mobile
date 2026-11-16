import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir penambahan pengalaman (Experience).
///
/// Isian mengikuti model `Experience` pada website Django: judul,
/// deskripsi, kategori, tahun, thumbnail, dan status.
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  // Dipakai untuk memvalidasi seluruh field sekaligus saat Save ditekan.
  final _formKey = GlobalKey<FormState>();

  // Controller hanya dipakai untuk field tahun karena nilainya diisi lewat
  // date picker, bukan diketik langsung.
  final _yearController = TextEditingController();

  String _title = "";
  String _description = "";
  String _category = "Full-Time";
  String _thumbnail = "";
  bool _isOngoing = true;

  /// Pilihan kategori mengikuti `Experience.Category` pada `main/models.py`.
  final List<String> _categories = const [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
  ];

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }

  /// Membuka pemilih tahun dan mengambil `picked.year`, sesuai atribut
  /// `year` pada model yang berupa bilangan bulat.
  Future<void> _pickYear() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime(now.year),
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year + 5),
      initialDatePickerMode: DatePickerMode.year,
      helpText: 'Pick experience year',
    );

    if (picked == null) return;

    setState(() {
      _yearController.text = '${picked.year}';
    });
  }

  /// Mengosongkan formulir setelah ringkasan ditutup.
  void _resetForm() {
    // reset() hanya mengembalikan tampilan field; state dan controller
    // ikut dikosongkan agar dialog berikutnya tidak memakai data lama.
    _formKey.currentState!.reset();
    _yearController.clear();
    setState(() {
      _title = "";
      _description = "";
      _category = "Full-Time";
      _thumbnail = "";
      _isOngoing = true;
    });
  }

  /// Menampilkan ringkasan isian hanya jika seluruh validasi lolos.
  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Experience added.'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: $_title'),
                Text('Description: $_description'),
                Text('Category: $_category'),
                Text('Year: ${_yearController.text}'),
                Text('Status: ${_isOngoing ? "Ongoing" : "Completed"}'),
                Text('Thumbnail: ${_thumbnail.isEmpty ? "-" : _thumbnail}'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _resetForm();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Experience',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      // Drawer yang sama dipakai di semua halaman agar menu tetap konsisten.
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        // Isi formulir dapat digulir agar semua field dan tombol Save tetap
        // terjangkau di layar sempit atau saat keyboard muncul.
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  hintText: "e.g. Bangkit Academy 2026",
                  labelText: "Experience Title",
                  helperText: "3-255 karakter",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                // Setiap perubahan isi field langsung disimpan ke state.
                onChanged: (String? value) {
                  setState(() {
                    _title = value!;
                  });
                },
                // Mengembalikan pesan error; null berarti isian valid.
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Experience title cannot be empty!";
                  }
                  if (value.trim().length < 3) {
                    return "Experience title must be at least 3 characters.";
                  }
                  if (value.trim().length > 255) {
                    return "Experience title must be at most 255 characters.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Describe your role and responsibilities",
                  labelText: "Experience Description",
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _description = value!;
                  });
                },
                // Mengembalikan pesan error; null berarti isian valid.
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Experience description cannot be empty!";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Experience Category",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                // initialValue dipakai karena value sudah deprecated.
                initialValue: _category,
                items: _categories
                    .map(
                      (category) => DropdownMenuItem(
                        value: category,
                        child: Text(category),
                      ),
                    )
                    .toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _category = newValue!;
                  });
                },
              ),

              const SizedBox(height: 16.0),

              TextFormField(
                controller: _yearController,
                readOnly: true,
                // readOnly + onTap membuat field ini hanya bisa diisi lewat
                // date picker, sehingga formatnya selalu berupa angka tahun.
                onTap: _pickYear,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Pick a year",
                  labelText: "Experience Year",
                  suffixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please pick a year for this experience.";
                  }
                  final year = int.tryParse(value.trim());
                  final maxYear = DateTime.now().year + 5;
                  if (year == null || year < 1950 || year > maxYear) {
                    return "Year must be between 1950 and $maxYear.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16.0),

              TextFormField(
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: "/static/img/experience-cover.png or https://...",
                  labelText: "Experience Thumbnail",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                onChanged: (String? value) {
                  setState(() {
                    _thumbnail = value!;
                  });
                },
                // Opsional, tetapi jika diisi harus path /static/ atau URL
                // http(s), sama seperti validasi ExperienceForm di Django.
                validator: (String? value) {
                  final text = value?.trim() ?? "";
                  if (text.isEmpty) {
                    return null;
                  }
                  final uri = Uri.tryParse(text);
                  final isStaticPath = text.startsWith("/static/");
                  final isHttpUrl =
                      uri != null &&
                      (uri.scheme == "http" || uri.scheme == "https") &&
                      uri.host.isNotEmpty;
                  if (!isStaticPath && !isHttpUrl) {
                    return "Thumbnail must be a /static/ path or http(s) URL.";
                  }
                  return null;
                },
              ),

              const SizedBox(height: 8.0),

              // Status mengikuti `Experience.Status`: ongoing atau completed.
              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text("Experience Status"),
                subtitle: Text(_isOngoing ? "Ongoing" : "Completed"),
                value: _isOngoing,
                onChanged: (bool value) {
                  setState(() {
                    _isOngoing = value;
                  });
                },
              ),

              const SizedBox(height: 16.0),

              SizedBox(
                width: double.infinity,
                // Data belum dikirim ke database; untuk sementara isian hanya
                // ditampilkan lewat dialog ringkasan.
                child: FilledButton(
                  onPressed: _submit,
                  child: const Text('Save'),
                ),
              ),

              // Ruang ekstra di bawah agar tombol Save tidak tertutup
              // keyboard atau gesture bar perangkat.
              const SizedBox(height: 32.0),
            ],
          ),
        ),
      ),
    );
  }
}
