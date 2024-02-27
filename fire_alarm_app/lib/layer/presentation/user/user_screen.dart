import 'package:fire_alarm_app/layer/data/repos/user_repos.dart';
import 'package:fire_alarm_app/utils/constants.dart';
import 'package:fire_alarm_app/utils/dimen.dart';
import 'package:fire_alarm_app/utils/font_data.dart';
import 'package:fire_alarm_app/utils/text_data.dart';
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    TextData.accountTilte,
                    style: FontData.dMSans20Bold(),
                  ),
                ),
                const Divider(
                  height: 2,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    TextData.informationAccount,
                    style: FontData.dMSans20Bold(fontWeight: FontWeight.normal),
                  ),
                ),
                Row(
                  children: [
                    Text(TextData.fullNameTilte),
                    const SizedBox(
                      width: 100,
                    ),
                    Text(Constanst.userModel.fullname!),
                  ],
                ),
                Row(
                  children: [
                    Text(TextData.userNameChangeAccountTilte),
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
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    TextData.changeInformationAccount,
                    style: FontData.dMSans20Bold(fontWeight: FontWeight.normal),
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
                            hintText: TextData.fullname,
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
                            hintText: TextData.oldPasswordTilte,
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
                            hintText: TextData.newPasswordTilte,
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
                            hintText: TextData.reNewPasswordTitle,
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
                          ),
                          child: Text(TextData.logoutTitle,
                              style: FontData.dMSans20Bold(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal))),
                      TextButton(
                          onPressed: () async {
                            userRepository.updatePassword(
                                oldPasswordController.text,
                                newPasswordController.text,
                                resetPasswordController.text,
                                fullnameController.text);
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 255, 180, 59),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          child: Text(TextData.changeTitle,
                              style: FontData.dMSans20Bold(
                                  fontWeight: FontWeight.normal))),
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
