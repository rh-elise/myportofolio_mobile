/// Pemetaan label UI ke slug API Experience.
///
/// Form mengirim slug (`full-time`), sedangkan list, detail, dan form
/// menampilkan label (`Full-Time`).
abstract final class ExperienceLabels {
  /// Label kategori -> slug.
  static const Map<String, String> categorySlugs = {
    'Internship': 'internship',
    'Research': 'research',
    'Volunteer': 'volunteer',
    'Part-Time': 'part-time',
    'Full-Time': 'full-time',
    'Freelance': 'freelance',
  };

  /// Label status -> slug.
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

  /// Slug kategori -> label; slug tak dikenal dikembalikan apa adanya.
  static String categoryLabel(String slug) => _categoryLabels[slug] ?? slug;

  /// Slug status -> label; slug tak dikenal dikembalikan apa adanya.
  static String statusLabel(String slug) => _statusLabels[slug] ?? slug;
}
