import 'package:fire_alarm_app/layer/data/repos/user_repos.dart';
import 'package:fire_alarm_app/layer/presentation/login/index.dart';
import 'package:fire_alarm_app/utils/font_data.dart';
import 'package:fire_alarm_app/utils/text_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_alarm_app/layer/presentation/register/index.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/dimen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    required RegisterBloc registerBloc,
    Key? key,
    required this.userRepository,
  })  : _registerBloc = registerBloc,
        super(key: key);

  final RegisterBloc _registerBloc;
  final UserRepository userRepository;

  @override
  RegisterScreenState createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  RegisterScreenState();
  final focusPasswordNode = FocusNode();
  final focusResetPasswordNode = FocusNode();
  final registerForm = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
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
            userNameController.text = 'user${currentState.configIndex}';
            return body(configIndex: currentState.configIndex);
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  Widget body({String? configIndex}) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (focusPasswordNode.hasFocus || focusResetPasswordNode.hasFocus) {
              focusPasswordNode.unfocus();
              focusResetPasswordNode.unfocus();
            }
          },
          child: Center(
            child: Card(
              elevation: 8,
              shadowColor: Colors.black,
              child: Container(
                height: Dimen.sizeDevice.height * 0.5,
                width: Dimen.sizeDevice.width * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.orange,
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Text 'Đăng Ký'
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 40,
                                width: 5,
                                color: Colors.white,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Text(
                                  TextData.registerTilte,
                                  style: FontData.dMSans20Bold(
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SizedBox(
                                height: 80,
                                width: 80,
                                child: IconButton(
                                  onPressed: () {
                                    GoRouter.of(context)
                                        .go(LoginPage.routeName);
                                  },
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
                                    label: Text(TextData.usernameTilte,
                                        style: FontData.dMSans14Bold(
                                            color: Colors.grey[300])),
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
                                  focusNode: focusPasswordNode,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.orange,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: TextData.passwordTilte,
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
                                  focusNode: focusResetPasswordNode,
                                  style: const TextStyle(color: Colors.white),
                                  cursorColor: Colors.orange,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: TextData.repasswordTilte,
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
                            onPressed: () {
                              widget.userRepository.registerUser(
                                  userNameController.text,
                                  passwordController.text,
                                  rePasswordController.text,
                                  configIndex!);
                            },
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0)),
                                side: const BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                )),
                            child: Text(TextData.confirmTilte,
                                style: FontData.dMSans20Bold(
                                    color: Colors.orange))),
                      )
                    ]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _load() async {
    final configIndex = await widget.userRepository.loadConfigIndex();
    widget._registerBloc.add(LoadRegisterEvent(configIndex: configIndex));
  }
}
