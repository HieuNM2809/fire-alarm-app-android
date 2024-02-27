import 'package:fire_alarm_app/utils/text_data.dart';
import 'package:fire_alarm_app/utils/widgets/flush_bar.dart';

enum LoginValidationType {
  passwordOrUsernameEmpty,
  passwordOrUsernameWrong,
  passwordWrong
}

enum RegisterValidationType {
  passwordAndrePasswordEmpty,
  passwordNoMatchrePassword
}

class Validation {
  static loginValidation(LoginValidationType type) {
    switch (type) {
      case LoginValidationType.passwordOrUsernameEmpty:
        return FlushBar().showFlushbar(
            messageText: TextData.passwordOrUsernameEmpty,
            titleText: TextData.alert);
      case LoginValidationType.passwordOrUsernameWrong:
        return FlushBar().showFlushbar(
            messageText: TextData.passwordOrUsernameWrong,
            titleText: TextData.alert);
      case LoginValidationType.passwordWrong:
        return FlushBar().showFlushbar(
            messageText: TextData.passwordWrong, titleText: TextData.alert);
    }
  }

  static registerValidation(RegisterValidationType type) {
    switch (type) {
      case RegisterValidationType.passwordAndrePasswordEmpty:
        return FlushBar().showFlushbar(
            messageText: TextData.passwordAndrePasswordEmpty,
            titleText: TextData.alert);
      case RegisterValidationType.passwordNoMatchrePassword:
        return FlushBar().showFlushbar(
            messageText: TextData.passwordNoMatchrePassword,
            titleText: TextData.alert);
    }
  }
}
