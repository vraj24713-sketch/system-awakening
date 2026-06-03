import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/selected_day_provider.dart';
import '../providers/workout_provider.dart';

import 'block_details_screen.dart';
import 'workout_session_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectedDayProvider);
    final workoutAsync = ref.watch(workoutPlanProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('System Awakening')),
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
                            builder: (_) => WorkoutSessionScreen(
                              block: dayData.blocks.first,
                            ),
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
