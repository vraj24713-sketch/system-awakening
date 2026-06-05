import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/stats_provider.dart';
import '../providers/streak_provider.dart';
import '../providers/xp_provider.dart';

import '../services/achievement_service.dart';

class AchievementScreen extends ConsumerWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xp = ref.watch(xpProvider);

    final workoutsAsync = ref.watch(workoutsCompletedProvider);

    final exercisesAsync = ref.watch(exercisesCompletedProvider);

    final streakAsync = ref.watch(streakProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('🏆 Achievements')),
      body: workoutsAsync.when(
        data: (workouts) {
          return exercisesAsync.when(
            data: (exercises) {
              return streakAsync.when(
                data: (streak) {
                  final rank = getRank(xp);

                  final achievements = AchievementService.getAchievements(
                    workouts: workouts,
                    exercises: exercises,
                    streak: streak,
                    rank: rank,
                  );

                  return ListView.builder(
                    itemCount: achievements.length,
                    itemBuilder: (context, index) {
                      final achievement = achievements[index];

                      return Card(
                        child: ListTile(
                          leading: Icon(
                            achievement.unlocked
                                ? Icons.emoji_events
                                : Icons.lock,
                          ),
                          title: Text(achievement.title),
                          subtitle: Text(achievement.description),
                        ),
                      );
                    },
                  );
                },
                loading: () => const CircularProgressIndicator(),
                error: (_, __) => const Text('Error'),
              );
            },
            loading: () => const CircularProgressIndicator(),
            error: (_, __) => const Text('Error'),
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (_, __) => const Text('Error'),
      ),
    );
  }
}
