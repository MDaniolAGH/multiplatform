import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/data/sample_entries.dart';
import 'package:mood_tracker/models/mood_entry.dart';

void main() {
  group('averageScore', () {
    test('is null when there are no entries', () {
      expect(averageScore([]), isNull);
    });

    test('is the mean of all scores', () {
      // Sample scores: 8, 4, 6, 9, 7.
      expect(averageScore(sampleEntries), closeTo(6.8, 1e-9));
    });
  });

  test('rejects a score outside 1-10', () {
    expect(
      () => MoodEntry(score: 11, createdAt: DateTime(2026, 10, 1)),
      throwsA(isA<AssertionError>()),
    );
    expect(
      () => MoodEntry(score: 0, createdAt: DateTime(2026, 10, 1)),
      throwsA(isA<AssertionError>()),
    );
  });
}
