import 'package:alarm/alarm.dart';
import 'package:fire_alarm_app/layer/data/repos/user_repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_alarm_app/layer/presentation/home/index.dart';

import '../../../utils/dimen.dart';
import '../../../utils/image_data.dart';
import '../../../utils/widgets/noti_button.dart';
import '../../data/model/user_model.dart';

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

  @override
  void initState() {
    super.initState();
    Alarm.init();
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
            if (currentState.dataHomePage.temperatureAlert == "true") {
              alarmFunction();
            } else {
              Alarm.stop(1);
            }
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
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "CÔNG TY TNHH THIÊN PHƯỚC LỘC",
                    style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
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
                  child: const Align(
                    alignment: Alignment.center,
                    child: Text("THIẾT BỊ BÁO CHÁY",
                        style: TextStyle(
                            color: Colors.red,
                            fontFamily: 'DM Sans',
                            fontSize: 20,
                            fontWeight: FontWeight.bold)),
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
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
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
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'DM Sans',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
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
                        onPressed: () {},
                        style: TextButton.styleFrom(
                            elevation: 4,
                            backgroundColor: Colors.white,
                            shadowColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                            side: const BorderSide(
                              color: Colors.black,
                              width: 1,
                            )),
                        child: const Text("SOS",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'DM Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.bold))),
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
                        textButton: 'nhiệt độ',
                        image: ImageData.temperature,
                        color: dataHomePage.temperatureAlert == "true"
                            ? const Color.fromARGB(255, 255, 180, 59)
                            : Colors.white,
                      ),
                      const SizedBox(
                        width: 100,
                      ),
                      const NotiButton(
                        textButton: 'khí gas',
                        image: ImageData.gasStation,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      NotiButton(
                        textButton: 'chuông',
                        image: ImageData.notification,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 100,
                      ),
                      NotiButton(
                        textButton: 'bơm',
                        image: ImageData.pump,
                        color: Colors.white,
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
                  child: ListView.builder(
                    itemCount: 4,
                    padding: const EdgeInsets.all(8),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                            boxShadow: const [
                              BoxShadow(
                                  color: Color.fromARGB(255, 107, 107, 107),
                                  offset: Offset(0, 1),
                                  blurRadius: 2)
                            ]),
                        child: Text(
                          "Vùng ${index + 1}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: Colors.black,
                              fontFamily: 'DM Sans',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
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
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              elevation: 4,
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 180, 59),
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            child: const Text("ON",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'DM Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))),
                      ),
                      SizedBox(
                        height: 60,
                        width: 150,
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              elevation: 4,
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 180, 59),
                              shadowColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                            child: const Text("OFF",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'DM Sans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold))),
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

  Future<void> alarmFunction() async {
    final alarmSettings = AlarmSettings(
      id: 1,
      dateTime: DateTime.now(),
      assetAudioPath: 'assets/audio/sound_alarm.mp3',
      loopAudio: true,
      vibrate: true,
      volume: 1,
      fadeDuration: 3.0,
      notificationTitle: 'This is the title',
      notificationBody: 'This is the body',
      enableNotificationOnKill: true,
    );
    await Alarm.set(alarmSettings: alarmSettings);
  }

  void _load() {
    UserRepository userRepository = UserRepository();
    userRepository.getData(widget._homeBloc);
  }
}
