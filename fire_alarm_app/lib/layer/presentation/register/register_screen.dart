import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_alarm_app/layer/presentation/register/index.dart';

import '../../../utils/dimen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    required RegisterBloc registerBloc,
    Key? key,
  })  : _registerBloc = registerBloc,
        super(key: key);

  final RegisterBloc _registerBloc;

  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenState();
  final focusNode = FocusNode();
  final registerForm = GlobalKey<FormState>();
  TextEditingController userNameController =
      TextEditingController(text: 'user4');
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

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
    return BlocBuilder<RegisterBloc, RegisterState>(
        bloc: widget._registerBloc,
        builder: (
          BuildContext context,
          RegisterState currentState,
        ) {
          if (currentState is UnRegisterState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorRegisterState) {
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(currentState.errorMessage),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: ElevatedButton(
                    onPressed: _load,
                    child: const Text('reload'),
                  ),
                ),
              ],
            ));
          }
          if (currentState is InRegisterState) {
            return body();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget body() {
    return Stack(
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
                  color: Colors.orange,
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
                            color: Colors.white,
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(
                              "Đăng Ký",
                              style: TextStyle(
                                  color: Colors.white,
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
                            key: registerForm,
                            child: Column(
                              children: [
                                TextFormField(
                                  style: const TextStyle(color: Colors.white),
                                  controller: userNameController,
                                  decoration: InputDecoration(
                                    label: Text('Username',
                                        style: TextStyle(
                                            color: Colors.grey[300],
                                            fontFamily: 'DM Sans',
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold)),
                                    hintText: 'Mật Khẩu',
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300]!),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.orange),
                                    ),
                                  ),
                                  enabled: false,
                                ),
                                TextFormField(
                                  focusNode: focusNode,
                                  style: const TextStyle(color: Colors.black),
                                  cursorColor: Colors.orange,
                                  decoration: InputDecoration(
                                    hintText: 'Mật Khẩu',
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300]!),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.orange),
                                    ),
                                  ),
                                  controller: passwordController,
                                ),
                                TextFormField(
                                  focusNode: focusNode,
                                  style: const TextStyle(color: Colors.black),
                                  cursorColor: Colors.orange,
                                  decoration: InputDecoration(
                                    hintText: 'Nhập Mật Khẩu',
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey[300]!),
                                    ),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.orange),
                                    ),
                                  ),
                                  controller: rePasswordController,
                                )
                              ],
                            )),
                      ),
                      //button submit
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        width: double.infinity,
                        child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                )),
                            child: const Text("Xác Nhận",
                                style: TextStyle(
                                    color: Colors.orange,
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
          right: 90,
          top: Dimen.sizeDevice.height * 0.28,
          child: SizedBox(
              height: 80,
              width: 80,
              child: IconButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shadowColor: Colors.black,
                    elevation: 2),
                icon: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 60,
                ),
              )),
        ),
      ],
    );
  }

  void _load() {
    widget._registerBloc.add(LoadRegisterEvent());
  }
}
