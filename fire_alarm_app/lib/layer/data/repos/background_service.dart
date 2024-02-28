import 'dart:async';
import 'dart:ui';

import 'package:alarm/alarm.dart';
import 'package:fire_alarm_app/utils/share_pref.dart';
import 'package:fire_alarm_app/utils/text_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import '../../../firebase_options.dart';
import '../model/user_model.dart';

class BackgroundService {
  Future<void> initializeService() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          autoStart: true,
          isForegroundMode: true,
          initialNotificationContent: TextData.appName,
          initialNotificationTitle: TextData.alert),
      iosConfiguration: IosConfiguration(
        autoStart: false,
      ),
    );
    await service.startService();
  }

  static bool onBackground(ServiceInstance serviceInstance) {
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    try {
      UserModel user = UserModel();
      Timer? time;
      SharePref sharePref = SharePref();
      final username = await sharePref.read('username');
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      DatabaseReference database = FirebaseDatabase.instance.ref(username);
      // Only available for flutter 3.0.0 and later
      DartPluginRegistrant.ensureInitialized();
      Alarm.init();
      final alarmSettings = AlarmSettings(
        id: 1,
        dateTime: DateTime.now(),
        assetAudioPath: 'assets/audio/sound_alarm.mp3',
        loopAudio: true,
        vibrate: true,
        volume: 0.8,
        fadeDuration: 3.0,
        notificationTitle: 'Cảnh Báo',
        notificationBody: '',
      );
      if (service is AndroidServiceInstance) {
        service.on('setAsForeground').listen((event) {
          service.setAsForegroundService();
        });

        // service.on('setAsBackground').listen((event) {
        //   service.setAsBackgroundService();
        // });
      }

      service.on('stopService').listen((event) {
        if (Alarm.hasAlarm()) {
          Alarm.stopAll();
        }
        time?.cancel();
        service.stopSelf();
      });

      // bring to foreground
      time = Timer.periodic(const Duration(seconds: 5), (timer) async {
        if (service is AndroidServiceInstance) {
          if (await service.isForegroundService()) {
            await alertRunBackgroundApp(user, database, alarmSettings);
          }
        }
      });
    } catch (e) {
      if (Alarm.hasAlarm()) {
        await Alarm.stopAll();
      }
      final service = FlutterBackgroundService();
      var isRunning = await service.isRunning();
      if (isRunning) {
        service.invoke("stopService");
      }
    }
  }

  static Future<void> alertRunBackgroundApp(UserModel user,
      DatabaseReference database, AlarmSettings alarmSettings) async {
    database.onValue.listen((event) async {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      user = UserModel.fromJson(data);
      if (user.temperatureAlert == "true" ||
          user.gasAlert == "true" ||
          user.antiTheft == "true" ||
          user.pump == "true" ||
          user.zone1 == "true" ||
          user.zone2 == "true" ||
          user.zone3 == "true" ||
          user.zone4 == "true") {
        Alarm.set(alarmSettings: alarmSettings);
      } else {
        if (Alarm.hasAlarm()) {
          Alarm.stopAll();
        }
      }
    });
  }
}
