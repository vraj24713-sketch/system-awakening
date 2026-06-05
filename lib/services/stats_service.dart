import 'package:shared_preferences/shared_preferences.dart';

class StatsService {
  static const workoutsKey = 'workoutsCompleted';
  static const exercisesKey = 'exercisesCompleted';

  static Future<int> getWorkoutsCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(workoutsKey) ?? 0;
  }

  static Future<int> getExercisesCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(exercisesKey) ?? 0;
  }

  static Future<void> addWorkout() async {
    final prefs = await SharedPreferences.getInstance();

    final current = prefs.getInt(workoutsKey) ?? 0;

    await prefs.setInt(workoutsKey, current + 1);
  }

  static Future<void> addExercise() async {
    final prefs = await SharedPreferences.getInstance();

    final current = prefs.getInt(exercisesKey) ?? 0;

    await prefs.setInt(exercisesKey, current + 1);
  }
}
