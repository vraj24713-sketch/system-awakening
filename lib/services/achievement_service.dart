import '../models/achievement.dart';

class AchievementService {
  static List<Achievement> getAchievements({
    required int workouts,
    required int exercises,
    required int streak,
    required String rank,
  }) {
    return [
      Achievement(
        title: 'First Steps',
        description: 'Complete 1 workout',
        current: workouts,
        target: 1,
        unlocked: workouts >= 1,
      ),

      Achievement(
        title: 'Iron Will',
        description: 'Complete 10 workouts',
        current: workouts,
        target: 10,
        unlocked: workouts >= 10,
      ),

      Achievement(
        title: 'Getting Started',
        description: 'Complete 10 exercises',
        current: exercises,
        target: 10,
        unlocked: exercises >= 10,
      ),

      Achievement(
        title: 'Warrior',
        description: 'Complete 100 exercises',
        current: exercises,
        target: 100,
        unlocked: exercises >= 100,
      ),

      Achievement(
        title: 'Consistent',
        description: 'Reach a 3 workout streak',
        current: streak,
        target: 3,
        unlocked: streak >= 3,
      ),

      Achievement(
        title: 'Dedicated',
        description: 'Reach a 7 workout streak',
        current: streak,
        target: 7,
        unlocked: streak >= 7,
      ),

      Achievement(
        title: 'First Awakening',
        description: 'Reach Rank D',
        current: rank == 'E' ? 0 : 1,
        target: 1,
        unlocked: rank != 'E',
      ),
    ];
  }
}
