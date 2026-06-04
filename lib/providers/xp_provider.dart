import 'package:flutter_riverpod/flutter_riverpod.dart';

final xpProvider = StateProvider<int>((ref) {
  return 0;
});

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

int getNextRankXp(int xp) {
  final rank = getRank(xp);

  switch (rank) {
    case 'E':
      return 1500;
    case 'D':
      return 3000;
    case 'C':
      return 9000;
    case 'B':
      return 18000;
    case 'A':
      return 36500;
    case 'S':
      return 73000;
    case 'S+':
      return 146000;
    case 'SS':
      return 255500;
    case 'SS+':
      return 500000;
    default:
      return 500000;
  }
}

bool analysisUnlocked(int xp) {
  final rank = getRank(xp);

  final nextRankXp = getNextRankXp(xp);

  final progress = xp / nextRankXp;

  if (rank == 'E') {
    return true;
  }

  if (rank == 'S' || rank == 'S+' || rank == 'SS' || rank == 'SS+') {
    return progress >= 0.90;
  }

  return progress >= 0.50;
}
