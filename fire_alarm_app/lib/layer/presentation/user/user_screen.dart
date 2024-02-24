import 'package:fire_alarm_app/layer/data/repos/user_repos.dart';
import 'package:fire_alarm_app/utils/constants.dart';
import 'package:fire_alarm_app/utils/dimen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_alarm_app/layer/presentation/user/index.dart';

import '../../../main.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({
    required UserBloc userBloc,
    Key? key,
  })  : _userBloc = userBloc,
        super(key: key);

  final UserBloc _userBloc;

  @override
  UserScreenState createState() {
    return UserScreenState();
  }
}

class UserScreenState extends State<UserScreen> {
  UserScreenState();
  UserRepository userRepository = UserRepository();
  FocusNode fullnameFocusNode = FocusNode();
  FocusNode oldPasswordFocusNode = FocusNode();
  FocusNode newPasswordFocusNode = FocusNode();
  FocusNode resetPasswordFocusNode = FocusNode();
  TextEditingController fullnameController = TextEditingController();
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController resetPasswordController = TextEditingController();

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
    return BlocBuilder<UserBloc, UserState>(
        bloc: widget._userBloc,
        builder: (
          BuildContext context,
          UserState currentState,
        ) {
          if (currentState is UnUserState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (currentState is ErrorUserState) {
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
          if (currentState is InUserState) {
            return body();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  SafeArea body() {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          if (fullnameFocusNode.hasFocus ||
              oldPasswordFocusNode.hasFocus ||
              newPasswordFocusNode.hasFocus ||
              resetPasswordFocusNode.hasFocus) {
            fullnameFocusNode.unfocus();
            oldPasswordFocusNode.unfocus();
            newPasswordFocusNode.unfocus();
            resetPasswordFocusNode.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Tài Khoản',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('THÔNG TIN CHUNG'),
                ),
                Row(
                  children: [
                    const Text('Họ và tên:'),
                    const SizedBox(
                      width: 100,
                    ),
                    Text(Constanst.userModel.fullname!),
                  ],
                ),
                Row(
                  children: [
                    const Text('Username:'),
                    const SizedBox(
                      width: 100,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(Constanst.userModel.username!)),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Divider(
                  height: 2,
                  color: Colors.black,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'THAY ĐỔI THÔNG TIN',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Form(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300]!,
                                offset: const Offset(0, 2),
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          focusNode: fullnameFocusNode,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.orange,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Họ và tên',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                          controller: fullnameController,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300]!,
                                offset: const Offset(0, 2),
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          focusNode: oldPasswordFocusNode,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.orange,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Nhập mật khẩu cũ',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                          controller: oldPasswordController,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300]!,
                                offset: const Offset(0, 2),
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          focusNode: newPasswordFocusNode,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.orange,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Nhập mật khẩu mới',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                          controller: newPasswordController,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[300]!,
                                offset: const Offset(0, 2),
                                blurRadius: 5,
                                blurStyle: BlurStyle.outer),
                          ],
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: TextFormField(
                          focusNode: resetPasswordFocusNode,
                          style: const TextStyle(color: Colors.black),
                          cursorColor: Colors.orange,
                          obscureText: true,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintText: 'Xác nhận mật khẩu mới',
                            hintStyle: const TextStyle(color: Colors.grey),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey[300]!),
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.orange),
                            ),
                          ),
                          controller: resetPasswordController,
                        ),
                      ),
                    )
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                          onPressed: () async {
                            await userRepository.logOutApp();
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              )),
                          child: const Text("Đăng xuất",
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'DM Sans',
                                fontSize: 20,
                              ))),
                      TextButton(
                          onPressed: () async {
                            if (fullnameController.text != '' &&
                                oldPasswordController.text != '' &&
                                newPasswordController.text != '' &&
                                resetPasswordController.text != '') {
                              if ((newPasswordController.text ==
                                  resetPasswordController.text)) {
                                userRepository.updatePassword(
                                    oldPasswordController.text,
                                    newPasswordController.text,
                                    fullnameController.text);
                              } else {
                                final snackBar = SnackBar(
                                  content: const Text(
                                      "password and resetPassword don't match"),
                                  action: SnackBarAction(
                                    label: 'Undo',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                );

                                // Find the ScaffoldMessenger in the widget tree
                                // and use it to show a SnackBar.
                                ScaffoldMessenger.of(StateManager
                                        .navigatorKey.currentContext!)
                                    .showSnackBar(snackBar);
                              }
                            }
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 255, 180, 59),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              side: const BorderSide(
                                color: Colors.white,
                                width: 2,
                              )),
                          child: const Text("Thay Đổi",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'DM Sans',
                                fontSize: 20,
                              ))),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _load() {
    widget._userBloc.add(LoadUserEvent());
  }
}
