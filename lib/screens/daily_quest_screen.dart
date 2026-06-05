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
              final quests = DailyQuestService.getQuests(
                workouts: workouts,
                exercises: exercises,
              );

              final completed = quests.where((q) => q.completed).length;

              return Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),

                        child: Column(
                          children: [
                            const Text(
                              '📋 DAILY QUESTS',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Text('$completed / ${quests.length} Completed'),
                            const SizedBox(height: 10),

                            const Text(
                              '🎁 Reward: +50 XP',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    ElevatedButton(
                      onPressed: completed == quests.length
                          ? () async {
                              final oldXp = ref.read(xpProvider.notifier).state;

                              final newXp = oldXp + 50;

                              ref.read(xpProvider.notifier).state = newXp;

                              await SaveService.saveXp(newXp);

                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('🎁 +50 XP Reward Claimed!'),
                                ),
                              );
                            }
                          : null,
                      child: const Text('Claim Reward'),
                    ),

                    const SizedBox(height: 20),

                    Expanded(
                      child: ListView.builder(
                        itemCount: quests.length,

                        itemBuilder: (context, index) {
                          final quest = quests[index];

                          return Card(
                            child: ListTile(
                              leading: Icon(
                                quest.completed
                                    ? Icons.check_circle
                                    : Icons.circle_outlined,
                              ),

                              title: Text(quest.title),
                            ),
                          );
                        },
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
