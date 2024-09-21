import 'package:shared_preferences/shared_preferences.dart';

const String userKey = 'user_data';
const String isTheme = 'isTheme';

getPrefStringValue(key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key);
}

setPrefStringValue(key,value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

removePrefValue(key) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(key);
}

checkPrefKey(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.containsKey(key);
}

getPrefBoolValue(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key);
}

setPrefBoolValue(String key, value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}
