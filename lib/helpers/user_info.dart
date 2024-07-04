import 'package:shared_preferences/shared_preferences.dart';

class UserInfo {
  Future<void> setToken(String value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setString("token", value); // Use await for clarity
  }

  Future<String?> getToken() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("userID"); // Correct key name for user ID retrieval
  }

  Future<void> setUserID(int value) async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setInt("userID", value); // Use await for clarity
  }

  Future<int?> getUserID() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getInt("userID");
  }

  Future<void> logout() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.clear(); // Use await for clarity
  }
}