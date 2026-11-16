import 'package:flutter/material.dart';

import '../models/mood_entry.dart';

/// How many entries there are and their average score.
class MoodSummary extends StatelessWidget {
  const MoodSummary({super.key, required this.entries});

  final List<MoodEntry> entries;

  @override
  Widget build(BuildContext context) {
    final average = averageScore(entries);

    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: _Stat(label: 'Entries', value: '${entries.length}'),
            ),
            Expanded(
              child: _Stat(
                label: 'Average score',
                value: average == null ? '–' : average.toStringAsFixed(1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Text(value, style: textTheme.headlineMedium),
        Text(label, style: textTheme.bodyMedium, textAlign: TextAlign.center),
      ],
    );
  }
}
