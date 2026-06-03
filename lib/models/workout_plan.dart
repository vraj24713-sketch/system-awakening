class WorkoutWeek {
  final List<WorkoutDay> week;
  WorkoutWeek({required this.week});
  // factory constructor: takes raw JSON map and builds a WorkoutWeek object
  factory WorkoutWeek.fromJson(Map<String, dynamic> json) => WorkoutWeek(
    week: (json['week'] as List).map((e) => WorkoutDay.fromJson(e)).toList(),
  );
}

class WorkoutDay {
  final int day;
  final String title;
  final String theme;
  final List<WorkoutBlock> blocks;
  WorkoutDay({
    required this.day,
    required this.title,
    required this.theme,
    required this.blocks,
  });
  factory WorkoutDay.fromJson(Map<String, dynamic> json) => WorkoutDay(
    day: json['day'],
    title: json['title'],
    theme: json['theme'],
    blocks: (json['blocks'] as List)
        .map((b) => WorkoutBlock.fromJson(b))
        .toList(),
  );
}

class WorkoutBlock {
  final String name;
  final int durationSeconds;
  final String type;
  final List<Exercise> exercises;
  WorkoutBlock({
    required this.name,
    required this.durationSeconds,
    required this.type,
    required this.exercises,
  });
  factory WorkoutBlock.fromJson(Map<String, dynamic> json) => WorkoutBlock(
    name: json['name'],
    durationSeconds: json['duration_seconds'],
    type: json['type'],
    exercises: (json['exercises'] as List)
        .map((e) => Exercise.fromJson(e))
        .toList(),
  );
}

class Exercise {
  final String type;
  final String name;
  final int? duration;
  final String? notes;
  final int? sets;
  final dynamic reps; // can be number or string like "AMRAP"
  final int? rounds;
  final String? details;
  Exercise({
    required this.type,
    required this.name,
    this.duration,
    this.notes,
    this.sets,
    this.reps,
    this.rounds,
    this.details,
  });
  factory Exercise.fromJson(Map<String, dynamic> json) => Exercise(
    type: json['type'],
    name: json['name'],
    duration: json['duration'],
    notes: json['notes'],
    sets: json['sets'],
    reps: json['reps'],
    rounds: json['rounds'],
    details: json['details'],
  );
}
