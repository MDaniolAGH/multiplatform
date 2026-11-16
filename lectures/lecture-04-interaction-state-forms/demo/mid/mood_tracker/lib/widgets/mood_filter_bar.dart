import 'package:flutter/material.dart';

import '../models/mood_filter.dart';

/// Buttons for choosing which score range the history shows.
///
/// The bar keeps no state of its own: the parent passes in [selectedRange]
/// and is told about a new choice through [onRangeChanged].
class MoodFilterBar extends StatelessWidget {
  const MoodFilterBar({
    super.key,
    required this.selectedRange,
    required this.onRangeChanged,
  });

  /// The range that is currently selected.
  final ScoreRange selectedRange;

  /// Called with the range the user picked.
  final ValueChanged<ScoreRange> onRangeChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ScoreRange>(
      segments: [
        for (final range in ScoreRange.values)
          ButtonSegment(value: range, label: Text(range.label)),
      ],
      selected: {selectedRange},
      // Exactly one range is always selected, so the set has one element.
      onSelectionChanged: (selection) => onRangeChanged(selection.first),
      showSelectedIcon: false,
    );
  }
}
