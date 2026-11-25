import 'package:flutter/material.dart';
import 'package:myportofolio_mobile/models/experience.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/theme/app_theme.dart';
import 'package:myportofolio_mobile/utils/experience_labels.dart';
import 'package:provider/provider.dart';

class ExperienceDetailScreen extends StatelessWidget {
  const ExperienceDetailScreen({required this.experience, super.key});

  final Experience experience;

  static const _sectionStyle = TextStyle(
    color: AppColors.textMuted,
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
  );

  @override
  Widget build(BuildContext context) {
    final baseUrl = context.read<ApiClient>().baseUrl;
    final thumbnailUrl = _resolveImageUrl(baseUrl);

    return Scaffold(
      appBar: AppBar(title: const Text('Experience Detail')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              experience.title,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 22,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.star_border,
                  size: 16,
                  color: AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  '${experience.starCount} stars',
                  style: const TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (thumbnailUrl != null) ...[
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.lineSoft, width: 2),
                      ),
                      child: const Text(
                        'Gambar tidak dapat dimuat.',
                        style: TextStyle(color: AppColors.hint, fontSize: 12),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
            _MetaRow(
              label: 'CATEGORY',
              value: ExperienceLabels.categoryLabel(experience.category),
            ),
            _MetaRow(label: 'YEAR', value: '${experience.year}'),
            _MetaRow(
              label: 'STATUS',
              value: ExperienceLabels.statusLabel(experience.status),
            ),
            _MetaRow(
              label: 'STARRED',
              value: experience.isStarred ? 'Yes' : 'No',
            ),
            if (experience.id != null)
              _MetaRow(label: 'ID', value: '${experience.id}'),
            const SizedBox(height: 20),
            Container(height: 2, color: AppColors.ink),
            const SizedBox(height: 12),
            const Text('DESCRIPTION', style: _sectionStyle),
            const SizedBox(height: 6),
            Text(
              experience.description,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 14,
                height: 1.6,
              ),
            ),
            if (experience.starredByNames.trim().isNotEmpty) ...[
              const SizedBox(height: 20),
              Container(height: 2, color: AppColors.ink),
              const SizedBox(height: 12),
              const Text('STARRED BY', style: _sectionStyle),
              const SizedBox(height: 6),
              Text(
                experience.starredByNames,
                style: const TextStyle(
                  color: AppColors.accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  /// `thumbnail` bisa berupa path relatif (`/static/...`) atau URL penuh.
  String? _resolveImageUrl(String baseUrl) {
    final raw = experience.thumbnail.trim();
    if (raw.isEmpty) return null;
    if (raw.startsWith('http://') || raw.startsWith('https://')) return raw;
    if (raw.startsWith('/')) return '$baseUrl$raw';
    return null;
  }
}

class _MetaRow extends StatelessWidget {
  const _MetaRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 92,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 1,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.ink,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
