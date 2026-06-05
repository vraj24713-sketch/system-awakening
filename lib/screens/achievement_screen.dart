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
                  final unlockedCount = achievements
                      .where((a) => a.unlocked)
                      .length;

                  final completion = unlockedCount / achievements.length;

                  return ListView(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            children: [
                              const Text(
                                '🏆 ACHIEVEMENTS',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 12),

                              Text(
                                'Unlocked: $unlockedCount / ${achievements.length}',
                              ),

                              const SizedBox(height: 12),

                              LinearProgressIndicator(value: completion),

                              const SizedBox(height: 8),

                              Text('${(completion * 100).toInt()}%'),
                            ],
                          ),
                        ),
                      ),

                      ...achievements.map((achievement) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      achievement.unlocked
                                          ? Icons.emoji_events
                                          : Icons.lock,
                                      size: achievement.unlocked ? 32 : 24,
                                    ),

                                    const SizedBox(width: 10),

                                    const SizedBox(width: 10),

                                    Expanded(
                                      child: Text(
                                        achievement.title,
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 8),

                                Text(achievement.description),

                                const SizedBox(height: 12),

                                LinearProgressIndicator(
                                  value: achievement.progress,
                                ),

                                const SizedBox(height: 6),

                                Text(
                                  '${achievement.current > achievement.target ? achievement.target : achievement.current}/${achievement.target}',
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
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
