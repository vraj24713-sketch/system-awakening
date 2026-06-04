import 'package:flutter/material.dart';

import '../models/workout_plan.dart';

import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/xp_provider.dart';
import '../services/save_service.dart';

class WorkoutSessionScreen extends ConsumerStatefulWidget {
  final WorkoutBlock block;

  const WorkoutSessionScreen({super.key, required this.block});

  @override
  ConsumerState<WorkoutSessionScreen> createState() =>
      _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends ConsumerState<WorkoutSessionScreen> {
  int currentExerciseIndex = 0;

  final messages = [
    '⚔️ Your limits are not walls. They\'re doors waiting to be broken through.',
    '🔥 The body quits when the mind agrees. Refuse the agreement.',
    '💪 Every rep is a vote for the person you\'re becoming.',
    '⚡ Pain is temporary. The warrior it creates is permanent.',
    '🛡️ The version of you that succeeds is built one difficult choice at a time.',
    '🏹 When strength fails, discipline carries the burden.',
    '🔥 Your future self is watching. Give them something to be proud of.',
    '⚔️ Champions aren\'t born in comfort; they\'re forged in resistance.',
    '⛰️ The mountain doesn\'t get smaller. You get stronger.',
    '🌪️ If today feels impossible, you\'re standing at the edge of growth.',

    '🦾 A steel mind isn\'t born strong—it is tempered by struggle.',
    '🧠 Control your thoughts, and your body will follow.',
    '⚔️ The strongest weapon you possess is the promise you keep to yourself.',
    '🔥 Discipline is choosing your future over your feelings.',
    '⚡ Excuses rust the mind. Action sharpens it.',
    '🛡️ Fear is a visitor. Resolve is a resident.',
    '⚔️ A warrior\'s greatest victory is over the voice that says "stop."',
    '💀 When motivation disappears, character takes command.',
    '🔥 Hard days reveal hidden strength.',
    '🦾 Your mind becomes steel the moment comfort loses its control over you.',

    '🚀 One more step. One more rep. One more victory.',
    '⚔️ The battle isn\'t against others. It\'s against yesterday\'s version of you.',
    '🔥 Fall seven times. Rise eight stronger.',
    '💪 Progress belongs to those who continue after enthusiasm fades.',
    '🏔️ The path to greatness is paved with ordinary days done consistently.',
    '⚡ Every setback is strength training for your spirit.',
    '🛡️ You don\'t need perfect conditions. You need relentless effort.',
    '🔥 The fire inside must burn brighter than the obstacles ahead.',
    '🚶 Keep moving. Even slow progress defeats standing still.',
    '⚔️ The strongest heroes are built in moments nobody sees.',

    '💀 Become the person your excuses are afraid of.',
    '⚡ Comfort is the enemy disguised as a friend.',
    '🔥 The pain you avoid today becomes the weakness you carry tomorrow.',
    '🦾 Train until your doubts lose the right to speak.',
    '⚔️ The world respects results, not intentions.',
    '🛡️ Every scar is proof that quitting failed.',
    '🌱 Weakness is not your identity. It is your starting point.',
    '⛈️ The storm doesn\'t break the warrior—it reveals them.',
    '📜 Your destiny is written by what you do when nobody is watching.',
    '👑 Be so disciplined that your goals become inevitable.',

    '⚔️ Beyond limits.',
    '🔥 Forge your strength.',
    '🛡️ No excuses. No retreat.',
    '🦾 Steel mind. Iron will.',
    '⚡ Rise stronger.',
    '🏹 Earn your power.',
    '🔥 Pain. Growth. Victory.',
    '🚀 Keep moving.',
    '💀 Become unstoppable.',
    '💪 One more rep.',
  ];

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
                onPressed: () async {
                  final newXp = ref.read(xpProvider.notifier).state + 10;

                  ref.read(xpProvider.notifier).state = newXp;

                  await SaveService.saveXp(newXp);

                  if (currentExerciseIndex <
                      widget.block.exercises.length - 1) {
                    setState(() {
                      currentExerciseIndex++;
                    });

                    final message = messages[Random().nextInt(messages.length)];

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('+10 XP\n$message'),
                        duration: const Duration(seconds: 4),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🔥 Workout Complete! +10 XP'),
                      ),
                    );

                    Navigator.pop(context);
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
