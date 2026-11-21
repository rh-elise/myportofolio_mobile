import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/form_widgets.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

/// Halaman formulir penambahan proyek.
///
/// Field, label, placeholder, dan validasi mengikuti `ProjectForm` pada
/// website Django, tetapi tampilannya dibuat lebih minimalis.
class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  // Dipakai untuk memvalidasi seluruh field sekaligus saat Add Project ditekan.
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _cover = "";
  String _link = "";

  void _resetForm() {
    // reset() mengembalikan tampilan field; state ikut dikosongkan agar dialog
    // berikutnya tidak memakai data lama.
    _formKey.currentState!.reset();
    setState(() {
      _title = "";
      _description = "";
      _cover = "";
      _link = "";
    });
  }

  /// Menampilkan ringkasan isian hanya jika seluruh validasi lolos.
  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Project added.'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title: $_title'),
                Text('Description: $_description'),
                Text('Cover: ${_cover.isEmpty ? "-" : _cover}'),
                Text('Link: ${_link.isEmpty ? "-" : _link}'),
              ],
            ),
          ),
          actions: [
            FilledButton(
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
      appBar: AppBar(title: const Text('Add Project')),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        // Isi formulir dapat digulir agar semua field dan tombol tetap
        // terjangkau di layar sempit atau saat keyboard muncul.
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(20.0, 24.0, 20.0, 40.0),
          child: FormSurface(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const FormSectionTitle('ADD NEW PROJECT'),
                const SizedBox(height: 24.0),

                const FieldLabel('PROJECT TITLE'),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  maxLength: 255,
                  decoration: const InputDecoration(
                    hintText: "What's the project called?",
                    counterText: '',
                  ),
                  onChanged: (String? value) =>
                      setState(() => _title = value ?? ''),
                  // Validasi mengikuti ProjectForm di Django.
                  validator: (String? value) {
                    final text = value?.trim() ?? "";
                    if (text.isEmpty) {
                      return "Project title cannot be empty!";
                    }
                    if (text.length < 3) {
                      return "Title must be at least 3 characters.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                const FieldLabel('PROJECT DESCRIPTION'),
                TextFormField(
                  minLines: 3,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                    hintText: 'Tell a little story about this project...',
                  ),
                  onChanged: (String? value) =>
                      setState(() => _description = value ?? ''),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Project description cannot be empty!";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                const FieldLabel('PROJECT COVER'),
                TextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    hintText: '/static/img/project-cover.png or http(s)/URL',
                  ),
                  onChanged: (String? value) =>
                      setState(() => _cover = value ?? ''),
                  // Opsional, tetapi jika diisi harus path /static/ atau URL
                  // http(s), sama seperti clean_image di Django.
                  validator: (String? value) {
                    final text = value?.trim() ?? "";
                    if (text.isEmpty) return null;
                    if (!text.startsWith("/static/") &&
                        !text.startsWith("http")) {
                      return "Cover must be a /static/... path or http(s) URL.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),

                const FieldLabel('PROJECT LINK'),
                TextFormField(
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.url,
                  decoration: const InputDecoration(
                    hintText: 'https://your-project-link.com',
                  ),
                  onChanged: (String? value) =>
                      setState(() => _link = value ?? ''),
                  validator: (String? value) {
                    final text = value?.trim() ?? "";
                    if (text.isEmpty) return null;
                    final uri = Uri.tryParse(text);
                    final isHttpUrl =
                        uri != null &&
                        (uri.scheme == "http" || uri.scheme == "https") &&
                        uri.host.isNotEmpty;
                    if (!isHttpUrl) {
                      return "Project link must be a valid http(s) URL.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 28.0),

                // Data belum dikirim ke database; untuk sementara isian hanya
                // ditampilkan lewat dialog ringkasan.
                FormActions(
                  submitLabel: 'Add Project',
                  onSubmit: _submit,
                  onCancel: () => Navigator.of(context).maybePop(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
