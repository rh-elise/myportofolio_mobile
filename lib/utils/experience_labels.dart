/// Pemetaan label tampilan dengan slug yang diterima API Experience.
///
/// Form mengirim slug (`full-time`), sedangkan UI menampilkan label
/// (`Full-Time`). Dikumpulkan di satu tempat agar list, detail, dan form
/// tidak pernah berbeda nilai.
abstract final class ExperienceLabels {
  /// Label UI -> slug yang diterima `ExperienceSerializer`.
  static const Map<String, String> categorySlugs = {
    'Internship': 'internship',
    'Research': 'research',
    'Volunteer': 'volunteer',
    'Part-Time': 'part-time',
    'Full-Time': 'full-time',
    'Freelance': 'freelance',
  };

  /// Label UI -> slug status.
  static const Map<String, String> statusSlugs = {
    'Ongoing': 'ongoing',
    'Completed': 'completed',
  };

  static final Map<String, String> _categoryLabels = {
    for (final entry in categorySlugs.entries) entry.value: entry.key,
  };

  static final Map<String, String> _statusLabels = {
    for (final entry in statusSlugs.entries) entry.value: entry.key,
  };

  /// Slug -> label untuk ditampilkan; slug tak dikenal dikembalikan apa adanya.
  static String categoryLabel(String slug) => _categoryLabels[slug] ?? slug;

  /// Slug -> label untuk ditampilkan; slug tak dikenal dikembalikan apa adanya.
  static String statusLabel(String slug) => _statusLabels[slug] ?? slug;
}
