class Achievement {
  final String title;
  final String description;

  final bool unlocked;

  final int current;
  final int target;

  Achievement({
    required this.title,
    required this.description,
    required this.unlocked,
    required this.current,
    required this.target,
  });

  double get progress => (current / target).clamp(0.0, 1.0);
}
