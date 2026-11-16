import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/mood_entry.dart';
import 'mood_score_indicator.dart';

/// Shows one [MoodEntry]: its score, its note and when it was recorded.
class MoodCard extends StatelessWidget {
  const MoodCard({super.key, required this.entry});

  final MoodEntry entry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final note = entry.note;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            MoodScoreIndicator(score: entry.score),
            const SizedBox(width: 12),
            // Expanded gives the text whatever width is left in the Row.
            // Without it, a long note asks for more width than the screen
            // has and the Row overflows.
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    note ?? 'No note',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: note == null
                        ? theme.textTheme.bodyLarge?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: theme.colorScheme.onSurfaceVariant,
                          )
                        : theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('EEE, d MMM yyyy · HH:mm')
                        .format(entry.createdAt),
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
