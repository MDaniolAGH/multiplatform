import 'package:flutter/material.dart';

import '../models/mood_filter.dart';

/// Controls for narrowing the history: a score range and a note search.
///
/// The parent owns the chosen range and the search text, because the summary
/// and the history depend on them. The bar owns only the text controller,
/// which belongs to the search field it shows.
class MoodFilterBar extends StatefulWidget {
  const MoodFilterBar({
    super.key,
    required this.selectedRange,
    required this.onRangeChanged,
    required this.onQueryChanged,
  });

  /// The range that is currently selected.
  final ScoreRange selectedRange;

  /// Called with the range the user picked.
  final ValueChanged<ScoreRange> onRangeChanged;

  /// Called with the search text after every change.
  final ValueChanged<String> onQueryChanged;

  @override
  State<MoodFilterBar> createState() => _MoodFilterBarState();
}

class _MoodFilterBarState extends State<MoodFilterBar> {
  // Created once, when the State is created, so it survives every rebuild.
  final _searchController = TextEditingController();

  @override
  void dispose() {
    // A controller holds listeners; release it when the bar goes away.
    _searchController.dispose();
    super.dispose();
  }

  void _clearSearch() {
    _searchController.clear();
    widget.onQueryChanged('');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SegmentedButton<ScoreRange>(
          segments: [
            for (final range in ScoreRange.values)
              ButtonSegment(value: range, label: Text(range.label)),
          ],
          selected: {widget.selectedRange},
          // Exactly one range is always selected, so the set has one element.
          onSelectionChanged: (selection) =>
              widget.onRangeChanged(selection.first),
          showSelectedIcon: false,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            labelText: 'Search notes',
            prefixIcon: const Icon(Icons.search),
            suffixIcon: IconButton(
              tooltip: 'Clear search',
              icon: const Icon(Icons.clear),
              onPressed: _clearSearch,
            ),
            border: const OutlineInputBorder(),
          ),
          onChanged: widget.onQueryChanged,
        ),
      ],
    );
  }
}
