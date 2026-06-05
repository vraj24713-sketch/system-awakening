import '../models/daily_quest.dart';

class DailyQuestService {
  static const int rewardXp = 50;
  static List<DailyQuest> getQuests({
    required int workouts,
    required int exercises,
  }) {
    return [
      DailyQuest(title: 'Complete 1 Workout', completed: workouts >= 1),

      DailyQuest(title: 'Complete 10 Exercises', completed: exercises >= 10),
    ];
  }
}
