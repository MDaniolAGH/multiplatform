# Week 4 Lecture — Live Flutter Walkthrough

**Audience:** Students seeing Flutter for the first time.
**Duration:** ~30 minutes of live coding on the projector.
**Goal:** By the end, every student has seen a Flutter app built, modified, and extended with a custom widget — and can choose between VSCode and Firebase Studio for their own work.

> Use this as your presenter script. Each section has talking points, commands to type, and code to show. Times are approximate.

---

## 0. Opening (~3 min)

**Talking points:**

- "Flutter is Google's UI toolkit for building native apps for iOS, Android, Web, desktop — all from one Dart codebase."
- "In healthcare, that means you write your patient app once and ship it to both the iPhone and Android device the clinician pulls out of their pocket."
- "The whole thing is built on one idea: **everything on the screen is a widget**. Text is a widget. A button is a widget. The screen itself is a widget. You compose them like LEGO bricks."
- "Today I'll walk you through a fresh Flutter app, show you how to modify it, and then we'll build a custom widget from scratch together. Tomorrow in lab you'll do this yourself."

**What to project:**

- Your terminal (zsh, monospace font ≥18pt)
- VSCode window (theme: light or high-contrast dark — not the default dark gray)
- An Android emulator or iOS Simulator, side by side with VSCode

---

## 1. IDE Choice: VSCode vs Firebase Studio (~2 min)

**Show this comparison on a slide or in a doc:**

| | VSCode (local) | Firebase Studio (browser) |
|---|---|---|
| **Where it runs** | Your laptop | Google's cloud |
| **Setup time** | ~30 min (install Flutter, Android Studio, emulator) | ~2 min (click a link, log in with Google) |
| **Works offline** | ✅ | ❌ |
| **Hot reload speed** | Sub-second | 1-3 seconds |
| **Can run on physical device** | ✅ USB / Wi-Fi | ❌ Only in-browser preview |
| **State of student machine** | You need Flutter SDK + Android SDK locally | Any browser |
| **Recommended for this course** | ✅ — lab uses it, your emulator matches production | Fallback if your laptop can't run Flutter locally |

**Say:**

- "For this course, we use **VSCode + a local emulator**. It matches what real Flutter teams use, and hot reload feels instant."
- "**Firebase Studio** is a lifesaver if your laptop is too old, you're on a Chromebook, or the lab computers don't have Flutter installed. It gives you a full Flutter dev environment in the browser, no install."
- "Both work for today's demo. I'll show VSCode primarily, and point out the differences for Firebase Studio."

**If using Firebase Studio for the demo:**

- Go to <https://studio.firebase.google.com/>, sign in with Google.
- Click **New workspace** → **Flutter** template. It provisions in ~30 seconds.
- Everything below is the same — you just type the commands in Firebase Studio's built-in terminal instead of your local zsh.

---

## 2. Create the First App (~5 min)

**Commands to type live:**

```bash
cd ~/flutter-work                 # Or wherever you keep projects
flutter create my_first_app
cd my_first_app
```

**While it runs, narrate the folder structure:**

```
my_first_app/
├── lib/
│   └── main.dart          ← YOU WRITE CODE HERE
├── pubspec.yaml           ← dependencies (like package.json)
├── android/               ← native Android project
├── ios/                   ← native iOS project
├── test/                  ← unit and widget tests
└── web/ linux/ macos/ windows/   ← other targets
```

**Say:**

- "`lib/main.dart` is 95% of where you'll spend your time."
- "`pubspec.yaml` is Flutter's `package.json` / `requirements.txt`. That's where you declare packages you want to use."
- "The platform folders are generated — you rarely touch them unless you need something platform-specific."

**Boot the emulator (new terminal):**

```bash
flutter emulators              # lists available AVDs
flutter emulators --launch <id>
# or on Mac: open -a Simulator
```

**Open VSCode:**

```bash
code .
```

**Run the app:**

- In VSCode, open `lib/main.dart`.
- Bottom-right status bar → click the device name, pick your emulator.
- Press `F5` (or click the Run lens above `void main()`).
- First build takes 1-3 min. While waiting, point at `runApp(const MyApp())` and say: "This one line starts the whole app. `runApp` takes a widget and puts it on the screen."

**Demo the counter:**

- Tap the `+` button on the emulator a few times. Show the counter incrementing.
- "This is Flutter's default 'hello world.' Nothing fancy — but notice how smooth the animation is. That's native performance."

---

## 3. Exercise 1 TODO 1 — Change the Title (~5 min)

**This is the first thing students do in the lab tomorrow.** Show them the exact edit.

**Open `lib/main.dart`. Find these two lines:**

```dart
title: 'Flutter Demo',
// ...
home: const MyHomePage(title: 'Flutter Demo Home Page'),
```

**Change to:**

```dart
title: 'Health Counter',
// ...
home: const MyHomePage(title: 'Health Counter'),
```

**Save the file.**

**⚡ Hot Reload Demo** — this is the moment that sells Flutter to students.

- Look at the running emulator: the app bar title updates **instantly** without restarting.
- "Did you see that? Under a second. No rebuild, no APK repackaging. That's hot reload — Flutter's superpower. You'll use this dozens of times today."

**Also show hot reload on color:**

```dart
theme: ThemeData(
  colorSchemeSeed: Colors.teal,   // was: Colors.deepPurple
  useMaterial3: true,
),
```

Save → watch the entire app re-theme to teal in <1 second.

**Talking point:**

- "Hot reload preserves state. If I'd incremented the counter to 5 before changing the color, it'd still be 5 after. Sometimes you want a full reset — that's hot **restart** (`Shift+R`). We'll cover both in the lab."

---

## 4. Build a Custom Widget — `VitalSignCard` (~12 min)

> This goes beyond the lab's TODOs. The point: show students how to create a widget *class*, not just tweak existing code. This builds the mental model they'll need all semester.

**Set the stage:**

- "Real apps don't have one screen with a counter. They have dozens of widgets you define yourself. Let me show you what building a custom widget looks like."
- "We're going to replace the boring counter display with a **VitalSignCard** — a reusable widget that shows a vital sign like heart rate or blood pressure."

### 4.1 Design the widget first

Sketch on the whiteboard or show in slides:

```
┌────────────────────────────┐
│ ❤  Heart Rate         72   │
│                      bpm   │
└────────────────────────────┘
```

**Say:** "It takes three things: an icon, a label, a value. Let's think about what parameters it needs *before* we type code."

Write on the board:

- Icon (IconData)
- Label (String) — e.g., "Heart Rate"
- Value (String) — e.g., "72"
- Unit (String) — e.g., "bpm"
- A color for the icon

### 4.2 Type the class live

At the bottom of `lib/main.dart`, below `_MyHomePageState`, type this (slowly, narrating):

```dart
class VitalSignCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final String unit;
  final Color accent;

  const VitalSignCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.unit,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: accent, size: 40),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: accent,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        unit,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
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
```

**As you type each piece, call out what's happening:**

- `extends StatelessWidget` — "Our widget is just a class. Stateless means no memory — it shows whatever data is passed in."
- `final` fields — "Widgets are immutable. You give them data via the constructor, they never change internally. If the data changes, the parent rebuilds the widget with new values."
- `required this.icon` — "`this.icon` auto-assigns the field. `required` means the caller must provide it."
- `build(BuildContext context)` — "This method returns the visual tree. Flutter calls it whenever it needs to paint this widget."
- `Card > Padding > Row > [Icon, Column > [Text, Row > [Text, Text]]]` — "Notice the nesting. It feels strange at first, but it's all composition. Every node in this tree is a widget."

### 4.3 Use the widget

Replace the body of `MyHomePage.build`. Find this block:

```dart
body: Center(
  child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      const Text('You have pushed the button this many times:'),
      Text(
        '$_counter',
        style: Theme.of(context).textTheme.headlineMedium,
      ),
    ],
  ),
),
```

Replace with:

```dart
body: ListView(
  padding: const EdgeInsets.all(8),
  children: [
    VitalSignCard(
      icon: Icons.favorite,
      label: 'Heart Rate',
      value: '72',
      unit: 'bpm',
      accent: Colors.red.shade700,
    ),
    VitalSignCard(
      icon: Icons.bloodtype,
      label: 'Blood Pressure',
      value: '120/80',
      unit: 'mmHg',
      accent: Colors.blue.shade700,
    ),
    VitalSignCard(
      icon: Icons.thermostat,
      label: 'Temperature',
      value: '36.6',
      unit: '°C',
      accent: Colors.orange.shade700,
    ),
    VitalSignCard(
      icon: Icons.air,
      label: 'Oxygen Saturation',
      value: '98',
      unit: '%',
      accent: Colors.teal.shade700,
    ),
  ],
),
```

**Save. Watch the emulator.**

- "Four healthcare vital-sign cards, scrollable, from one widget class. **This is the entire Flutter mental model** — you build small widgets and compose them."

### 4.4 Drive the point home

**Scroll the list on the emulator, then say:**

- "Notice I wrote the `VitalSignCard` class *once* and used it four times with different data. That's reuse. Every Flutter widget in existence — including the ones Google ships — works exactly like this."
- "Tomorrow in lab, you'll build a `PatientInfoCard` widget following the same pattern. You already know how."

### 4.5 (Optional if time) Make the icon tappable

Show a tiny extension — wrap the `Card` in an `InkWell`:

```dart
// Replace: return Card(...);
// With:
return Card(
  margin: const EdgeInsets.all(8),
  child: InkWell(
    onTap: () {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tapped $label')),
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(16),
      // ... rest unchanged
    ),
  ),
);
```

- Tap a card → ripple + snackbar at the bottom.
- "That ripple is Material Design for free. You didn't write any animation code — Flutter gave it to you."

---

## 5. Recap (~3 min)

**Pull up a slide or whiteboard with:**

**What you just saw:**

- [ ] Created a Flutter project from one command (`flutter create`)
- [ ] Ran it on an emulator with `F5`
- [ ] Hot-reloaded a text change and a color theme in <1 second
- [ ] Wrote a `StatelessWidget` class from scratch
- [ ] Composed it four times into a scrollable list

**What to remember:**

1. **Everything is a widget.** Screens, text, buttons, layout — all widgets.
2. **Widgets are classes.** You extend `StatelessWidget` (or `StatefulWidget` — tomorrow) and override `build()`.
3. **Properties are `final`.** Widgets don't change internally; parents rebuild them with new data.
4. **Composition over configuration.** Small widgets + arrangement = your app.
5. **Hot reload is your best friend.** Sub-second feedback loop.

**What's in tomorrow's lab:**

- Same flow you just watched, but you do it.
- Four exercises: modify the counter, build `PatientInfoCard`, build a `MoodSelector` with state, build a `HealthCheckIn` form.
- Every exercise has a starter project with TODO comments guiding you step by step.

**Say:** "The lab materials are on our GitHub: [https://github.com/MDaniolAGH/multiplatform](https://github.com/MDaniolAGH/multiplatform). Clone it tonight if you haven't. See you tomorrow."

---

## Backup: If Something Breaks Live

- **Emulator won't start:** `flutter doctor` in the terminal. Most common issue: no AVD created. Open Android Studio → Virtual Device Manager → Create Device.
- **Import errors in VSCode after `flutter pub get`:** `Cmd+Shift+P` → `Dart: Restart Analysis Server`. Resolves 90% of phantom errors.
- **Hot reload not applying a change:** press `Shift+R` for hot **restart**. Changes to `main()`, state-field initializers, and constants need restart, not reload.
- **Firebase Studio emulator feels slow:** switch to the in-browser web preview (no emulator needed) — good enough for demonstrating widgets, just not animations.

---

## Quick Reference — Commands Used

```bash
# Set up
flutter create my_first_app
cd my_first_app
flutter pub get

# Run
flutter emulators --launch <id>   # boot Android emulator
open -a Simulator                 # boot iOS Simulator (Mac only)
code .                            # open VSCode in project
# Then F5 in VSCode to run

# During development
r        # hot reload (in terminal running flutter run)
R        # hot restart
q        # quit

# Troubleshooting
flutter doctor
flutter clean && flutter pub get
```
