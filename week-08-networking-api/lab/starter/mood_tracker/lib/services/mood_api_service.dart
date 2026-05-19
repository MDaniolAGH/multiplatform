import '../models/mood_entry.dart';
import 'api_client.dart';

class MoodApiService {
  final ApiClient _apiClient;

  MoodApiService({ApiClient? apiClient})
      : _apiClient = apiClient ?? ApiClient();

  // ===========================================================================
  // TODO 4: Implement getMoods()
  //
  // This method fetches all mood entries from the API.
  //
  //   Future<List<MoodEntry>> getMoods() async {
  //     final data = await _apiClient.get('/moods');
  //     final entries = data['entries'] as List;
  //     return entries.map((e) => MoodEntry.fromJson(e as Map<String, dynamic>)).toList();
  //   }
  //
  // Steps:
  //   1. Call _apiClient.get('/moods') — returns the parsed JSON
  //   2. The API response has shape: { "entries": [...], "total": N }
  //   3. Extract the 'entries' list
  //   4. Map each entry to MoodEntry using MoodEntry.fromJson()
  //   5. Return the list
  // ===========================================================================

  // TODO 4: Uncomment and complete:
  //
  // Future<List<MoodEntry>> getMoods() async {
  //   final data = await _apiClient.get('/moods');
  //   // Parse the response and return a list of MoodEntry
  //   return [];
  // }

  // ===========================================================================
  // TODO 5: Implement createMood() and deleteMood()
  //
  // createMood(int score, String? note) should:
  //   1. POST to '/moods' with body: { 'score': score, 'note': note }
  //   2. Parse the response as a MoodEntry using fromJson()
  //   3. Return the created MoodEntry
  //
  //   Future<MoodEntry> createMood(int score, String? note) async {
  //     final data = await _apiClient.post('/moods', {
  //       'score': score,
  //       'note': note,
  //     });
  //     return MoodEntry.fromJson(data as Map<String, dynamic>);
  //   }
  //
  // deleteMood(String id) should:
  //   1. Call _apiClient.delete('/moods/$id')
  //   2. No return value needed (the API returns 204 No Content)
  //
  //   Future<void> deleteMood(String id) async {
  //     await _apiClient.delete('/moods/$id');
  //   }
  // ===========================================================================

  // TODO 5: Uncomment and complete:
  //
  // Future<MoodEntry> createMood(int score, String? note) async {
  //   // POST to /moods and return the created entry
  //   return MoodEntry(score: score); // Replace with actual implementation
  // }
  //
  // Future<void> deleteMood(String id) async {
  //   // DELETE /moods/{id}
  // }

  // Bonus / stretch goal — uncomment after completing TODO 1 (fromJson):
  //
  // Future<MoodEntry> updateMood(String id, int score, String? note) async {
  //   final data = await _apiClient.put('/moods/$id', {
  //     'score': score,
  //     'note': note,
  //   });
  //   return MoodEntry.fromJson(data as Map<String, dynamic>);
  // }
}
