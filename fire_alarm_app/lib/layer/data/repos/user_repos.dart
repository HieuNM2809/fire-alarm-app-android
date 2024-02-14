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

  Future<UserModel> fetchData() async {
    UserModel? user;
    // final ref = database.ref('user1');
    // final GoRouterConfig goRouter = GoRouterConfig();

    // ref.onValue.listen((event) {
    //   final data = Map<String, dynamic>.from(event.snapshot.value as Map);
    //   user = UserModel.fromJson(data);
    //  return user;
    // });
    final ref = FirebaseDatabase.instance.ref('user1');
    final snapshot = await ref.get();
    if (snapshot.exists) {
      final data = Map<String, dynamic>.from(snapshot.value as Map);
      user = UserModel.fromJson(data);
      print(">>>>>>>>>>${user.gas}");
    } else {
      print('No data available.');
    }
    return user!;
  }

  Future<void> getData(HomeBloc _homeBloc) async {
    UserModel? user;
    final ref = database.ref('user1');

    ref.onValue.listen((event) {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      user = UserModel.fromJson(data);
      _homeBloc.add(LoadHomeEvent(dataHomePage: user!));
    });
  }
}
