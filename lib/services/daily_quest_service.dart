import '../models/system_mission.dart';

class DailyQuestService {
  static final missions = [
    const SystemMission(
      title: '⚔ COMBAT TRAINING',
      tasks: ['100 Jabs', '100 Front Kicks', '3 Rounds Shadow Boxing'],
      rewardXp: 50,
    ),

    const SystemMission(
      title: '💪 STRENGTH MISSION',
      tasks: ['100 Push-ups', '100 Squats', '2 Minute Plank'],
      rewardXp: 50,
    ),

    const SystemMission(
      title: '🥋 BAKI TRAINING',
      tasks: [
        'Horse Stance 3 Minutes',
        '100 Straight Punches',
        '100 Front Kicks',
      ],
      rewardXp: 60,
    ),

    const SystemMission(
      title: '👊 LOOKISM TRAINING',
      tasks: [
        'Footwork Drill 5 Minutes',
        '100 Jab-Cross Combos',
        '3 Rounds Shadow Boxing',
      ],
      rewardXp: 60,
    ),

    const SystemMission(
      title: '⚡ CONDITIONING',
      tasks: ['20 Burpees', '1 KM Run', '3 Minute Jump Rope'],
      rewardXp: 50,
    ),
  ];

  static SystemMission getTodayMission() {
    final day = DateTime.now().day;

    return missions[day % missions.length];
  }
}
