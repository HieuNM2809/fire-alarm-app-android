import 'dart:ffi';

import 'package:fire_alarm_app/utils/dimen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final loginForm = GlobalKey<FormState>();
  final TextEditingController userNameController =
      TextEditingController(text: 'user1');
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          elevation: 8,
          shadowColor: Colors.black,
          child: Container(
            height: Dimen.sizeDevice.height * 0.5,
            width: Dimen.sizeDevice.width * 0.6,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Column(children: [
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
              Form(
                  key: loginForm,
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        controller: userNameController,
                        enabled: false,
                      ),
                      TextFormField(
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          hintText: 'Mật Khẩu',
                        ),
                        controller: passwordController,
                      )
                    ],
                  ))
            ]),
          ),
        ),
      ),
    );
  }
}
