import '../models/mood_entry.dart';

/// Hardcoded synthetic entries for the static home screen, newest first.
///
/// This is invented data, not real user data. The second entry has a long
/// note on purpose: it shows what happens to a layout on a narrow screen.
final List<MoodEntry> sampleEntries = [
  MoodEntry(
    score: 8,
    note: 'Finished the Dart lab early and went for a run.',
    createdAt: DateTime(2026, 10, 23, 19, 45),
  ),
  MoodEntry(
    score: 4,
    note: 'Tired after a long day: two lectures, a group project meeting, '
        'a lab that ran late and a tram that never seemed to arrive.',
    createdAt: DateTime(2026, 10, 22, 21, 10),
  ),
  MoodEntry(
    score: 6,
    createdAt: DateTime(2026, 10, 21, 18, 30),
  ),
  MoodEntry(
    score: 9,
    note: 'Weekend hike with friends.',
    createdAt: DateTime(2026, 10, 19, 17, 5),
  ),
  MoodEntry(
    score: 7,
    note: 'Productive morning in the library.',
    createdAt: DateTime(2026, 10, 18, 11, 20),
  ),
];
