# Mood Tracker checkpoints

Each checkpoint is the complete Mood Tracker app at one point in the course. Use them to compare with your own work, or to catch up if a lab did not go to plan. Starters with `TODO`s live in the lab folders; checkpoints contain finished code only. New checkpoints are added as the course progresses.

| Checkpoint | After | Contents |
|---|---|---|
| [`cp01-static-screen`](cp01-static-screen/mood_tracker) | Lecture 2 | The static home screen: `MoodEntry` model, `MoodScoreIndicator`, `MoodCard`, `MoodSummary`, a scrolling list that works on narrow phones and wide windows; 7 tests |

## Run a checkpoint

The checkpoints ship without platform folders. Copy one out of the repository first:

```bash
cp -r checkpoints/cp01-static-screen/mood_tracker ~/flutter-work/cp01
cd ~/flutter-work/cp01
flutter create --platforms=android,ios .
flutter pub get
flutter test
flutter run
```

Checked with Flutter 3.35.4 / Dart 3.9.2: `flutter analyze`, `flutter test` and a web build. Android and iOS behaviour has not been checked yet.
