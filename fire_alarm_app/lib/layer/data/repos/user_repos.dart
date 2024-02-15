import 'package:fire_alarm_app/config/go_router_config.dart';
import 'package:fire_alarm_app/layer/presentation/home/index.dart';
import 'package:fire_alarm_app/main.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/home/home_bloc.dart';
import '../../presentation/home/home_page.dart';
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
            .go(HomePage.routeName);
      }
    });
  }

  Future<void> getData(HomeBloc homeBloc) async {
    UserModel? user;
    final ref = database.ref('user1');

    ref.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      user = UserModel.fromJson(data);
      homeBloc.add(LoadHomeEvent(dataHomePage: user!));
    });
  }

  Future<void> updateSOS(HomeBloc homeBloc, UserModel user) async {
    final ref = database.ref('user1');
    bool isSOS = !user.sos!;
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
