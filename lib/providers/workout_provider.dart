import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/workout_plan.dart';

final workoutPlanProvider = FutureProvider<WorkoutWeek>((ref) async {
  final jsonString = await rootBundle.loadString('assets/workout_plan.json');

  final jsonMap = json.decode(jsonString);

  return WorkoutWeek.fromJson(jsonMap);
});
