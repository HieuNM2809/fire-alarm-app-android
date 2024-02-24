import 'package:fire_alarm_app/layer/data/model/user_model.dart';

class Constanst {
  Constanst() {
    userModel = UserModel();
  }
  static UserModel userModel = UserModel();
  static String domainDatabase =
      'https://thietbibaochay-v2-default-rtdb.firebaseio.com';
}
