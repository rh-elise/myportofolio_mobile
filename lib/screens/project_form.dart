import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';

// Token warna dari static/css/style.css pada website portofolio.
const _ink = Color(0xFF151515);
const _paper = Color(0xFFFFFFFF);
const _accent = Color(0xFFEB1000);
const _hint = Color(0xFF9CA3AF);
const _errorText = Color(0xFF9B0A00);

/// Halaman formulir penambahan proyek (materi Tutorial 09).
///
/// Komponen dan gaya mengikuti form project pada website Django:
/// judul miring merah, kartu form bergaris tebal, serta field
/// title, description, cover, dan link.
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
    // reset() hanya mengembalikan tampilan field ke nilai awal; variabel
    // state ikut dikosongkan agar dialog berikutnya tidak memakai data lama.
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: const BorderSide(color: _ink, width: 3.0),
          ),
          title: const Text(
            'Project added.',
            style: TextStyle(fontWeight: FontWeight.w900, color: _ink),
          ),
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
            _BrutalButton(
              label: 'OK',
              primary: true,
              onPressed: () {
                Navigator.of(dialogContext).pop();
                _resetForm();
              },
            ),
          ],
        );
      },
    );
  }

  /// Dekorasi field: kotak bersudut tegas dengan garis tinta 3px,
  /// sama seperti `.form-group input` pada website.
  InputDecoration _decoration(String hintText) {
    const border = OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: _ink, width: 3.0),
    );

    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(
        color: _hint,
        fontWeight: FontWeight.w400,
        fontSize: 14.0,
      ),
      filled: true,
      fillColor: _paper,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 14.0,
      ),
      border: border,
      enabledBorder: border,
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: _accent, width: 3.0),
      ),
      errorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: _accent, width: 3.0),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.zero,
        borderSide: BorderSide(color: _accent, width: 3.0),
      ),
      errorStyle: const TextStyle(
        color: _errorText,
        fontWeight: FontWeight.w700,
        fontSize: 12.5,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Project',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        // Isi formulir dapat digulir agar semua field dan tombol tetap
        // terjangkau di layar sempit atau saat keyboard muncul.
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: const EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(child: _SlantedTitle('ADD NEW PROJECTS')),
              const SizedBox(height: 28.0),

              // Kartu form, meniru `.project-form-outer`.
              Container(
                padding: const EdgeInsets.fromLTRB(20.0, 22.0, 20.0, 26.0),
                decoration: BoxDecoration(
                  color: _paper,
                  border: Border.all(color: _ink, width: 3.0),
                  boxShadow: const [
                    BoxShadow(
                      color: _ink,
                      offset: Offset(6.0, 6.0),
                      blurRadius: 0.0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const _FieldLabel('PROJECT TITLE'),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      decoration: _decoration("What's the project called?"),
                      // Setiap perubahan isi field langsung disimpan ke state.
                      onChanged: (String? value) {
                        setState(() {
                          _title = value!;
                        });
                      },
                      // Validasi mengikuti ProjectForm di Django.
                      validator: (String? value) {
                        final text = value?.trim() ?? "";
                        if (text.isEmpty) {
                          return "Project title cannot be empty!";
                        }
                        if (text.length < 3) {
                          return "Title must be at least 3 characters.";
                        }
                        if (text.length > 255) {
                          return "Title must be at most 255 characters.";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18.0),

                    const _FieldLabel('PROJECT DESCRIPTION'),
                    TextFormField(
                      minLines: 3,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: _decoration(
                        "Tell a little story about this project...",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _description = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Project description cannot be empty!";
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 18.0),

                    const _FieldLabel('PROJECT COVER'),
                    TextFormField(
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.url,
                      decoration: _decoration(
                        "/static/img/project-cover.png or http(s)/URL",
                      ),
                      onChanged: (String? value) {
                        setState(() {
                          _cover = value!;
                        });
                      },
                      // Opsional, tetapi jika diisi harus path /static/ atau
                      // URL http(s), sama seperti clean_image di Django.
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

                    const SizedBox(height: 18.0),

                    const _FieldLabel('PROJECT LINK'),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      decoration: _decoration("https://your-project-link.com"),
                      onChanged: (String? value) {
                        setState(() {
                          _link = value!;
                        });
                      },
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

                    const SizedBox(height: 26.0),

                    // Data belum dikirim ke database; untuk sementara isian
                    // hanya ditampilkan lewat dialog ringkasan.
                    _FormActions(
                      onCancel: () => Navigator.of(context).maybePop(),
                      onSubmit: _submit,
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

/// Judul section miring dengan bayangan tegas, meniru `.slanted-title`.
class _SlantedTitle extends StatelessWidget {
  final String text;

  const _SlantedTitle(this.text);

  // CSS memakai skewX(-15deg); Flutter memakai radian.
  static const double _skew = -0.2618;

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewX(_skew),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28.0, vertical: 12.0),
        decoration: BoxDecoration(
          color: _accent,
          border: Border.all(color: _ink, width: 3.0),
          boxShadow: const [
            BoxShadow(color: _ink, offset: Offset(6.0, 6.0), blurRadius: 0.0),
          ],
        ),
        // Teks dimiringkan balik agar tetap tegak seperti `.slanted-title span`.
        child: Transform(
          transform: Matrix4.skewX(-_skew),
          child: Text(
            text,
            style: const TextStyle(
              color: _paper,
              fontSize: 18.0,
              fontWeight: FontWeight.w900,
              letterSpacing: 3.0,
            ),
          ),
        ),
      ),
    );
  }
}

/// Label uppercase tebal di atas field, meniru `.form-group label`.
class _FieldLabel extends StatelessWidget {
  final String text;

  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: _ink,
          fontSize: 13.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

/// Deretan tombol Cancel dan Add Project, meniru `.form-actions`.
///
/// Di layar sempit tombol ditumpuk dengan Add Project di atas, sama seperti
/// media query website pada lebar 600px.
class _FormActions extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;

  const _FormActions({required this.onCancel, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cancel = _BrutalButton(
          label: 'Cancel',
          primary: false,
          onPressed: onCancel,
        );
        final submit = _BrutalButton(
          label: 'Add Project',
          primary: true,
          onPressed: onSubmit,
        );

        if (constraints.maxWidth < 420.0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [submit, const SizedBox(height: 12.0), cancel],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [cancel, const SizedBox(width: 14.0), submit],
        );
      },
    );
  }
}

/// Tombol bergaris tebal dengan bayangan keras, meniru `.form-submit` dan
/// `.form-cancel`.
class _BrutalButton extends StatelessWidget {
  final String label;
  final bool primary;
  final VoidCallback onPressed;

  const _BrutalButton({
    required this.label,
    required this.primary,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final style = ButtonStyle(
      elevation: const WidgetStatePropertyAll(0.0),
      shape: const WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      ),
      side: const WidgetStatePropertyAll(BorderSide(color: _ink, width: 3.0)),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 20.0, vertical: 14.0),
      ),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        final active =
            states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.pressed);
        if (primary) return active ? _accent : _ink;
        return active ? _ink : _paper;
      }),
      foregroundColor: WidgetStateProperty.resolveWith((states) {
        if (primary) return _paper;
        final active =
            states.contains(WidgetState.hovered) ||
            states.contains(WidgetState.pressed);
        return active ? _paper : _ink;
      }),
    );

    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(color: _ink, offset: Offset(4.0, 4.0), blurRadius: 0.0),
        ],
      ),
      child: primary
          ? FilledButton(style: style, onPressed: onPressed, child: Text(label))
          : OutlinedButton(
              style: style,
              onPressed: onPressed,
              child: Text(label),
            ),
    );
  }
}
