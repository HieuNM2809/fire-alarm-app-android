import 'package:fire_alarm_app/utils/constants.dart';
import 'package:fire_alarm_app/utils/dimen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatefulWidget {
  static const routename = '/home';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
                      color: Color.fromARGB(255, 255, 229, 59)),
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
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text("NHIỆT ĐỘ: ",
                                  style: TextStyle(
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
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text("Khí Gas: ",
                                  style: TextStyle(
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
                  Container(
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
                            side: BorderSide(
                              color: Colors.black,
                              width: 1,
                            )),
                        child: Text("SOS",
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'DM Sans',
                                fontSize: 14,
                                fontWeight: FontWeight.bold))),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
