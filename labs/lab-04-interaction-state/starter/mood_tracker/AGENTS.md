# AGENTS.md

Instructions for coding agents working in this project.

## Project

Mood Tracker: a Flutter app built by students in a university course on mobile software engineering. The student is learning, so prefer simple, readable code over clever code, and explain what you changed and why.

## Commands

```bash
flutter pub get    # fetch packages
flutter analyze    # must report "No issues found!"
flutter test       # every test must pass
```

Run `flutter analyze` and `flutter test` after every change, and report their actual output. Do not claim a check passed unless you ran it.

## Layout

| Path | Contents |
|---|---|
| `lib/models/` | `MoodEntry` (immutable; score 1–10, optional note, `createdAt`), helper functions, `maxNoteLength` |
| `lib/data/` | Invented sample entries; never add real personal data |
| `lib/widgets/` | Reusable widgets: `MoodCard`, `MoodScoreIndicator`, `MoodSummary`, `MoodScoreSelector`, `MoodEntryForm` |
| `lib/screens/` | `HomeScreen`, which owns the list of entries |
| `test/` | Widget tests |

## Conventions

- Material widgets from `package:flutter/material.dart`.
- State that only one widget needs lives in that widget's `State`. The list of entries lives in `HomeScreen`.
- Error messages are shown to the user in the UI, not only printed to the console.
- Use `maxNoteLength` from `lib/models/mood_entry.dart` instead of repeating the number.

## Boundaries

- Change only the files named in the task. Ask before touching any other file.
- Do not add packages or edit `pubspec.yaml`.
- Do not delete or weaken tests to make them pass. If a requirement has changed, update the test that checks it and say which test you changed and why.
- Do not run `git push` or open pull requests; the student does that after reviewing your work.

## When you finish

Summarise: which files you changed, which acceptance criteria each change addresses, the exact `flutter analyze` and `flutter test` results, and anything you did not verify.
