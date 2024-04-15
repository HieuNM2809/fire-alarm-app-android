import 'package:alarm/alarm.dart';
import 'package:fire_alarm_app/layer/data/repos/user_repos.dart';
import 'package:fire_alarm_app/utils/text_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_alarm_app/layer/presentation/home/index.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../gen/assets.gen.dart';
import '../../../utils/dimen.dart';
import '../../../utils/font_data.dart';
import '../../../utils/image_data.dart';
import '../../../utils/widgets/noti_button.dart';
import '../../data/model/user_model.dart';
import '../../data/repos/background_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required HomeBloc homeBloc,
    Key? key,
  })  : _homeBloc = homeBloc,
        super(key: key);

  final HomeBloc _homeBloc;

  @override
  HomeScreenState createState() {
    return HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  HomeScreenState();
  final UserRepository userRepository = UserRepository();
  final service = FlutterBackgroundService();
  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
        bloc: widget._homeBloc,
        builder: (
          BuildContext context,
          HomeState currentState,
        ) {
          if (currentState is UnHomeState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorHomeState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is InHomeState) {
            return body(currentState.dataHomePage);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget body(UserModel dataHomePage) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 40,
                width: Dimen.sizeDevice.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.black, width: 0.5)),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    "CÔNG TY TNHH THIÊN PHƯỚC LỘC",
                    style: FontData.dMSans16Bold(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 8,
                shadowColor: Colors.black,
                child: Container(
                  height: 40,
                  width: Dimen.sizeDevice.width,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 255, 180, 59),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("THIẾT BỊ BÁO CHÁY",
                        style: FontData.dMSans20Bold(color: Colors.red)),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Dimen.sizeDevice.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 60),
                    child: Column(
                      children: [
                        Card(
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: Container(
                            height: 40,
                            width: Dimen.sizeDevice.width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    const Color.fromARGB(255, 181, 241, 255)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  "NHIỆT ĐỘ: ${dataHomePage.temperature}",
                                  style: FontData.dMSans16Bold()),
                            ),
                          ),
                        ),
                        Card(
                          elevation: 8,
                          shadowColor: Colors.black,
                          child: Container(
                            height: 40,
                            width: Dimen.sizeDevice.width * 0.4,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color:
                                    const Color.fromARGB(255, 181, 241, 255)),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text("Khí Gas: ${dataHomePage.gas}",
                                  style: FontData.dMSans16Bold()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: Dimen.sizeDevice.width * 0.2,
                    height: 60,
                    child: TextButton(
                        onPressed: () async {
                          await userRepository.updateSOS(
                              widget._homeBloc, dataHomePage);
                        },
                        style: TextButton.styleFrom(
                            elevation: 4,
                            backgroundColor: dataHomePage.sos == "true"
                                ? const Color.fromARGB(255, 255, 180, 59)
                                : Colors.white,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            )),
                        child: Text("SOS",
                            style: FontData.dMSans14Bold(
                                color: dataHomePage.sos == "true"
                                    ? Colors.white
                                    : Colors.black))),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: Dimen.sizeDevice.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NotiButton(
                        textButton: TextData.temperatureButton,
                        image: Assets.images.temperature.image(),
                        color: dataHomePage.temperatureAlert == "true"
                            ? const Color.fromARGB(255, 255, 180, 59)
                            : Colors.white,
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      NotiButton(
                        textButton: TextData.gasStationButton,
                        image: Assets.images.gasStation.image(),
                        color: dataHomePage.gasAlert == "true"
                            ? const Color.fromARGB(255, 255, 180, 59)
                            : Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NotiButton(
                        textButton: TextData.notificationButton,
                        image: Assets.images.notification.image(),
                        color: dataHomePage.antiTheft == "true"
                            ? const Color.fromARGB(255, 255, 180, 59)
                            : Colors.white,
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      NotiButton(
                        textButton: TextData.pumpButton,
                        image: Assets.images.pump.image(),
                        color: dataHomePage.pump == "true"
                            ? const Color.fromARGB(255, 255, 180, 59)
                            : Colors.white,
                      )
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                  height: 80,
                  width: Dimen.sizeDevice.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                            color: Color.fromARGB(255, 107, 107, 107),
                            offset: Offset(0, 1),
                            blurRadius: 6)
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ZoneButton(
                        text: 'Vùng 1',
                        color: dataHomePage.zone1 == "true"
                            ? const Color.fromARGB(255, 255, 180, 59)
                            : Colors.white,
                      ),
                      ZoneButton(
                        text: 'Vùng 2',
                        color: dataHomePage.zone2 == "true"
                            ? const Color.fromARGB(255, 255, 180, 59)
                            : Colors.white,
                      ),
                      ZoneButton(
                        text: 'Vùng 3',
                        color: dataHomePage.zone3 == "true"
                            ? const Color.fromARGB(255, 255, 180, 59)
                            : Colors.white,
                      ),
                      ZoneButton(
                        text: 'Vùng 4',
                        color: dataHomePage.zone4 == "true"
                            ? const Color.fromARGB(255, 255, 180, 59)
                            : Colors.white,
                      ),
                    ],
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: 80,
                width: Dimen.sizeDevice.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Color.fromARGB(255, 107, 107, 107),
                          offset: Offset(0, 1),
                          blurRadius: 6)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: TextButton(
                            onPressed: () {
                              userRepository.updateButtonRemote(
                                  widget._homeBloc, dataHomePage, true);
                            },
                            style: TextButton.styleFrom(
                              elevation: 4,
                              backgroundColor:
                                  dataHomePage.buttonRemoteON == "true"
                                      ? const Color.fromARGB(255, 255, 180, 59)
                                      : Colors.white,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            child: Text("ON", style: FontData.dMSans14Bold())),
                      ),
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: TextButton(
                            onPressed: () {
                              userRepository.updateButtonRemote(
                                  widget._homeBloc, dataHomePage, false);
                            },
                            style: TextButton.styleFrom(
                              elevation: 4,
                              backgroundColor:
                                  dataHomePage.buttonRemoteOFF == "true"
                                      ? const Color.fromARGB(255, 255, 180, 59)
                                      : Colors.white,
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            child: Text("OFF", style: FontData.dMSans14Bold())),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  // Future<void> alarmFunction() async {
  //   final alarmSettings = AlarmSettings(
  //     id: 1,
  //     dateTime: DateTime.now(),
  //     assetAudioPath: 'assets/audio/sound_alarm.mp3',
  //     loopAudio: true,
  //     vibrate: true,
  //     volume: 0.8,
  //     fadeDuration: 3.0,
  //     notificationTitle: 'Alarm Warning',
  //     notificationBody: '',
  //     enableNotificationOnKill: true,
  //   );
  //   await Alarm.set(alarmSettings: alarmSettings);
  // }

  void _load() {
    BackgroundService().initializeService();
    service.invoke('setAsForeground');
    service.isRunning().then((value) {
      if (value) {
        print(">>>>>>>$value");
        userRepository.getData(widget._homeBloc);
      }
    });

    Permission.notification.isDenied.then((value) {
      if (value) {
        Permission.notification.request();
      }
    });
  }
}

class ZoneButton extends StatelessWidget {
  final Color? color;
  final String text;
  const ZoneButton({
    super.key,
    this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 107, 107, 107),
                offset: Offset(0, 1),
                blurRadius: 2)
          ]),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: FontData.dMSans20Bold(),
      ),
    );
  }
}
