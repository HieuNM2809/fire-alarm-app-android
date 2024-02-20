import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onBackground,
      ),
    );
    service.startService();
  }

  static bool onBackground(ServiceInstance serviceInstance) {
    return true;
  }

  @pragma('vm:entry-point')
  static void onStart(ServiceInstance service) async {
    UserModel? user;
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    // For flutter prior to version 3.0.0
    // We have to register the plugin manually
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("hello", "world");

    /// OPTIONAL when use custom notification
    // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    //     FlutterLocalNotificationsPlugin();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });

      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }

    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    // bring to foreground
    Timer.periodic(const Duration(seconds: 5), (timer) async {
      if (service is AndroidServiceInstance) {
        if (await service.isForegroundService()) {
          // /// OPTIONAL for use custom notification
          // /// the notification id must be equals with AndroidConfiguration when you call configure() method.
          // flutterLocalNotificationsPlugin.show(
          //   888,
          //   'COOL SERVICE',
          //   'Awesome ${DateTime.now()}',
          //   const NotificationDetails(
          //     android: AndroidNotificationDetails(
          //       'my_foreground',
          //       'MY FOREGROUND SERVICE',
          //       icon: 'ic_bg_service_small',
          //       ongoing: true,
          //     ),
          //   ),
          // );

          await alertRunBackgroundApp(user);
          // // if you don't using custom notification, uncomment this
          // service.setForegroundNotificationInfo(
          //   title: "My App Service",
          //   content: "Updated at ${DateTime.now()}",
          // );
        }
      }
    });

    /// you can see this log in logcat
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    // test using external plugin
    final deviceInfo = DeviceInfoPlugin();
    String? device;
    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      device = androidInfo.model;
    }

    if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      device = iosInfo.model;
    }

    service.invoke(
      'update',
      {
        "current_date": DateTime.now().toIso8601String(),
        "device": device,
      },
    );
  }

  static Future<void> alertRunBackgroundApp(UserModel? user) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await Alarm.init();
    DatabaseReference database = FirebaseDatabase.instance.ref('user1');
    database.onValue.listen((event) async {
      final data = Map<String, dynamic>.from(event.snapshot.value as Map);
      user = UserModel.fromJson(data);
      if (user!.temperatureAlert == "true" ||
          user!.gasAlert == "true" ||
          user!.antiTheft == "true" ||
          user!.pump == "true" ||
          user!.zone1 == "true" ||
          user!.zone2 == "true" ||
          user!.zone3 == "true" ||
          user!.zone4 == "true") {
        final alarmSettings = AlarmSettings(
          id: 1,
          dateTime: DateTime.now(),
          assetAudioPath: 'assets/audio/sound_alarm.mp3',
          loopAudio: true,
          vibrate: true,
          volume: 0.3,
          fadeDuration: 3.0,
          notificationTitle: 'Alarm Warning',
          notificationBody: '',
          enableNotificationOnKill: true,
        );
        await Alarm.set(alarmSettings: alarmSettings);
      } else {
        if (Alarm.hasAlarm()) {
          Alarm.stopAll();
        }
      }
    });
  }
}
