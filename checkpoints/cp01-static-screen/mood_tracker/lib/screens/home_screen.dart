import 'package:flutter/material.dart';

import '../models/mood_entry.dart';
import '../widgets/mood_card.dart';
import '../widgets/mood_summary.dart';

/// The home screen: a summary card followed by the history of entries.
///
/// The screen is static: it shows whatever [entries] it is given and nothing
/// on it can be changed yet.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.entries});

  final List<MoodEntry> entries;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Tracker')),
      // SafeArea keeps content clear of notches and system bars.
      body: SafeArea(
        // On wide windows (tablets, desktop, web) keep the content at a
        // readable width instead of stretching it from edge to edge.
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            // ListView scrolls when the content is taller than the screen.
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
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
