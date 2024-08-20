// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:hive_flutter/hive_flutter.dart';

part 'hive_db.g.dart';

@HiveType(typeId: 1)
class UserModelForDb {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String password;
  @HiveField(3)
  String email;
  @HiveField(4)
  List<String> likedpics;
  @HiveField(5)
  List<String> savedposts;
  @HiveField(6)
  bool isLoggedIn;
  UserModelForDb({
    required this.id,
    required this.name,
    required this.password,
    required this.email,
    required this.likedpics,
    required this.savedposts,
    required this.isLoggedIn,
  });
}
