import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/stats_service.dart';

final workoutsCompletedProvider = FutureProvider<int>((ref) async {
  return await StatsService.getWorkoutsCompleted();
});

final exercisesCompletedProvider = FutureProvider<int>((ref) async {
  return await StatsService.getExercisesCompleted();
});
