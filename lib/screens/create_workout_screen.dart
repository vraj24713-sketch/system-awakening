import 'package:flutter/material.dart';

import '../models/custom_workout.dart';
import '../services/custom_workout_service.dart';

class CreateWorkoutScreen extends StatefulWidget {
  const CreateWorkoutScreen({super.key});

  @override
  State<CreateWorkoutScreen> createState() => _CreateWorkoutScreenState();
}

class _CreateWorkoutScreenState extends State<CreateWorkoutScreen> {
  final nameController = TextEditingController();

  final blockController = TextEditingController();

  final exerciseController = TextEditingController();

  final blockExercises = <String>[];

  final blocks = <CustomBlock>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('⚔ Create Workout')),

      body: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Workout Name'),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: blockController,
              decoration: const InputDecoration(labelText: 'Block Name'),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: exerciseController,
              decoration: const InputDecoration(labelText: 'Exercise'),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              onPressed: () {
                if (exerciseController.text.isNotEmpty) {
                  setState(() {
                    blockExercises.add(exerciseController.text);

                    exerciseController.clear();
                  });
                }
              },
              child: const Text('Add Exercise'),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Current Block Exercises',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  ...blockExercises.map((e) => ListTile(title: Text(e))),

                  const SizedBox(height: 20),

                  const Text(
                    'Saved Blocks',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),

                  ...blocks.map(
                    (block) => Card(
                      child: ListTile(
                        title: Text(block.name),
                        subtitle: Text(block.exercises.join(', ')),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Column(
              children: [
                ElevatedButton(
                  onPressed: () {
                    if (blockController.text.isEmpty ||
                        blockExercises.isEmpty) {
                      return;
                    }

                    setState(() {
                      blocks.add(
                        CustomBlock(
                          name: blockController.text,
                          exercises: List.from(blockExercises),
                        ),
                      );

                      blockController.clear();
                      blockExercises.clear();
                    });
                  },
                  child: const Text('Save Block'),
                ),

                const SizedBox(height: 10),

                ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty || blocks.isEmpty) {
                      return;
                    }

                    await CustomWorkoutService.saveWorkout(
                      CustomWorkout(name: nameController.text, blocks: blocks),
                    );

                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Save Workout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
