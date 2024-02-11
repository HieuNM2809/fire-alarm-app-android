import 'package:fire_alarm_app/utils/constants.dart';
import 'package:firebase_database/firebase_database.dart';

class UserRepository {
  final FirebaseDatabase database;

  UserRepository({FirebaseDatabase? firebaseDatabase})
      : database = firebaseDatabase ?? FirebaseDatabase.instance;

  Future<void> loginApp(String userName, String password) async {
    final ref = database.ref('${Constanst.domainDatabase}/user1');
    ref.onValue.listen((event) {
      // final user = UserModel.fromJson(jsonDecode(event.snapshot.value.toString()));
      print(">>>>>>> ${event.snapshot.value}");
    });
  }
}
