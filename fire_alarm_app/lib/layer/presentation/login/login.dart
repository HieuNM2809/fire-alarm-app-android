import 'dart:ffi';

import 'package:fire_alarm_app/layer/data/repos/user_repos.dart';
import 'package:fire_alarm_app/layer/presentation/home/home.dart';
import 'package:fire_alarm_app/utils/dimen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/go_router_config.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginForm = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();
  final TextEditingController userNameController =
      TextEditingController(text: 'user1');
  final TextEditingController passwordController = TextEditingController();
  final UserRepository userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {
              if (focusNode.hasFocus) {
                focusNode.unfocus();
              }
            },
            child: Center(
              child: Card(
                elevation: 8,
                shadowColor: Colors.black,
                child: Container(
                  height: Dimen.sizeDevice.height * 0.5,
                  width: Dimen.sizeDevice.width * 0.6,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //Text 'Đăng Nhập'
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 40,
                              width: 5,
                              color: Colors.orange,
                            ),
                            const Padding(
                              padding: EdgeInsets.only(left: 30),
                              child: Text(
                                "Đăng Nhập",
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontFamily: 'DM Sans',
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                        //form user and password
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Form(
                              key: loginForm,
                              child: Column(
                                children: [
                                  TextFormField(
                                    style: const TextStyle(color: Colors.black),
                                    controller: userNameController,
                                    enabled: false,
                                  ),
                                  TextFormField(
                                    focusNode: focusNode,
                                    style: const TextStyle(color: Colors.black),
                                    cursorColor: Colors.orange,
                                    decoration: InputDecoration(
                                      hintText: 'Mật Khẩu',
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!),
                                      ),
                                      focusedBorder: const UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.orange),
                                      ),
                                    ),
                                    controller: passwordController,
                                  )
                                ],
                              )),
                        ),
                        //button submit
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          width: double.infinity,
                          child: TextButton(
                              onPressed: () {
                                userRepository.loginApp(userNameController.text,
                                    passwordController.text);
                              },
                              style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5.0)),
                                  side: BorderSide(
                                    color: Colors.grey[300]!,
                                    width: 2,
                                  )),
                              child: Text("Xác Nhận",
                                  style: TextStyle(
                                      color: Colors.grey[300],
                                      fontFamily: 'DM Sans',
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold))),
                        )
                      ]),
                ),
              ),
            ),
          ),
          //Counter user name button
          Positioned(
            right: 60,
            top: 120,
            child: SizedBox(
                height: 80,
                width: 80,
                child: IconButton(
                  onPressed: () {},
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  icon: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 60,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
