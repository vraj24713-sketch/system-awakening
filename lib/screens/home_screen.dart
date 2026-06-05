import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/selected_day_provider.dart';
import '../providers/workout_provider.dart';

import 'block_details_screen.dart';
import 'workout_session_screen.dart';

import '../providers/xp_provider.dart';

import '../providers/streak_provider.dart';

import 'profile_screen.dart';

import 'analysis_screen.dart';

import 'achievement_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(xpLoaderProvider);

    final selectedDay = ref.watch(selectedDayProvider);
    final xp = ref.watch(xpProvider);
    final streakAsync = ref.watch(streakProvider);
    final rank = getRank(xp);
    final title = getTitle(xp);
    final workoutAsync = ref.watch(workoutPlanProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('System Awakening'),
        actions: [
          IconButton(
            icon: const Icon(Icons.emoji_events),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AchievementScreen()),
              );
            },
          ),

          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: workoutAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (error, stack) => Center(child: Text('Error: $error')),

        data: (workoutWeek) {
          final dayData = workoutWeek.week[selectedDay - 1];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  streakAsync.when(
                    data: (streak) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          children: [
                            const Text(
                              '🔥 DAILY STREAK',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              streak == 1 ? '1 Day' : '$streak Days',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    loading: () => const SizedBox(),

                    error: (error, stackTrace) => const SizedBox(),
                  ),

                  const SizedBox(height: 12),

                  Card(
                    child: InkWell(
                      onTap: () {
                        if (analysisUnlocked(xp)) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const AnalysisScreen(),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text(
                              'RANK: $rank',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(title, style: const TextStyle(fontSize: 18)),

                            const SizedBox(height: 12),

                            Text(
                              'XP: $xp',
                              style: const TextStyle(fontSize: 16),
                            ),

                            const SizedBox(height: 12),

                            if (analysisUnlocked(xp)) ...[
                              Text(
                                'Next Rank XP: ${getNextRankXp(xp)}',
                                style: const TextStyle(fontSize: 14),
                              ),

                              const SizedBox(height: 8),

                              LinearProgressIndicator(
                                value: getRankProgress(xp),
                              ),
                            ] else ...[
                              const Text(
                                '⚙ SYSTEM ANALYSIS INCOMPLETE',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),

                              const SizedBox(height: 8),

                              Text(
                                getRank(xp) == 'S' ||
                                        getRank(xp) == 'S+' ||
                                        getRank(xp) == 'SS' ||
                                        getRank(xp) == 'SS+'
                                    ? 'Reach 90% progress to unlock rank analysis.'
                                    : 'Reach 50% progress to unlock rank analysis.',
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // DAY SELECTOR
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          if (selectedDay > 1) {
                            ref.read(selectedDayProvider.notifier).state--;
                          }
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),

                      Text(
                        'Day $selectedDay',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      IconButton(
                        onPressed: () {
                          if (selectedDay < 6) {
                            ref.read(selectedDayProvider.notifier).state++;
                          }
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // TITLE
                  Text(
                    dayData.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // THEME
                  Text(dayData.theme, style: const TextStyle(fontSize: 18)),

                  const SizedBox(height: 30),

                  // BLOCKS
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: dayData.blocks.length,
                    itemBuilder: (context, index) {
                      final block = dayData.blocks[index];

                      return Card(
                        margin: const EdgeInsets.only(bottom: 12),
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    BlockDetailsScreen(block: block),
                              ),
                            );
                          },

                          leading: const Icon(Icons.fitness_center),

                          title: Text(block.name),

                          subtitle: Text('${block.durationSeconds ~/ 60} min'),

                          trailing: const Icon(Icons.arrow_forward_ios),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 20),

                  // START WORKOUT
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                WorkoutSessionScreen(blocks: dayData.blocks),
                          ),
                        );
                      },

                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Text(
                          '⚔️ START WORKOUT',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
