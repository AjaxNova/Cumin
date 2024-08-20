import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveSignIn() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', true);
}

Future<bool?> checkUser() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn');
}

Future<void> clearAllSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
