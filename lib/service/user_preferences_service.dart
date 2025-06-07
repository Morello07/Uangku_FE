import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesService {
  static const String userNameKey = 'userName';

  Future<String> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(userNameKey) ?? '';
  }

  Future<void> setUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(userNameKey, name);
  }
}