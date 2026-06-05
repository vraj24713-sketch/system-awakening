import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/stats_provider.dart';
import '../services/daily_quest_service.dart';

import '../providers/xp_provider.dart';
import '../services/save_service.dart';

class DailyQuestScreen extends ConsumerWidget {
  const DailyQuestScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutsAsync = ref.watch(workoutsCompletedProvider);

    final exercisesAsync = ref.watch(exercisesCompletedProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('📋 Daily Quests')),

      body: workoutsAsync.when(
        data: (workouts) {
          return exercisesAsync.when(
            data: (exercises) {
              final mission = DailyQuestService.getTodayMission();

              return Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),

                        child: Column(
                          children: [
                            Text(
                              mission.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text(
                              '🎁 Reward: +${mission.rewardXp} XP',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: () async {
                        final oldXp = ref.read(xpProvider.notifier).state;

                        final newXp = oldXp + mission.rewardXp;

                        ref.read(xpProvider.notifier).state = newXp;

                        await SaveService.saveXp(newXp);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '🎁 +${mission.rewardXp} XP Reward Claimed!',
                            ),
                          ),
                        );
                      },
                      child: const Text('Claim Reward'),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: ListView(
                        children: mission.tasks
                            .map(
                              (task) => Card(
                                child: ListTile(
                                  leading: const Icon(Icons.assignment),
                                  title: Text(task),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
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
