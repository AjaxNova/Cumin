import 'dart:developer';

import 'package:cumin_task/db/functions/db_functions.dart';
import 'package:cumin_task/db/hive_db.dart';
import 'package:cumin_task/model/feed_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class UserDataProvider extends ChangeNotifier {
  UserModelForDb? currentuser;
  String? emailError;
  String? logInPassWordError;
  bool isSignUpLoading = false;
  bool isLoginLoading = false;

  setCurrentuser(UserModelForDb userFromDb) async {
    currentuser = userFromDb;
    notifyListeners();
  }

  logOut() {
    emailError = null;
    bottomNavIndexHome = 0;
    logInPassWordError = null;
    favoritedFeeds.clear();
    savedFeeds.clear();
    notifyListeners();
  }

  setLogInPasswordError(String msg) {
    logInPassWordError = msg;
    notifyListeners();
  }

  clearLogInpassError() {
    logInPassWordError = null;
    notifyListeners();
  }

  turnLogInLoadinOn() {
    isLoginLoading = true;
    notifyListeners();
  }

  turnLogInLoadinOff() {
    isLoginLoading = false;
    notifyListeners();
  }

  turnSignUpLoadinOn() {
    isSignUpLoading = true;
    notifyListeners();
  }

  setEmailErrortext() {
    emailError = "email already in use";
    notifyListeners();
  }

  clearEmailError() {
    emailError = null;
  }

  turnSignUpLoadinOff() {
    isSignUpLoading = false;
    notifyListeners();
  }

  checkEmailDup(String email, Box<UserModelForDb> usersListBox) {
    for (var element in usersListBox.values) {
      if (element.email == email) {
        return true;
      }
    }
    return false;
  }

  signUpUserToDb(
      {required String username,
      required String password,
      required String email}) async {
    final userData = await Hive.openBox<UserModelForDb>('pixeldb');

    if (userData.values.isEmpty) {
      log("first time user adding");
      log("box opened");

      final data = await userData.add(UserModelForDb(
          isLoggedIn: false,
          id: "id",
          name: username,
          password: password,
          email: email,
          likedpics: [],
          savedposts: []));
      log("value added");
      log(data.toString());
      log("data added");
    } else {
      final data = checkEmailDup(email, userData);
      if (data == true) {
        return "error";
      } else {
        log("user adding not first time");
        final userData = await Hive.openBox<UserModelForDb>('pixeldb');
        log("box opened");

        final data = await userData.add(UserModelForDb(
            isLoggedIn: false,
            id: "id",
            name: username,
            password: password,
            email: email,
            likedpics: [],
            savedposts: []));
        log("value added");
        log(data.toString());
        log("data added");
      }
    }
  }

  checkUserCredValidorNot(
    Box<UserModelForDb> userData,
    String email,
    String password,
  ) async {
    for (var element in userData.values) {
      if (element.email == email) {
        if (element.password == password) {
          element.isLoggedIn = true;
          await saveUser(element.email);
          return 'user verified';
        } else {
          return "password is incorrect";
        }
      }
    }
    return "user not found";
  }

  Future<String> signInUserToDb(
      {required String email,
      required String password,
      required BuildContext context}) async {
    log("log in called");
    final userData = await Hive.openBox<UserModelForDb>('pixeldb');

    final data = await checkUserCredValidorNot(userData, email, password);
    if (data == "user not found") {
      log("data not found");

      return 'user not found';
    } else if (data == "password is incorrect") {
      return 'password is incorrect';
    } else {
      final user = await getUser();
      for (var element in userData.values) {
        if (element.email == user) {
          Provider.of<UserDataProvider>(context, listen: false)
              .setCurrentuser(element);
          break;
        }
      }

      return 'user verified';
      //success state
    }

    ///////////////////////////////////////////////////
  }

  List<FeedModel> favoritedFeeds = [];
  List<FeedModel> savedFeeds = [];

  addToSavedFeeds(FeedModel model) {
    if (savedFeeds.contains(model)) {
      savedFeeds.remove(model);
    } else {
      savedFeeds.add(model);
    }
    notifyListeners();
  }

  addToFavoritedFeeds(FeedModel model) {
    if (favoritedFeeds.contains(model)) {
      favoritedFeeds.remove(model);
    } else {
      favoritedFeeds.add(model);
    }
    notifyListeners();
  }

  removeFromFavoritedFeeds(FeedModel model) {
    favoritedFeeds.remove(model);
    notifyListeners();
  }

  int bottomNavIndexHome = 0;
  setBottomNavIndex(int val) {
    bottomNavIndexHome = val;
    notifyListeners();
  }
}
