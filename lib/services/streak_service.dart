import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  static const streakKey = 'streak';

  static Future<int> getStreak() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(streakKey) ?? 0;
  }

  static Future<void> updateStreak() async {
    print('updateStreak called');

    final prefs = await SharedPreferences.getInstance();

    final current = prefs.getInt(streakKey) ?? 0;

    await prefs.setInt(streakKey, current + 1);

    print('Current streak: ${current + 1}');
  }
}
