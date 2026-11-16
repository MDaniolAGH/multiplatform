import 'mood_entry.dart';

/// A band of mood scores that the history can be filtered by.
enum ScoreRange {
  all('All', 1, 10),
  low('1–4', 1, 4),
  okay('5–7', 5, 7),
  good('8–10', 8, 10);

  const ScoreRange(this.label, this.min, this.max);

  /// Text shown on the filter button.
  final String label;

  /// Lowest score in the band.
  final int min;

  /// Highest score in the band.
  final int max;

  /// Whether [score] falls inside this band.
  bool contains(int score) => score >= min && score <= max;
}

/// The entries whose score lies in [range], in their original order.
///
/// Returns a new list; [entries] itself is never changed.
List<MoodEntry> filterEntries(
  List<MoodEntry> entries, {
  ScoreRange range = ScoreRange.all,
}) {
  return [
    for (final entry in entries)
      if (range.contains(entry.score)) entry,
  ];
}
