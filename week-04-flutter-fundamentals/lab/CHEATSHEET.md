# Week 4 Cheatsheet: Flutter Fundamentals

<div class="grid cards" markdown>

- :material-widgets: **Top 10 Widgets**

    ---

    | Widget | Purpose |
    |--------|---------|
    | `Text` | Display text |
    | `Icon` | Display icon |
    | `ElevatedButton` | Raised button with action |
    | `TextField` | Text input field |
    | `Image` | Display images |
    | `Container` | Box with padding, margin, decoration |
    | `Column` | Vertical layout |
    | `Row` | Horizontal layout |
    | `ListView` | Scrollable list |
    | `Scaffold` | Page structure (AppBar + body) |

- :material-view-grid: **Layout Cheat Grid**

    ---

    | Widget | Direction | Scrolls? |
    |--------|-----------|----------|
    | `Column` | Vertical | No |
    | `Row` | Horizontal | No |
    | `Stack` | Overlapping | No |
    | `ListView` | Vertical | Yes |
    | `GridView` | Grid | Yes |
    | `Wrap` | Auto-wrap | No |

    **Spacing:** Use `SizedBox(height: 16)` between widgets instead of padding hacks.

- :material-sync: **Widget Lifecycle**

    ---

    **StatelessWidget:**
    ```
    Constructor → build() → done
    ```

    **StatefulWidget:**
    ```
    Constructor → createState()
      → initState()
        → build()
          → setState() → build() (repeat)
            → dispose()
    ```

- :material-keyboard: **Key Shortcuts**

    ---

    | Key | Action |
    |-----|--------|
    | ++r++ | Hot reload (preserves state) |
    | ++shift+r++ | Hot restart (resets state) |
    | ++q++ | Quit flutter run |
    | ++p++ | Toggle debug paint |
    | ++o++ | Toggle platform (iOS/Android) |

</div>

## Common Patterns

=== "StatelessWidget"

    ```dart
    class Greeting extends StatelessWidget {
      final String name;
      const Greeting({super.key, required this.name});

      @override
      Widget build(BuildContext context) {
        return Text('Hello, $name!');
      }
    }
    ```

=== "StatefulWidget"

    ```dart
    class Counter extends StatefulWidget {
      const Counter({super.key});

      @override
      State<Counter> createState() => _CounterState();
    }

    class _CounterState extends State<Counter> {
      int _count = 0;

      @override
      Widget build(BuildContext context) {
        return Column(
          children: [
            Text('Count: $_count'),
            ElevatedButton(
              onPressed: () => setState(() => _count++),
              child: const Text('Increment'),
            ),
          ],
        );
      }
    }
    ```

=== "Navigation"

    ```dart
    // Push to new screen
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DetailScreen(),
      ),
    );

    // Go back
    Navigator.pop(context);

    // Push and remove all previous routes
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const HomeScreen()),
      (route) => false,
    );
    ```

=== "Scaffold Template"

    ```dart
    Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () { /* ... */ },
          ),
        ],
      ),
      body: const Center(
        child: Text('Hello!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { /* ... */ },
        child: const Icon(Icons.add),
      ),
    )
    ```

## When to Use StatelessWidget vs StatefulWidget

| Use case | Widget type | Why |
|----------|------------|-----|
| Display static info | `StatelessWidget` | No state changes needed |
| Show data from parent | `StatelessWidget` | Data comes via constructor |
| Counter, toggle, form | `StatefulWidget` | UI needs to update on interaction |
| Animation | `StatefulWidget` | Animation state changes over time |

## Common Mistakes

| Mistake | Fix |
|---------|-----|
| `setState()` in `build()` | Call `setState()` only in event handlers |
| Infinite `setState()` loop | Don't trigger state changes that rebuild the same widget |
| Missing `const` constructors | Add `const` to widgets with no dynamic data |
| `Column` inside `Column` without `Expanded` | Wrap inner `Column` in `Expanded` or use `shrinkWrap` |
