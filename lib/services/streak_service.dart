import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  static const streakKey = 'streak';
  static const lastWorkoutKey = 'lastWorkout';

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(streakKey) ?? 0;
  }

  static Future<void> updateStreak() async {
    final prefs = await SharedPreferences.getInstance();

    final now = DateTime.now();

    final lastWorkoutString = prefs.getString(lastWorkoutKey);

    if (lastWorkoutString == null) {
      await prefs.setInt(streakKey, 1);
    } else {
      final lastWorkout = DateTime.parse(lastWorkoutString);

      final difference = now.difference(lastWorkout).inDays;

      if (difference == 1) {
        final streak = prefs.getInt(streakKey) ?? 0;

        await prefs.setInt(streakKey, streak + 1);
      } else if (difference > 1) {
        await prefs.setInt(streakKey, 1);
      }
    }

    await prefs.setString(lastWorkoutKey, now.toIso8601String());
  }
}
