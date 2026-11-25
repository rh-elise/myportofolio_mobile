import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/screens/experience_list_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/utils/experience_labels.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/form_widgets.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

/// Halaman formulir penambahan pengalaman (Experience).
///
/// Field, label, placeholder, dan validasi mengikuti `ExperienceForm` pada
/// website Django, tetapi tampilannya dibuat lebih minimalis.
class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _yearController = TextEditingController();

  String _title = "";
  String _description = "";
  String _category = "Full-Time";
  String _thumbnail = "";
  String _status = "Ongoing";
  bool _isSubmitting = false;

  /// Urutan kategori mengikuti `Experience.Category` pada model Django.
  final List<String> _categories = const [
    'Internship',
    'Research',
    'Volunteer',
    'Part-Time',
    'Full-Time',
    'Freelance',
  ];

  static const _statuses = ['Ongoing', 'Completed'];

  @override
  void dispose() {
    _yearController.dispose();
    super.dispose();
  }

  /// Membuka pemilih tahun, lalu mengisi field tahun.
  Future<void> _pickYear() async {
    final now = DateTime.now();
    final current = int.tryParse(_yearController.text);
    final initial = (current != null && current >= 1950)
        ? DateTime(current)
        : DateTime(now.year);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(1950),
      lastDate: DateTime(now.year + 5),
      initialDatePickerMode: DatePickerMode.year,
    );
    if (picked == null) return;
    setState(() => _yearController.text = '${picked.year}');
  }

  /// Mengosongkan formulir setelah dialog ditutup.
  void _resetForm() {
    _formKey.currentState!.reset();
    _yearController.clear();
    setState(() {
      _title = "";
      _description = "";
      _category = "Full-Time";
      _thumbnail = "";
      _status = "Ongoing";
    });
  }

  /// Memvalidasi isian, lalu mengirim POST terautentikasi ke backend.
  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthState>();
    final api = context.read<ApiClient>();
    final messenger = ScaffoldMessenger.of(context);

    if (!await ensureLoggedIn(context)) return;
    if (!mounted) return;

    final token = auth.token;
    if (token == null) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Silakan login terlebih dahulu.')),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    final experience = Experience(
      title: _title.trim(),
      description: _description.trim(),
      // Form memakai label; API hanya menerima slug.
      category: ExperienceLabels.categorySlugs[_category]!,
      year: int.parse(_yearController.text),
      status: ExperienceLabels.statusSlugs[_status]!,
      thumbnail: _thumbnail.trim(),
    );

    try {
      await api.createExperience(experience, token: token);
      if (!mounted) return;

      final goToList = await showDialog<bool>(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Experience added.'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${experience.title}'),
                  Text('Description: ${experience.description}'),
                  Text('Category: $_category'),
                  Text('Year: ${experience.year}'),
                  Text('Status: $_status'),
                  Text(
                    'Thumbnail: '
                    '${experience.thumbnail.isEmpty ? "-" : experience.thumbnail}',
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: const Text('OK'),
              ),
              FilledButton(
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: const Text('View list'),
              ),
            ],
          );
        },
      );
      if (!mounted) return;

      if (goToList ?? false) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const ExperienceListScreen()),
        );
        return;
      }

      _resetForm();
    } on ApiException catch (error) {
      if (!mounted) return;

      // 403 = token tidak valid/dicabut (backend ini tidak memakai 401).
      if (error.statusCode == 401 || error.statusCode == 403) {
        await auth.logout();
        if (!mounted) return;
        final relogin = await ensureLoggedIn(context);
        if (!mounted) return;
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Text(
                relogin
                    ? 'Sesi berakhir. Tekan Add Experience sekali lagi.'
                    : 'Sesi berakhir. Silakan login.',
              ),
            ),
          );
        return;
      }

      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(_errorMessage(error))));
    } on Exception {
      if (!mounted) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            content: Text('Tidak dapat menghubungi server. Cek koneksi.'),
          ),
        );
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String _errorMessage(ApiException error) {
    if (error.statusCode == 400) {
      return 'Data ditolak server (400). Periksa kategori, tahun, dan status.';
    }
    return 'Gagal menyimpan pengalaman (HTTP ${error.statusCode}).';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Experience')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 40.0),
            child: FormSurface(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const FormSectionTitle('ADD NEW EXPERIENCE'),
                  const SizedBox(height: 24.0),

                  const FieldLabel('Experience Title'),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    maxLength: 255,
                    decoration: const InputDecoration(
                      hintText: "What's this experience called?",
                      counterText: '',
                    ),
                    onChanged: (String? value) =>
                        setState(() => _title = value ?? ''),
                    validator: (String? value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) {
                        return 'Experience title cannot be empty!';
                      }
                      if (text.length < 3) {
                        return 'Experience title must be at least 3 characters.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),

                  const FieldLabel('Experience Description'),
                  TextFormField(
                    minLines: 3,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      hintText: 'Tell a little about this experience...',
                    ),
                    onChanged: (String? value) =>
                        setState(() => _description = value ?? ''),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Experience description cannot be empty!';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),

                  const FieldLabel('Experience Category'),
                  DropdownButtonFormField<String>(
                    initialValue: _category,
                    isExpanded: true,
                    borderRadius: BorderRadius.zero,
                    items: _categories.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Text(category),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() => _category = value ?? 'Full-Time');
                    },
                  ),
                  const SizedBox(height: 20.0),

                  const FieldLabel('Experience Year'),
                  TextFormField(
                    controller: _yearController,
                    readOnly: true,
                    onTap: _pickYear,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    validator: (String? value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) {
                        return 'Please pick a year for this experience.';
                      }
                      final year = int.tryParse(text);
                      if (year == null ||
                          year < 1950 ||
                          year > DateTime.now().year + 5) {
                        return 'Year must be between 1950 and ${DateTime.now().year + 5}.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),

                  const FieldLabel('Experience Thumbnail'),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.url,
                    decoration: const InputDecoration(
                      hintText:
                          '/static/img/experience-cover.png or http(s) URL',
                    ),
                    onChanged: (String? value) =>
                        setState(() => _thumbnail = value ?? ''),
                    // Sama seperti clean_thumbnail: opsional, tetapi jika
                    // diisi harus path /static/ atau URL http(s).
                    validator: (String? value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) return null;
                      if (!text.startsWith('/static/') &&
                          !text.startsWith('http')) {
                        return 'Thumbnail must be a /static/ path or http(s) URL.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),

                  const FieldLabel('Experience Status'),
                  DropdownButtonFormField<String>(
                    initialValue: _status,
                    isExpanded: true,
                    borderRadius: BorderRadius.zero,
                    items: _statuses.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status),
                      );
                    }).toList(),
                    onChanged: (String? value) {
                      setState(() => _status = value ?? 'Ongoing');
                    },
                  ),
                  const SizedBox(height: 28.0),

                  FormActions(
                    submitLabel: _isSubmitting ? 'Saving...' : 'Save',
                    onSubmit: () {
                      if (!_isSubmitting) _submit();
                    },
                    onCancel: () => Navigator.of(context).maybePop(),
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
