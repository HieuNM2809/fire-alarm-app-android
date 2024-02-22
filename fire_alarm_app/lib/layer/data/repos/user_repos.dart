import 'dart:async';

import 'package:fire_alarm_app/layer/presentation/home/index.dart';
import 'package:fire_alarm_app/layer/presentation/init_app/index.dart';
import 'package:fire_alarm_app/layer/presentation/login/index.dart';
import 'package:fire_alarm_app/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:go_router/go_router.dart';

import '../model/user_model.dart';

class UserRepository {
  final FirebaseDatabase database;
  static Timer? timer;
  static UserModel? user;
  UserRepository({FirebaseDatabase? firebaseDatabase})
      : database = firebaseDatabase ?? FirebaseDatabase.instance;

  Future<void> loginApp(String userName, String password) async {
    final ref = database.ref(userName);

    ref.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      user = UserModel.fromJson(data);
      if (user != null &&
          user!.username!.contains(userName) &&
          user!.password!.contains(password)) {
        GoRouter.of(StateManager.navigatorKey.currentContext!)
            .go(InitAppPage.routeName);
      }
    });
  }

  Future<String> loadConfigIndex() async {
    final ref = database.ref();
    final configIndex = await ref.child('config/userIdCurrent').get();
    return configIndex.value.toString();
  }

  Future<void> registerUser(
      String username, String password, String configIndex) async {
    final ref = database.ref();
    // final configIndex = await ref.child('config/userIdCurrent').get();
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
    final ref = database.ref('user1');

    ref.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      user = UserModel.fromJson(data);

      homeBloc.add(LoadHomeEvent(dataHomePage: user!));
    });
  }

  Future<void> updateSOS(HomeBloc homeBloc, UserModel user) async {
    final ref = database.ref('user1');
    bool isSOS = user.sos == "true" ? false : true;
    await ref.update({
      "sos": isSOS,
    });
  }

  Future<void> updateButtonRemote(
      HomeBloc homeBloc, UserModel user, bool isButtonRemoteON) async {
    final ref = database.ref('user1');
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
}
