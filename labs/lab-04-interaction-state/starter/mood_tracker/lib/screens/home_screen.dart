import 'package:flutter/material.dart';

import '../models/mood_entry.dart';
import '../widgets/mood_card.dart';
import '../widgets/mood_summary.dart';

/// The home screen: a summary card followed by the history of entries.
///
/// Exercise 1, step 2, and Exercise 2, step 4.
///
/// TODO 2.4: Make the screen own the list, so that saved entries appear.
///   1. Turn HomeScreen into a StatefulWidget. Rename the `entries`
///      parameter to `initialEntries` and update lib/main.dart.
///   2. In the State class, declare `late final List<MoodEntry> _entries;`
///      and fill it in initState() with List.of(widget.initialEntries).
///      Why copy the list instead of using widget.initialEntries directly?
///   3. Write _addEntry(MoodEntry entry), which inserts the entry at the
///      start of _entries inside setState.
///   4. Pass _addEntry to the form's onSubmit, and build the summary and
///      the cards from _entries.
///   Then save an entry: do the history and the average both update?
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.entries});

  final List<MoodEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Tracker')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // TODO 1.2: Show the form as the first item in the list:
                //   MoodEntryForm(onSubmit: (entry) {}),
                //   const SizedBox(height: 16),
                //   (add: import '../widgets/mood_entry_form.dart';)
                //   HomeScreen is stateless, yet the form inside it will
                //   remember a selection. Where does that state live?
                MoodSummary(entries: entries),
                const SizedBox(height: 24),
                Text('History', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                for (final entry in entries) MoodCard(entry: entry),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
