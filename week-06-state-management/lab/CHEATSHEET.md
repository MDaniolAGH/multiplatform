# Week 6 Cheatsheet: State Management with Riverpod

<div class="grid cards" markdown>

- :material-code-tags: **Provider Types**

    ---

    | Type | Use case |
    |------|----------|
    | `Provider` | Computed/derived values (read-only) |
    | `StateNotifierProvider` | Mutable state with methods (add, delete, update) |
    | `FutureProvider` | Async data that resolves once (e.g., API call) |
    | `StreamProvider` | Continuous data streams (e.g., real-time sensor data) |

- :material-lightning-bolt: **ref.watch vs ref.read**

    ---

    | Method | Where | Why |
    |--------|-------|-----|
    | `ref.watch()` | `build()` | Reactive rebuilds — widget updates when state changes |
    | `ref.read()` | `onPressed`, callbacks | One-time action — no subscription |
    | `ref.watch(provider.notifier)` | `build()` | Access the notifier to call methods reactively |
    | `ref.read(provider.notifier)` | `onPressed` | Access the notifier for a one-time method call |

- :material-swap-horizontal: **Widget Conversion**

    ---

    | Before | After |
    |--------|-------|
    | `StatelessWidget` | `ConsumerWidget` |
    | `StatefulWidget` | `ConsumerStatefulWidget` |
    | `State<X>` | `ConsumerState<X>` |
    | `Widget build(BuildContext context)` | `Widget build(BuildContext context, WidgetRef ref)` |

- :material-alert-circle: **Common Mistakes**

    ---

    | Mistake | Fix |
    |---------|-----|
    | `state.add(item)` | `state = [...state, item]` |
    | `ref.watch()` in `onPressed` | Use `ref.read()` in callbacks |
    | `ref.read()` in `build()` | Use `ref.watch()` for reactive UI |
    | Missing `ProviderScope` | Wrap `runApp()` with `ProviderScope(child: ...)` |

</div>

## Common Patterns

=== "StateNotifier Template"

    ```dart
    class MyNotifier extends StateNotifier<List<MyModel>> {
      MyNotifier() : super([]);

      void add(MyModel item) {
        state = [item, ...state]; // Immutable update
      }

      void remove(String id) {
        state = state.where((e) => e.id != id).toList();
      }

      void update(String id, MyModel updated) {
        state = state.map((e) => e.id == id ? updated : e).toList();
      }
    }
    ```

=== "Provider Definition"

    ```dart
    final myProvider = StateNotifierProvider<MyNotifier, List<MyModel>>((ref) {
      return MyNotifier();
    });

    // Computed/derived provider
    final statsProvider = Provider<Map<String, dynamic>>((ref) {
      final items = ref.watch(myProvider);
      return {'count': items.length};
    });
    ```

=== "ConsumerWidget Template"

    ```dart
    class MyScreen extends ConsumerWidget {
      const MyScreen({super.key});

      @override
      Widget build(BuildContext context, WidgetRef ref) {
        final items = ref.watch(myProvider);  // Reactive
        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(items[index].name),
              onTap: () => ref.read(myProvider.notifier)
                  .remove(items[index].id),  // One-time
            );
          },
        );
      }
    }
    ```

=== "ConsumerStatefulWidget Template"

    ```dart
    class MyFormScreen extends ConsumerStatefulWidget {
      const MyFormScreen({super.key});

      @override
      ConsumerState<MyFormScreen> createState() => _MyFormScreenState();
    }

    class _MyFormScreenState extends ConsumerState<MyFormScreen> {
      final _controller = TextEditingController();

      void _submit() {
        ref.read(myProvider.notifier).add(/* ... */);
        Navigator.pop(context);
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(/* ... */);
      }
    }
    ```

## Dependency Chain

```
User action (add/delete/update)
  → MoodNotifier updates state (immutable)
    → moodProvider notifies listeners
      → moodStatsProvider recalculates (derived)
        → All ConsumerWidgets watching these providers rebuild
```
