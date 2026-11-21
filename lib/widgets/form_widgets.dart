import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/theme/app_theme.dart';

/// Judul bagian formulir: teks tebal dengan garis aksen pendek di bawahnya.
class FormSectionTitle extends StatelessWidget {
  final String text;

  const FormSectionTitle(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            color: AppColors.ink,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
            letterSpacing: 0.8,
          ),
        ),
        const SizedBox(height: 10.0),
        Container(width: 44.0, height: 3.0, color: AppColors.accent),
      ],
    );
  }
}

/// Label field di atas input, mengikuti `.form-group label` pada website.
class FieldLabel extends StatelessWidget {
  final String text;

  const FieldLabel(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: AppColors.ink,
          fontSize: 12.5,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
    );
  }
}

/// Deretan tombol batal dan simpan yang menumpuk di layar sempit.
class FormActions extends StatelessWidget {
  final String submitLabel;
  final VoidCallback onSubmit;
  final VoidCallback onCancel;
  final String cancelLabel;

  const FormActions({
    required this.submitLabel,
    required this.onSubmit,
    required this.onCancel,
    this.cancelLabel = 'Cancel',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final submit = FilledButton(onPressed: onSubmit, child: Text(submitLabel));
    final cancel = OutlinedButton(
      onPressed: onCancel,
      child: Text(cancelLabel),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 420.0) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [submit, const SizedBox(height: 10.0), cancel],
          );
        }

        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [cancel, const SizedBox(width: 12.0), submit],
        );
      },
    );
  }
}

/// Pembungkus isi formulir: lebar maksimum dan jarak tepi yang konsisten.
class FormSurface extends StatelessWidget {
  final Widget child;

  const FormSurface({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560.0),
        child: child,
      ),
    );
  }
}
