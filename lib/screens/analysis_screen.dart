import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/xp_provider.dart';
import '../providers/stats_provider.dart';
import '../providers/streak_provider.dart';

class AnalysisScreen extends ConsumerWidget {
  const AnalysisScreen({super.key});

  String calculateStrength(int exercises) {
    if (exercises >= 500) return 'S';
    if (exercises >= 250) return 'A';
    if (exercises >= 100) return 'B';
    if (exercises >= 50) return 'C';
    return 'D';
  }

  String calculateDiscipline(int streak) {
    if (streak >= 60) return 'S';
    if (streak >= 30) return 'A';
    if (streak >= 14) return 'B';
    if (streak >= 7) return 'C';
    return 'D';
  }

  String calculateConsistency(int workouts) {
    if (workouts >= 100) return 'S';
    if (workouts >= 50) return 'A';
    if (workouts >= 20) return 'B';
    if (workouts >= 10) return 'C';
    return 'D';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xp = ref.watch(xpProvider);

    final workoutsAsync = ref.watch(workoutsCompletedProvider);

    final exercisesAsync = ref.watch(exercisesCompletedProvider);

    final streakAsync = ref.watch(streakProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('⚔️ Hunter Analysis')),

      body: workoutsAsync.when(
        data: (workouts) {
          return exercisesAsync.when(
            data: (exercises) {
              return streakAsync.when(
                data: (streak) {
                  final strength = calculateStrength(exercises);

                  final discipline = calculateDiscipline(streak);

                  final consistency = calculateConsistency(workouts);

                  return Padding(
                    padding: const EdgeInsets.all(24),

                    child: Column(
                      children: [
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(20),

                            child: Column(
                              children: [
                                Text(
                                  'Rank: ${getRank(xp)}',
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 12),

                                Text(getTitle(xp)),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        ListTile(
                          title: const Text('Strength'),
                          trailing: Text(strength),
                        ),

                        ListTile(
                          title: const Text('Discipline'),
                          trailing: Text(discipline),
                        ),

                        ListTile(
                          title: const Text('Consistency'),
                          trailing: Text(consistency),
                        ),

                        ListTile(
                          title: const Text('Potential'),
                          trailing: Text(getRank(xp)),
                        ),

                        const Divider(),

                        ListTile(
                          title: const Text('Workouts Completed'),
                          trailing: Text('$workouts'),
                        ),

                        ListTile(
                          title: const Text('Exercises Completed'),
                          trailing: Text('$exercises'),
                        ),

                        ListTile(
                          title: const Text('Current Streak'),
                          trailing: Text('$streak'),
                        ),
                      ],
                    ),
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const SizedBox(),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const SizedBox(),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (_, __) => const SizedBox(),
      ),
    );
  }
}
