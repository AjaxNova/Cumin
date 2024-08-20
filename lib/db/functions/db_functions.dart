import 'package:cumin_task/db/hive_db.dart';
import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

getAllUsersInDb() async {
  final userData = await Hive.openBox<UserModelForDb>('pixeldb');
  return userData.values;
}

Future<void> saveUser(
  String usermail,
) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('currentUser', usermail);
  await prefs.setBool('isLoggedIn', true);
}

Future<String?> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('currentUser');
}

Future<bool?> getStatus() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isLoggedIn');
}

Future<void> clearAllSharedPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
