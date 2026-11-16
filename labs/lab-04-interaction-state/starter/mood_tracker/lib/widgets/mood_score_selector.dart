import 'package:flutter/material.dart';

/// A set of chips for picking a mood score from 1 to 10.
///
/// Exercise 1, step 1.
class MoodScoreSelector extends StatelessWidget {
  const MoodScoreSelector({
    super.key,
    required this.selectedScore,
    required this.onChanged,
  });

  /// The selected score, or `null` when nothing is selected yet.
  final int? selectedScore;

  /// Called with the score the user tapped.
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    // TODO 1.1: Show one ChoiceChip for each score from 1 to 10:
    //   - label: Text('$score')
    //   - selected: true only for the chip that matches selectedScore
    //   - onSelected: (_) => onChanged(score)
    //   The selector stores nothing itself. Its parent says which score is
    //   selected and hears about taps through onChanged.
    //
    //   Put the chips in a Wrap (spacing: 8, runSpacing: 8). Then swap the
    //   Wrap for a Row and run the app on a narrow phone. What happens?
    //   Hint: a for loop inside the list literal:
    //     for (var score = 1; score <= 10; score++) ChoiceChip(...)
    return const Text('Scores 1-10 go here');
  }
}
