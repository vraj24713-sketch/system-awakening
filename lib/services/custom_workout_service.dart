import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/custom_workout.dart';

class CustomWorkoutService {
  static Future<void> deleteWorkout(String name) async {
    final prefs = await SharedPreferences.getInstance();

    final workouts = await getWorkouts();

    workouts.removeWhere((w) => w.name == name);

    final jsonList = workouts.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, jsonList);
  }

  static const key = 'customWorkouts';

  static Future<void> saveWorkout(CustomWorkout workout) async {
    final prefs = await SharedPreferences.getInstance();

    final workouts = await getWorkouts();

    workouts.add(workout);

    final jsonList = workouts.map((e) => jsonEncode(e.toJson())).toList();

    await prefs.setStringList(key, jsonList);
  }

  static Future<List<CustomWorkout>> getWorkouts() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList(key) ?? [];

    return data.map((e) => CustomWorkout.fromJson(jsonDecode(e))).toList();
  }
}
