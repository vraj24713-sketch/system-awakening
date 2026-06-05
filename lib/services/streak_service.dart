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

      final difference = DateTime(now.year, now.month, now.day)
          .difference(
            DateTime(lastWorkout.year, lastWorkout.month, lastWorkout.day),
          )
          .inDays;

      if (difference == 1) {
        final current = prefs.getInt(streakKey) ?? 0;
        await prefs.setInt(streakKey, current + 1);
      } else if (difference > 1) {
        await prefs.setInt(streakKey, 1);
      }
    }

    await prefs.setString(lastWorkoutKey, now.toIso8601String());
  }
}
