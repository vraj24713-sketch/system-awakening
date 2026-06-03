import 'package:flutter_riverpod/flutter_riverpod.dart';

final xpProvider = StateProvider<int>((ref) => 0);

const rankThresholds = {
  'E': 0,
  'D': 1500,
  'C': 3000,
  'B': 9000,
  'A': 18000,
  'S': 36500,
  'S+': 73000,
  'SS': 146000,
  'SS+': 255500,
  'SSS': 500000,
};

const rankTitles = {
  'E': 'Unawakened',
  'D': 'Beginner Hunter',
  'C': 'Disciplined Hunter',
  'B': 'Veteran Hunter',
  'A': 'Elite Hunter',
  'S': 'Extraordinary',
  'S+': 'Monarch Candidate',
  'SS': 'Ascendant',
  'SS+': 'Transcendent',
  'SSS': 'Shadow Monarch',
};

String getRank(int xp) {
  if (xp >= 500000) return 'SSS';
  if (xp >= 255500) return 'SS+';
  if (xp >= 146000) return 'SS';
  if (xp >= 73000) return 'S+';
  if (xp >= 36500) return 'S';
  if (xp >= 18000) return 'A';
  if (xp >= 9000) return 'B';
  if (xp >= 3000) return 'C';
  if (xp >= 1500) return 'D';

  return 'E';
}

String getTitle(int xp) {
  return rankTitles[getRank(xp)]!;
}
