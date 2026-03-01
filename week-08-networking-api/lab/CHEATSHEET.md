# Week 8 Cheatsheet: Networking & API Integration

<div class="grid cards" markdown>

- :material-web: **HTTP Methods → CRUD**

    ---

    | HTTP Method | CRUD | Purpose | Typical Status |
    |-------------|------|---------|----------------|
    | `GET` | Read | Fetch data | 200 OK |
    | `POST` | Create | Send new data | 201 Created |
    | `PUT` | Update | Replace data | 200 OK |
    | `PATCH` | Update | Partial update | 200 OK |
    | `DELETE` | Delete | Remove data | 204 No Content |

- :material-alert-decagram: **Status Code Families**

    ---

    | Range | Meaning | Examples |
    |-------|---------|----------|
    | `2xx` | Success | 200 OK, 201 Created, 204 No Content |
    | `3xx` | Redirect | 301 Moved, 304 Not Modified |
    | `4xx` | Client error | 400 Bad Request, 401 Unauthorized, 404 Not Found |
    | `5xx` | Server error | 500 Internal Error, 503 Service Unavailable |

- :material-swap-horizontal: **curl → Dart http**

    ---

    | curl | Dart `http` package |
    |------|-------------------|
    | `curl URL` | `http.get(Uri.parse(url))` |
    | `curl -X POST -d '{...}'` | `http.post(uri, body: json)` |
    | `curl -X DELETE` | `http.delete(uri)` |
    | `-H 'Authorization: Bearer T'` | `headers: {'Authorization': 'Bearer $t'}` |
    | `-H 'Content-Type: ...'` | `headers: {'Content-Type': 'application/json'}` |

- :material-alert-circle: **Common Mistakes**

    ---

    | Mistake | Fix |
    |---------|-----|
    | Forgetting `jsonEncode()` on body | Always encode maps before POST |
    | Not catching `SocketException` | Wrap HTTP calls in try-catch for offline |
    | Parsing JSON without null checks | Use `json['key'] ?? default` |
    | Hardcoding base URL | Use a config constant or env variable |
    | Missing `Content-Type` header | Add `'Content-Type': 'application/json'` |

</div>

## Common Patterns

=== "API Client Template"

    ```dart
    class ApiClient {
      final String baseUrl;
      final http.Client _client = http.Client();

      ApiClient({required this.baseUrl});

      Map<String, String> get _headers => {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      Future<List<MoodEntry>> getMoods() async {
        final response = await _client.get(
          Uri.parse('$baseUrl/moods'),
          headers: _headers,
        );
        if (response.statusCode == 200) {
          final List<dynamic> data = jsonDecode(response.body);
          return data.map((j) => MoodEntry.fromJson(j)).toList();
        }
        throw HttpException('GET /moods failed: ${response.statusCode}');
      }
    }
    ```

=== "JSON Serialization"

    ```dart
    class MoodEntry {
      // ... fields ...

      Map<String, dynamic> toJson() => {
        'id': id,
        'score': score,
        'note': note,
        'created_at': createdAt.toIso8601String(),
      };

      factory MoodEntry.fromJson(Map<String, dynamic> json) => MoodEntry(
        id: json['id'] as String,
        score: json['score'] as int,
        note: json['note'] as String?,
        createdAt: DateTime.parse(json['created_at'] as String),
      );
    }
    ```

=== "Online-First Pattern"

    ```dart
    Future<List<MoodEntry>> getMoods() async {
      try {
        // Try server first
        final moods = await _apiClient.getMoods();
        // Cache locally for offline use
        await _repository.cacheAll(moods);
        return moods;
      } on SocketException {
        // No internet — use local cache
        return await _repository.getAll();
      }
    }
    ```

=== "Error Handling"

    ```dart
    try {
      final response = await http.get(uri, headers: headers);
      switch (response.statusCode) {
        case 200: return _parseResponse(response.body);
        case 401: throw UnauthorizedException();
        case 404: throw NotFoundException();
        default:  throw HttpException('Error: ${response.statusCode}');
      }
    } on SocketException {
      // No network connectivity
      return _localFallback();
    } on FormatException {
      // Invalid JSON response
      throw DataParsingException();
    }
    ```
