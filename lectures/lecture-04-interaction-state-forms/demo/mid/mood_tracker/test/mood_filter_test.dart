import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/data/sample_entries.dart';
import 'package:mood_tracker/models/mood_filter.dart';

void main() {
  // Sample scores, newest first: 8, 4, 6, 9, 7.
  List<int> scoresOf(ScoreRange range) => [
    for (final entry in filterEntries(sampleEntries, range: range)) entry.score,
  ];

  test('All keeps every entry in order', () {
    expect(scoresOf(ScoreRange.all), [8, 4, 6, 9, 7]);
  });

  test('each band keeps only its own scores', () {
    expect(scoresOf(ScoreRange.low), [4]);
    expect(scoresOf(ScoreRange.okay), [6, 7]);
    expect(scoresOf(ScoreRange.good), [8, 9]);
  });

  test('band edges are included', () {
    expect(ScoreRange.low.contains(4), isTrue);
    expect(ScoreRange.okay.contains(4), isFalse);
    expect(ScoreRange.okay.contains(5), isTrue);
    expect(ScoreRange.good.contains(10), isTrue);
  });

  test('filtering never changes the original list', () {
    final before = List.of(sampleEntries);
    filterEntries(sampleEntries, range: ScoreRange.low);
    expect(sampleEntries, before);
  });
}
