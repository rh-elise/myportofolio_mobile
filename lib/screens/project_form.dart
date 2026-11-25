import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/project.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/form_widgets.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class ProjectFormPage extends StatefulWidget {
  const ProjectFormPage({super.key});

  @override
  State<ProjectFormPage> createState() => _ProjectFormPageState();
}

class _ProjectFormPageState extends State<ProjectFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = "";
  String _description = "";
  String _cover = "";
  String _link = "";
  bool _isSubmitting = false;

  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _title = "";
      _description = "";
      _cover = "";
      _link = "";
    });
  }

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

    final project = Project(
      title: _title.trim(),
      description: _description.trim(),
      image: _cover.trim(),
      link: _link.trim(),
    );

    try {
      await api.createProject(project, token: token);
      if (!mounted) return;

      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            title: const Text('Project added.'),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Title: ${project.title}'),
                  Text('Description: ${project.description}'),
                  Text('Cover: ${project.image.isEmpty ? "-" : project.image}'),
                  Text('Link: ${project.link.isEmpty ? "-" : project.link}'),
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
                    ? 'Sesi berakhir. Tekan Add Project sekali lagi.'
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
      return 'Data ditolak server (400). Cover wajib /static/... atau http(s).';
    }
    return 'Gagal menyimpan proyek (HTTP ${error.statusCode}).';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Project')),
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
                    // Backend mewajibkan image terisi, jadi cover wajib di sini.
                    validator: (String? value) {
                      final text = value?.trim() ?? "";
                      if (text.isEmpty) {
                        return "Project cover cannot be empty!";
                      }
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
                  FormActions(
                    submitLabel: _isSubmitting ? 'Saving...' : 'Add Project',
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
