# Week 3 Cheatsheet: Dart Fundamentals

<div class="grid cards" markdown>

- :material-code-tags: **Type System**

    ---

    | Type | Example | Notes |
    |------|---------|-------|
    | `int` | `42` | Whole numbers |
    | `double` | `3.14` | Floating point |
    | `String` | `'hello'` | Text (single or double quotes) |
    | `bool` | `true` / `false` | Boolean |
    | `List<T>` | `[1, 2, 3]` | Ordered collection |
    | `Map<K, V>` | `{'a': 1}` | Key-value pairs |
    | `Set<T>` | `{1, 2, 3}` | Unique values |
    | `dynamic` | anything | Opt out of type checking |

- :material-shield-check: **Null Safety Operators**

    ---

    | Operator | Meaning | Example |
    |----------|---------|---------|
    | `?` | Nullable type | `String? name` |
    | `!` | Null assertion | `name!.length` |
    | `??` | If-null fallback | `name ?? 'Unknown'` |
    | `?.` | Null-aware access | `name?.length` |
    | `??=` | Assign if null | `name ??= 'Default'` |
    | `late` | Deferred init | `late final String name;` |

- :material-variable: **Variables**

    ---

    | Keyword | Mutability | When set |
    |---------|-----------|----------|
    | `var` | Mutable | Runtime |
    | `final` | Set once | Runtime |
    | `const` | Set once | Compile time |
    | `late` | Set later | Runtime (lazy) |

    ```dart
    var name = 'Alice';     // Can change
    final age = 25;         // Set once at runtime
    const pi = 3.14159;     // Compile-time constant
    ```

- :material-lightning-bolt: **Collection Methods**

    ---

    | Method | Purpose | Returns |
    |--------|---------|---------|
    | `.map()` | Transform items | `Iterable` |
    | `.where()` | Filter items | `Iterable` |
    | `.reduce()` | Combine to one value | `T` |
    | `.fold()` | Combine with initial | `T` |
    | `.any()` | Test if any match | `bool` |
    | `.every()` | Test if all match | `bool` |
    | `.toList()` | Convert to list | `List<T>` |

</div>

## Common Patterns

=== "Null Safety"

    ```dart
    // Nullable variable
    String? name;

    // Safe access
    int? length = name?.length;

    // Fallback value
    String display = name ?? 'Unknown';

    // Assertion (throws if null)
    String sure = name!; // Use only when you're certain
    ```

=== "Async / Await"

    ```dart
    // Declare async function
    Future<String> fetchData() async {
      final response = await http.get(url);
      return response.body;
    }

    // Use with try-catch
    try {
      final data = await fetchData();
      print(data);
    } catch (e) {
      print('Error: $e');
    }
    ```

=== "Classes"

    ```dart
    class Patient {
      final String name;
      final int age;
      final String? allergies; // Nullable

      const Patient({
        required this.name,
        required this.age,
        this.allergies,
      });

      Patient copyWith({String? name, int? age}) => Patient(
        name: name ?? this.name,
        age: age ?? this.age,
        allergies: allergies,
      );
    }
    ```

=== "Extensions"

    ```dart
    extension StringExtras on String {
      String capitalize() =>
          '${this[0].toUpperCase()}${substring(1)}';
    }

    // Usage
    'hello'.capitalize(); // 'Hello'
    ```

## Named vs Positional Parameters

```dart
// Positional (required, order matters)
void greet(String name, int age) { }
greet('Alice', 25);

// Named (wrapped in {}, order doesn't matter)
void greet({required String name, int age = 0}) { }
greet(name: 'Alice', age: 25);

// Mixed
void greet(String name, {int? age}) { }
greet('Alice', age: 25);
```
