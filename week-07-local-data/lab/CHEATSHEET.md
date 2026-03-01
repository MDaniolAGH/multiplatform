# Week 7 Cheatsheet: Local Data with SQLite

<div class="grid cards" markdown>

- :material-database: **SQL Commands**

    ---

    | SQL | Purpose | sqflite equivalent |
    |-----|---------|-------------------|
    | `CREATE TABLE` | Define table structure | `db.execute(sql)` |
    | `INSERT INTO` | Add a row | `db.insert(table, map)` |
    | `SELECT * FROM` | Read rows | `db.query(table)` |
    | `UPDATE ... SET` | Modify a row | `db.update(table, map, where:)` |
    | `DELETE FROM` | Remove a row | `db.delete(table, where:)` |

- :material-code-tags: **sqflite API**

    ---

    | Method | Returns | Use case |
    |--------|---------|----------|
    | `openDatabase()` | `Database` | Open or create DB |
    | `db.execute(sql)` | `void` | Run DDL (CREATE TABLE) |
    | `db.insert()` | `int` (row ID) | Insert a row |
    | `db.query()` | `List<Map>` | Read rows |
    | `db.update()` | `int` (count) | Update matching rows |
    | `db.delete()` | `int` (count) | Delete matching rows |

- :material-layers: **Repository Pattern**

    ---

    ```
    UI (Screen)
      ↓ calls
    StateNotifier
      ↓ calls
    Repository (abstraction)
      ↓ calls
    DatabaseHelper (SQLite)
      ↓ writes to
    Device storage (file)
    ```

- :material-alert-circle: **Common Mistakes**

    ---

    | Mistake | Fix |
    |---------|-----|
    | Opening multiple DB connections | Use singleton pattern |
    | Forgetting `await` on DB ops | All sqflite methods are `Future` |
    | Calling async code in constructor | Use `initState()` + `then()` |
    | SQL injection via string concat | Use `whereArgs: [value]` |
    | Missing `toMap()` / `fromMap()` | Implement both for serialization |

</div>

## Common Patterns

=== "DatabaseHelper Singleton"

    ```dart
    class DatabaseHelper {
      static final DatabaseHelper _instance = DatabaseHelper._internal();
      factory DatabaseHelper() => _instance;
      DatabaseHelper._internal();

      static Database? _database;

      Future<Database> get database async {
        _database ??= await _initDatabase();
        return _database!;
      }

      Future<Database> _initDatabase() async {
        final path = join(await getDatabasesPath(), 'app.db');
        return openDatabase(path, version: 1, onCreate: _onCreate);
      }

      Future<void> _onCreate(Database db, int version) async {
        await db.execute('''
          CREATE TABLE moods (
            id TEXT PRIMARY KEY,
            score INTEGER NOT NULL,
            note TEXT,
            createdAt TEXT NOT NULL
          )
        ''');
      }
    }
    ```

=== "toMap / fromMap"

    ```dart
    class MoodEntry {
      // ... fields ...

      Map<String, dynamic> toMap() => {
        'id': id,
        'score': score,
        'note': note,
        'createdAt': createdAt.toIso8601String(),
      };

      factory MoodEntry.fromMap(Map<String, dynamic> map) => MoodEntry(
        id: map['id'] as String,
        score: map['score'] as int,
        note: map['note'] as String?,
        createdAt: DateTime.parse(map['createdAt'] as String),
      );
    }
    ```

=== "Repository Template"

    ```dart
    class MoodRepository {
      final DatabaseHelper _db = DatabaseHelper();

      Future<List<MoodEntry>> getAll() async {
        final db = await _db.database;
        final maps = await db.query('moods', orderBy: 'createdAt DESC');
        return maps.map((m) => MoodEntry.fromMap(m)).toList();
      }

      Future<void> insert(MoodEntry entry) async {
        final db = await _db.database;
        await db.insert('moods', entry.toMap());
      }

      Future<void> delete(String id) async {
        final db = await _db.database;
        await db.delete('moods', where: 'id = ?', whereArgs: [id]);
      }
    }
    ```

=== "Migration Template"

    ```dart
    Future<Database> _initDatabase() async {
      return openDatabase(
        path,
        version: 2,  // Bump version
        onCreate: _onCreate,
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < 2) {
            await db.execute('ALTER TABLE moods ADD COLUMN category TEXT');
          }
        },
      );
    }
    ```

## sqlite3 CLI Quick Reference

| Command | Purpose |
|---------|---------|
| `sqlite3 mydb.db` | Open (or create) a database |
| `.tables` | List all tables |
| `.schema tablename` | Show CREATE statement |
| `.headers on` | Show column headers in output |
| `.mode column` | Pretty-print output |
| `.quit` or `.exit` | Exit sqlite3 |
