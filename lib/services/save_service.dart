import 'package:shared_preferences/shared_preferences.dart';

class SaveService {
  static const String xpKey = 'xp';

  static Future<int> loadXp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(xpKey) ?? 0;
  }

  static Future<void> saveXp(int xp) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(xpKey, xp);
  }
}
