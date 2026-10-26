import 'package:flutter/material.dart';

/// A coloured circle showing a mood score from 1 to 10.
class MoodScoreIndicator extends StatelessWidget {
  const MoodScoreIndicator({
    super.key,
    required this.score,
    this.size = 40,
  });

  final int score;
  final double size;

  /// Red for low scores through to green for high scores.
  Color get color {
    if (score <= 2) return Colors.red.shade700;
    if (score <= 4) return Colors.orange.shade700;
    if (score <= 6) return Colors.amber.shade600;
    if (score <= 8) return Colors.lightGreen.shade600;
    return Colors.green.shade700;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        shape: BoxShape.circle,
        border: Border.all(color: color, width: 2),
      ),
      child: Center(
        child: Text(
          '$score',
          // Screen readers announce this instead of a bare number.
          semanticsLabel: 'Mood score $score out of 10',
          style: TextStyle(
            // The ring carries the colour. The number uses the normal text
            // colour, because light shades such as amber are hard to read.
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.4,
          ),
        ),
      ),
    );
  }
}
