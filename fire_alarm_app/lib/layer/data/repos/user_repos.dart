import 'dart:async';

import 'package:alarm/alarm.dart';
import 'package:fire_alarm_app/layer/data/repos/background_service.dart';
import 'package:fire_alarm_app/layer/presentation/app_root.dart';
import 'package:fire_alarm_app/layer/presentation/home/index.dart';
import 'package:fire_alarm_app/layer/presentation/init_app/index.dart';
import 'package:fire_alarm_app/layer/presentation/login/index.dart';
import 'package:fire_alarm_app/main.dart';
import 'package:fire_alarm_app/utils/share_pref.dart';
import 'package:fire_alarm_app/utils/validation.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/constants.dart';
import '../model/user_model.dart';

class UserRepository {
  final FirebaseDatabase database;
  static Timer? timer;
  static UserModel? user;
  UserRepository({FirebaseDatabase? firebaseDatabase})
      : database = firebaseDatabase ?? FirebaseDatabase.instance;

  Future<void> loginApp(String userName, String password) async {
    try {
      SharePref sharePref = SharePref();
      final ref = await database.ref(userName).get();
      final data = Map<String, dynamic>.from(ref.value as Map);
      user = UserModel.fromJson(data);
      if (user != null && user!.password != password) {
        Validation.loginValidation(LoginValidationType.passwordWrong);

        if (GoRouter.of(StateManager.navigatorKey.currentContext!)
                .routeInformationProvider
                .value
                .uri
                .toString() !=
            LoginPage.routeName) await logOutApp();
      } else if (user != null &&
          user!.username == userName &&
          user!.password == password) {
        sharePref.save('username', userName);
        sharePref.save('password', password);
        Constanst.userModel = user!;
        BackgroundService().initializeService();
        FlutterBackgroundService().invoke('setAsForeground');
        GoRouter.of(StateManager.navigatorKey.currentContext!)
            .go(InitAppPage.routeName);
      } else {
        Validation.loginValidation(LoginValidationType.passwordOrUsernameWrong);
      }
    } catch (e) {
      Validation.loginValidation(LoginValidationType.passwordOrUsernameWrong);
    }
  }

  Future<void> logOutApp() async {
    final service = FlutterBackgroundService();
    SharePref sharePref = SharePref();
    service.invoke("stopService");

    await sharePref.remove('username');
    await sharePref.remove('password');

    GoRouter.of(StateManager.navigatorKey.currentContext!)
        .go(AppRoot.routeName);
  }

  Future<String> loadConfigIndex() async {
    final ref = database.ref();
    final configIndex = await ref.child('config/userIdCurrent').get();
    return configIndex.value.toString();
  }

  Future<void> registerUser(String username, String password, String rePassword,
      String configIndex) async {
    if (password == "" || rePassword == "") {
      Validation.registerValidation(
          RegisterValidationType.passwordAndrePasswordEmpty);
    } else if (password != rePassword) {
      Validation.registerValidation(
          RegisterValidationType.passwordNoMatchrePassword);
    } else {
      final ref = database.ref();

      final data = {
        "antiTheft": "false",
        "buttonRemoteOFF": "false",
        "buttonRemoteON": "false",
        "fullname": "N/A",
        "gas": "0.00%",
        "gasAlert": "false",
        "password": password,
        "pump": "false",
        "sos": "false",
        "temperature": "N/A",
        "temperatureAlert": "false",
        "username": username,
        "zone1": "false",
        "zone2": "false",
        "zone3": "false",
        "zone4": "false"
      };

      ref.child('user$configIndex').set(data).then((value) async {
        try {
          int index = int.parse(configIndex) + 1;
          await ref.child('config').update({
            "userIdCurrent": index.toString(),
          });
          GoRouter.of(StateManager.navigatorKey.currentContext!)
              .go(LoginPage.routeName);
        } catch (e) {
          if (kDebugMode) {
            print(e);
          }
        }
      });
    }
  }

  Future<void> getData(HomeBloc homeBloc) async {
    final ref = database.ref(Constanst.userModel.username);

    ref.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      user = UserModel.fromJson(data);

      homeBloc.add(LoadHomeEvent(dataHomePage: user!));
    });
  }

  Future<void> updateSOS(HomeBloc homeBloc, UserModel user) async {
    final ref = database.ref(Constanst.userModel.username);
    String isSOS = user.sos == "true" ? "false" : "true";
    await ref.update({
      "sos": isSOS,
    });
  }

  Future<void> updateButtonRemote(
      HomeBloc homeBloc, UserModel user, bool isButtonRemoteON) async {
    final ref = database.ref(Constanst.userModel.username);
    if (isButtonRemoteON) {
      await ref.update({
        "buttonRemoteON": "true",
      });
    } else {
      await ref.update({
        "buttonRemoteOFF": "true",
        "antiTheft": "false",
        "buttonRemoteON": "false",
        "gasAlert": "false",
        "pump": "false",
        "sos": "false",
        "temperatureAlert": "false",
        "zone1": "false",
        "zone2": "false",
        "zone3": "false",
        "zone4": "false"
      });
    }
  }

  Future<void> updatePassword(String oldPassword, String newPassword,
      String reNewPassword, String fullname) async {
    if (oldPassword == "" ||
        newPassword == "" ||
        reNewPassword == "" ||
        fullname == "") {
      Validation.registerValidation(
          RegisterValidationType.passwordAndrePasswordEmpty);
    } else if (newPassword != reNewPassword) {
      Validation.registerValidation(
          RegisterValidationType.passwordNoMatchrePassword);
    } else {
      SharePref sharePref = SharePref();
      final ref = database.ref(Constanst.userModel.username);
      if (Constanst.userModel.password == oldPassword) {
        await sharePref.remove('password');
        final data = {
          "fullname": fullname,
          "password": newPassword,
        };
        await ref.update(data).then((value) async {
          await sharePref.save('password', newPassword);
          GoRouter.of(StateManager.navigatorKey.currentContext!)
              .go(AppRoot.routeName);
        });
      } else {
        Validation.loginValidation(LoginValidationType.passwordWrong);
      }
    }
  }
}
