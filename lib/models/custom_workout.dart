class CustomBlock {
  final String name;
  final List<String> exercises;

  CustomBlock({required this.name, required this.exercises});

  Map<String, dynamic> toJson() {
    return {'name': name, 'exercises': exercises};
  }

  factory CustomBlock.fromJson(Map<String, dynamic> json) {
    return CustomBlock(
      name: json['name'],
      exercises: List<String>.from(json['exercises']),
    );
  }
}

class CustomWorkout {
  final String name;
  final List<CustomBlock> blocks;

  CustomWorkout({required this.name, required this.blocks});

  Map<String, dynamic> toJson() {
    return {'name': name, 'blocks': blocks.map((e) => e.toJson()).toList()};
  }

  factory CustomWorkout.fromJson(Map<String, dynamic> json) {
    return CustomWorkout(
      name: json['name'],
      blocks: (json['blocks'] as List)
          .map((e) => CustomBlock.fromJson(e))
          .toList(),
    );
  }
}
