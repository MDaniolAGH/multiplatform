import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mood_tracker/data/sample_entries.dart';
import 'package:mood_tracker/main.dart';
import 'package:mood_tracker/widgets/mood_card.dart';

// Self-check for Lab 4, Exercises 1 and 2. Run it with: flutter test
//
// Both tests fail on the starter code and pass once Exercise 2 is done.
// Exercise 3 changes what the Save button should do. Part of that task is
// to update these tests so they check the new requirement.

/// Renders the app in a window tall enough for every card to be built.
Future<void> pumpApp(WidgetTester tester) async {
  tester.view.physicalSize = const Size(400, 2400);
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.reset);
  await tester.pumpWidget(const MoodTrackerApp());
}

Finder get saveButton => find.widgetWithText(FilledButton, 'Save entry');

void main() {
  testWidgets('Save is disabled until a score is chosen', (tester) async {
    await pumpApp(tester);

    expect(tester.widget<FilledButton>(saveButton).onPressed, isNull);

    await tester.tap(find.widgetWithText(ChoiceChip, '3'));
    await tester.pump();

    expect(tester.widget<FilledButton>(saveButton).onPressed, isNotNull);
  });

  testWidgets('saving an entry puts it at the top of the history',
      (tester) async {
    await pumpApp(tester);

    await tester.tap(find.widgetWithText(ChoiceChip, '3'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), 'Rainy walk home');
    await tester.tap(saveButton);
    await tester.pump();

    expect(find.byType(MoodCard), findsNWidgets(sampleEntries.length + 1));
    expect(
      find.descendant(
        of: find.byType(MoodCard).first,
        matching: find.text('Rainy walk home'),
      ),
      findsOneWidget,
    );
  });
}
