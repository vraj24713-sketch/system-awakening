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
        unlocked: workouts >= 1,
      ),

      Achievement(
        title: 'Iron Will',
        description: 'Complete 10 workouts',
        unlocked: workouts >= 10,
      ),

      Achievement(
        title: 'Getting Started',
        description: 'Complete 10 exercises',
        unlocked: exercises >= 10,
      ),

      Achievement(
        title: 'Warrior',
        description: 'Complete 100 exercises',
        unlocked: exercises >= 100,
      ),

      Achievement(
        title: 'Consistent',
        description: 'Reach a 3 workout streak',
        unlocked: streak >= 3,
      ),

      Achievement(
        title: 'Dedicated',
        description: 'Reach a 7 workout streak',
        unlocked: streak >= 7,
      ),

      Achievement(
        title: 'First Awakening',
        description: 'Reach Rank D',
        unlocked: rank != 'E',
      ),
    ];
  }
}
