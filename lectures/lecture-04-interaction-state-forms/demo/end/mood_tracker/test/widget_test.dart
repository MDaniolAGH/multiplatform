import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/data/sample_entries.dart';
import 'package:mood_tracker/main.dart';
import 'package:mood_tracker/models/mood_entry.dart';
import 'package:mood_tracker/screens/home_screen.dart';
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

  testWidgets('lays out on a narrow phone without overflowing', (tester) async {
    // A RenderFlex overflow is reported as an error and fails the test.
    await pumpAppAt(tester, const Size(320, 640));

    expect(tester.takeException(), isNull);
    expect(find.byType(MoodCard), findsWidgets);
  });

  testWidgets('keeps content at a readable width on a wide window', (
    tester,
  ) async {
    await pumpAppAt(tester, const Size(1280, 800));

    final cardWidth = tester.getSize(find.byType(MoodCard).first).width;
    expect(cardWidth, lessThanOrEqualTo(640));
  });

  testWidgets('choosing 1–4 shows only low entries and updates the summary', (
    tester,
  ) async {
    await pumpAppAt(tester, const Size(400, 1600));

    await tester.tap(find.text('1–4'));
    await tester.pump();

    expect(find.byType(MoodCard), findsOneWidget);
    expect(find.text('4.0'), findsOneWidget); // average of the one entry left

    await tester.tap(find.text('All'));
    await tester.pump();

    expect(find.byType(MoodCard), findsNWidgets(sampleEntries.length));
  });

  testWidgets('searching notes narrows the history; clearing restores it', (
    tester,
  ) async {
    await pumpAppAt(tester, const Size(400, 1600));

    await tester.enterText(find.byType(TextField), 'hike');
    await tester.pump();

    expect(find.byType(MoodCard), findsOneWidget);
    expect(find.text('Weekend hike with friends.'), findsOneWidget);

    await tester.tap(find.byTooltip('Clear search'));
    await tester.pump();

    expect(find.byType(MoodCard), findsNWidgets(sampleEntries.length));
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      isEmpty,
    );
  });

  testWidgets('typed search text survives a rebuild of the screen', (
    tester,
  ) async {
    await pumpAppAt(tester, const Size(400, 1600));

    await tester.enterText(find.byType(TextField), 'lab');
    await tester.pump();
    // Changing the range rebuilds HomeScreen and the filter bar.
    await tester.tap(find.text('8–10'));
    await tester.pump();

    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      'lab',
    );
    expect(find.byType(MoodCard), findsOneWidget);
  });

  testWidgets('says so when no entry matches the filter', (tester) async {
    tester.view.physicalSize = const Size(400, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        home: HomeScreen(
          entries: [MoodEntry(score: 9, createdAt: DateTime(2026, 11, 1))],
        ),
      ),
    );

    await tester.tap(find.text('1–4'));
    await tester.pump();

    expect(find.byType(MoodCard), findsNothing);
    expect(find.text('No entries match this filter.'), findsOneWidget);
  });
}
