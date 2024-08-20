import 'dart:developer';

import 'package:cumin_task/db/functions/db_functions.dart';
import 'package:cumin_task/db/hive_db.dart';
import 'package:cumin_task/pages/home_page.dart';
import 'package:cumin_task/pages/sign_up_screen.dart';
import 'package:cumin_task/provider/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    checkLoggedInStatus(context);
    return const Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      ),
    );
  }
}

checkLoggedInStatus(context) async {
  final data = await getUser();
  log(data.toString());
  if (data == null) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const SignUpScreen(),
    ));
  } else {
    final userData = await Hive.openBox<UserModelForDb>('pixeldb');
    for (var element in userData.values) {
      if (element.email == data) {
        Provider.of<UserDataProvider>(context, listen: false)
            .setCurrentuser(element);
        break;
      }
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (context) => const HomePage(),
    ));
  }
}
