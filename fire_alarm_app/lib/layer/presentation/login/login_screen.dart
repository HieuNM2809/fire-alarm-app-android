import 'package:fire_alarm_app/layer/data/repos/user_repos.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_alarm_app/layer/presentation/login/index.dart';

import '../../../utils/dimen.dart';

class LoginScreen extends StatefulWidget {
  final UserRepository userRepository;
  const LoginScreen({
    Key? key,
    required LoginBloc loginBloc,
    required this.userRepository,
  })  : _loginBloc = loginBloc,
        super(key: key);

  final LoginBloc _loginBloc;

  @override
  LoginScreenState createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  LoginScreenState();

  final FocusNode focusNode = FocusNode();

  final GlobalKey<FormState> loginForm = GlobalKey<FormState>();
  TextEditingController userNameController =
      TextEditingController(text: 'user1');
  TextEditingController passwordController = TextEditingController();

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
    return BlocBuilder<LoginBloc, LoginState>(
        bloc: widget._loginBloc,
        builder: (
          BuildContext context,
          LoginState currentState,
        ) {
          if (currentState is UnLoginState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorLoginState) {
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
          if (currentState is InLoginState) {
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
                                      borderSide:
                                          BorderSide(color: Colors.grey[300]!),
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
                              widget.userRepository.loginApp(
                                  userNameController.text,
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
          top: Dimen.sizeDevice.height * 0.2,
          child: SizedBox(
              height: 80,
              width: 80,
              child: IconButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
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
    widget._loginBloc.add(LoadLoginEvent());
  }
}
