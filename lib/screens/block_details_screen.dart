import 'package:flutter/material.dart';

import '../models/workout_plan.dart';

String getExerciseDetails(Exercise exercise) {
  switch (exercise.type) {
    case 'reps_sets':
      return '${exercise.sets} sets × ${exercise.reps} reps';

    case 'timed':
      return '${exercise.duration} sec';

    case 'rounds':
      return '${exercise.rounds} rounds';

    case 'instruction':
      return 'Instruction';

    default:
      return exercise.type;
  }
}

IconData getExerciseIcon(String type) {
  switch (type) {
    case 'reps_sets':
      return Icons.fitness_center;

    case 'timed':
      return Icons.timer;

    case 'rounds':
      return Icons.repeat;

    case 'instruction':
      return Icons.menu_book;

    default:
      return Icons.circle;
  }
}

class BlockDetailsScreen extends StatelessWidget {
  final WorkoutBlock block;

  const BlockDetailsScreen({super.key, required this.block});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(block.name)),

      body: ListView.builder(
        itemCount: block.exercises.length,

        itemBuilder: (context, index) {
          final exercise = block.exercises[index];

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),

            child: ListTile(
              leading: Icon(getExerciseIcon(exercise.type)),

              title: Text(exercise.name),

              subtitle: Text(getExerciseDetails(exercise)),
            ),
          );
        },
      ),
    );
  }
}
