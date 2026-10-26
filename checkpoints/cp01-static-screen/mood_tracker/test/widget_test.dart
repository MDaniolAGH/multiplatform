import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/data/sample_entries.dart';
import 'package:mood_tracker/main.dart';
import 'package:mood_tracker/widgets/mood_card.dart';

/// Renders the app in a window of the given logical size.
Future<void> pumpAppAt(WidgetTester tester, Size size) async {
  tester.view.physicalSize = size;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MoodTrackerApp());
}

void main() {
  testWidgets('shows the summary and every sample entry', (tester) async {
    // Tall enough that the ListView builds every card.
    await pumpAppAt(tester, const Size(400, 1600));

    expect(find.text('Mood Tracker'), findsOneWidget);
    expect(find.text('5'), findsOneWidget); // number of entries
    expect(find.text('6.8'), findsOneWidget); // average score
    expect(find.byType(MoodCard), findsNWidgets(sampleEntries.length));
    expect(find.text('Weekend hike with friends.'), findsOneWidget);
  });

  testWidgets('labels an entry without a note', (tester) async {
    await pumpAppAt(tester, const Size(400, 1600));

    expect(find.text('No note'), findsOneWidget);
  });

  testWidgets('lays out on a narrow phone without overflowing',
      (tester) async {
    // A RenderFlex overflow is reported as an error and fails the test.
    await pumpAppAt(tester, const Size(320, 640));

    expect(tester.takeException(), isNull);
    expect(find.byType(MoodCard), findsWidgets);
  });

  testWidgets('keeps content at a readable width on a wide window',
      (tester) async {
    await pumpAppAt(tester, const Size(1280, 800));

    final cardWidth = tester.getSize(find.byType(MoodCard).first).width;
    expect(cardWidth, lessThanOrEqualTo(640));
  });
}
