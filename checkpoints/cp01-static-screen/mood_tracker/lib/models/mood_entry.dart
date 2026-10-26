/// A single mood log entry.
///
/// The class is immutable: every field is `final`. To change an entry, create
/// a new one.
class MoodEntry {
  const MoodEntry({
    required this.score,
    required this.createdAt,
    this.note,
  }) : assert(score >= 1 && score <= 10, 'score must be between 1 and 10');

  /// Mood score from 1 (worst) to 10 (best).
  final int score;

  /// Optional free-text note. `null` means the user wrote nothing.
  final String? note;

  /// When the entry was recorded.
  final DateTime createdAt;
}

/// The average score of [entries], or `null` when there are no entries.
double? averageScore(List<MoodEntry> entries) {
  if (entries.isEmpty) return null;
  final total = entries.fold<int>(0, (sum, entry) => sum + entry.score);
  return total / entries.length;
}
