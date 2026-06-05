import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/xp_provider.dart';
import '../providers/streak_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final xp = ref.watch(xpProvider);
    final rank = getRank(xp);
    final title = getTitle(xp);
    final streakAsync = ref.watch(streakProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('⚔️ Hunter Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'RANK: $rank',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(title, style: const TextStyle(fontSize: 18)),

                    const SizedBox(height: 16),

                    Text('XP: $xp', style: const TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            streakAsync.when(
              data: (streak) => Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      const Text(
                        '🔥 CURRENT STREAK',
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
              loading: () => const CircularProgressIndicator(),
              error: (_, __) => const Text('Error loading streak'),
            ),
          ],
        ),
      ),
    );
  }
}
