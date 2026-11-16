import 'package:flutter/material.dart';

import '../models/mood_entry.dart';
import '../models/mood_filter.dart';
import '../widgets/mood_card.dart';
import '../widgets/mood_filter_bar.dart';
import '../widgets/mood_summary.dart';

/// The home screen: a filter bar, a summary card and the history of entries.
///
/// The screen owns the filter (range and search text), because two widgets
/// depend on it: the summary and the history both show only the matching
/// entries.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.entries});

  final List<MoodEntry> entries;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScoreRange _range = ScoreRange.all;
  String _query = '';

  void _changeRange(ScoreRange range) {
    setState(() {
      _range = range;
    });
  }

  void _changeQuery(String query) {
    setState(() {
      _query = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = filterEntries(widget.entries, range: _range, query: _query);

    return Scaffold(
      appBar: AppBar(title: const Text('Mood Tracker')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                MoodFilterBar(
                  selectedRange: _range,
                  onRangeChanged: _changeRange,
                  onQueryChanged: _changeQuery,
                ),
                const SizedBox(height: 16),
                MoodSummary(entries: visible),
                const SizedBox(height: 24),
                Text('History', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                if (visible.isEmpty)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Text(
                      'No entries match this filter.',
                      textAlign: TextAlign.center,
                    ),
                  )
                else
                  for (final entry in visible) MoodCard(entry: entry),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
