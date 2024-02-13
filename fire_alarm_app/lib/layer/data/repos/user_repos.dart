import 'dart:convert';

import 'package:fire_alarm_app/config/go_router_config.dart';
import 'package:fire_alarm_app/main.dart';
import 'package:fire_alarm_app/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/home/home.dart';
import '../model/user_model.dart';

class UserRepository {
  final FirebaseDatabase database;

  UserRepository({FirebaseDatabase? firebaseDatabase})
      : database = firebaseDatabase ?? FirebaseDatabase.instance;

  Future<void> loginApp(String userName, String password) async {
    UserModel? user;
    final ref = database.ref('user1');
    final GoRouterConfig goRouter = GoRouterConfig();

    ref.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      user = UserModel.fromJson(data);
      if (user != null &&
          user!.username!.contains(userName) &&
          user!.password!.contains(password)) {
        GoRouter.of(StateManager.navigatorKey.currentContext!)
            .go(HomePage.routename);
      }
    });
  }
}
