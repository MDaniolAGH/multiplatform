import 'package:flutter/material.dart';

import 'data/sample_entries.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: HomeScreen(entries: sampleEntries),
    );
  }
}
