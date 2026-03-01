# Week 9 Cheatsheet: Authentication & Security

<div class="grid cards" markdown>

- :material-shield-lock: **JWT Anatomy**

    ---

    ```
    header.payload.signature
    ```

    | Part | Contains | Example |
    |------|----------|---------|
    | Header | Algorithm, token type | `{"alg": "HS256", "typ": "JWT"}` |
    | Payload | User data, expiry | `{"sub": "user123", "exp": 1700000000}` |
    | Signature | Verification hash | HMAC-SHA256(header + payload, secret) |

- :material-key: **FlutterSecureStorage API**

    ---

    | Method | Purpose |
    |--------|---------|
    | `write(key:, value:)` | Store encrypted value |
    | `read(key:)` | Read decrypted value (nullable) |
    | `delete(key:)` | Remove a stored value |
    | `deleteAll()` | Clear all stored data |
    | `containsKey(key:)` | Check if key exists |

- :material-state-machine: **Auth State Machine**

    ---

    ```
    App launch → Unknown
      ↓ check stored token
    Token found? → Authenticated
    No token?   → Unauthenticated
    API error?  → Error
    Logout      → Unauthenticated
    ```

    | State | UI shows | Next action |
    |-------|----------|-------------|
    | `unknown` | Loading spinner | Check storage |
    | `authenticated` | Home screen | Normal use |
    | `unauthenticated` | Login screen | Wait for login |
    | `error` | Error + retry | Retry or logout |

- :material-alert-circle: **Common Mistakes**

    ---

    | Mistake | Fix |
    |---------|-----|
    | Token in `SharedPreferences` | Use `FlutterSecureStorage` |
    | No token expiry check | Decode JWT and compare `exp` claim |
    | Hardcoded token in source | Load from secure storage at runtime |
    | No error state in auth | Add `error` state with message |
    | Forgetting to clear on logout | `deleteAll()` on secure storage |

</div>

## Common Patterns

=== "Auth Service"

    ```dart
    class AuthService {
      final FlutterSecureStorage _storage;
      final ApiClient _api;

      Future<String> login(String email, String password) async {
        final response = await _api.post('/auth/login', body: {
          'email': email,
          'password': password,
        });
        final token = response['token'] as String;
        await _storage.write(key: 'jwt_token', value: token);
        return token;
      }

      Future<void> logout() async {
        await _storage.deleteAll();
      }

      Future<String?> getStoredToken() async {
        return await _storage.read(key: 'jwt_token');
      }
    }
    ```

=== "AuthNotifier State Machine"

    ```dart
    class AuthNotifier extends StateNotifier<AuthState> {
      AuthNotifier(this._authService) : super(const AuthState.unknown()) {
        _checkStoredToken();
      }

      Future<void> _checkStoredToken() async {
        final token = await _authService.getStoredToken();
        if (token != null) {
          state = AuthState.authenticated(token);
        } else {
          state = const AuthState.unauthenticated();
        }
      }

      Future<void> login(String email, String password) async {
        try {
          final token = await _authService.login(email, password);
          state = AuthState.authenticated(token);
        } catch (e) {
          state = AuthState.error(e.toString());
        }
      }

      Future<void> logout() async {
        await _authService.logout();
        state = const AuthState.unauthenticated();
      }
    }
    ```

=== "AuthGate Widget"

    ```dart
    class AuthGate extends ConsumerWidget {
      @override
      Widget build(BuildContext context, WidgetRef ref) {
        final authState = ref.watch(authProvider);

        return authState.when(
          unknown: () => const LoadingScreen(),
          authenticated: (token) => const HomeScreen(),
          unauthenticated: () => const LoginScreen(),
          error: (message) => ErrorScreen(message: message),
        );
      }
    }
    ```

=== "Token Injection"

    ```dart
    class ApiClient {
      final FlutterSecureStorage _storage;

      Future<Map<String, String>> get _headers async {
        final token = await _storage.read(key: 'jwt_token');
        return {
          'Content-Type': 'application/json',
          if (token != null) 'Authorization': 'Bearer $token',
        };
      }
    }
    ```

## Auth Flow Sequence

```
User taps "Login"
  → LoginScreen calls ref.read(authProvider.notifier).login(email, pw)
    → AuthNotifier calls AuthService.login()
      → AuthService POSTs to /auth/login
        → Server validates credentials, returns JWT
      → AuthService stores JWT in FlutterSecureStorage
    → AuthNotifier sets state = authenticated(token)
  → AuthGate detects state change via ref.watch
    → AuthGate rebuilds → shows HomeScreen
```
