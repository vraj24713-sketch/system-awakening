import 'package:flutter/material.dart';

import '../models/workout_plan.dart';

class WorkoutSessionScreen extends StatefulWidget {
  final WorkoutBlock block;

  const WorkoutSessionScreen({super.key, required this.block});

  @override
  State<WorkoutSessionScreen> createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends State<WorkoutSessionScreen> {
  int currentExerciseIndex = 0;

  @override
  Widget build(BuildContext context) {
    final exercise = widget.block.exercises[currentExerciseIndex];

    return Scaffold(
      appBar: AppBar(title: Text(widget.block.name)),

      body: Padding(
        padding: const EdgeInsets.all(24),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Text(
              'Exercise ${currentExerciseIndex + 1} / ${widget.block.exercises.length}',
              style: const TextStyle(fontSize: 18),
            ),

            const SizedBox(height: 20),

            Text(
              exercise.name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (currentExerciseIndex <
                      widget.block.exercises.length - 1) {
                    setState(() {
                      currentExerciseIndex++;
                    });
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Workout Complete!')),
                    );
                  }
                },

                child: const Text('Complete Exercise'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
