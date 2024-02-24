import 'dart:async';

import 'package:fire_alarm_app/layer/data/repos/background_service.dart';
import 'package:fire_alarm_app/layer/presentation/app_root.dart';
import 'package:fire_alarm_app/layer/presentation/home/index.dart';
import 'package:fire_alarm_app/layer/presentation/init_app/index.dart';
import 'package:fire_alarm_app/layer/presentation/login/index.dart';
import 'package:fire_alarm_app/main.dart';
import 'package:fire_alarm_app/utils/share_pref.dart';
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
    SharePref sharePref = SharePref();

    final ref = await database.ref(userName).get();
    final data = Map<String, dynamic>.from(ref.value as Map);
    user = UserModel.fromJson(data);
    if (user != null &&
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
      final snackBar = SnackBar(
        content: const Text('username or password is wrong'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(StateManager.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
    }
  }

  Future<void> logOutApp() async {
    final service = FlutterBackgroundService();
    SharePref sharePref = SharePref();
    var isRunning = await service.isRunning();
    if (isRunning) {
      service.invoke("stopService");
    }
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

  Future<void> registerUser(
      String username, String password, String configIndex) async {
    final ref = database.ref();

    final data = {
      "antiTheft": "false",
      "buttonRemoteOFF": "false",
      "buttonRemoteON": "false",
      "fullname": "Test11",
      "gas": "0.00%",
      "gasAlert": "false",
      "password": password,
      "pump": "false",
      "sos": "false",
      "temperature": "-2.18°C",
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
    bool isSOS = user.sos == "true" ? false : true;
    await ref.update({
      "sos": isSOS,
    });
  }

  Future<void> updateButtonRemote(
      HomeBloc homeBloc, UserModel user, bool isButtonRemoteON) async {
    final ref = database.ref(Constanst.userModel.username);
    String isButtonON = user.buttonRemoteON == "true" ? 'false' : 'true';
    String isButtonOFF = user.buttonRemoteOFF == "true" ? 'false' : 'true';
    if (isButtonRemoteON) {
      await ref.update({
        "buttonRemoteON": isButtonON,
      });
    } else {
      await ref.update({
        "buttonRemoteOFF": isButtonOFF,
      });
    }
  }

  Future<void> updatePassword(
      String oldPassword, String password, String fullname) async {
    SharePref sharePref = SharePref();
    final ref = database.ref(Constanst.userModel.username);
    if (Constanst.userModel.password == oldPassword) {
      await sharePref.remove('password');
      final data = {
        "fullname": fullname,
        "password": password,
      };
      await ref.update(data).then((value) async {
        await sharePref.save('password', password);
        GoRouter.of(StateManager.navigatorKey.currentContext!)
            .go(AppRoot.routeName);
      });
    } else {
      final snackBar = SnackBar(
        content: const Text("password is wrong"),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(StateManager.navigatorKey.currentContext!)
          .showSnackBar(snackBar);
    }
  }
}
