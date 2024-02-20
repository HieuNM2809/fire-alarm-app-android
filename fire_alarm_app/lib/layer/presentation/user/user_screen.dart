import 'package:fire_alarm_app/utils/dimen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fire_alarm_app/layer/presentation/user/index.dart';

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
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 26),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Tài Khoản',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
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
                      const Row(
                        children: [
                          Text('Họ và tên:'),
                          SizedBox(
                            width: 100,
                          ),
                          Text('Test11'),
                        ],
                      ),
                      const Row(
                        children: [
                          Text('Username:'),
                          SizedBox(
                            width: 100,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: Text('user1')),
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
                                // focusNode: focusNode,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.orange,

                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Nhập Mật Khẩu',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                                // controller: rePasswordController,
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
                                // focusNode: focusNode,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.orange,

                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Nhập Mật Khẩu',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                                // controller: rePasswordController,
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
                                // focusNode: focusNode,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.orange,

                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Nhập Mật Khẩu',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                                // controller: rePasswordController,
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
                                // focusNode: focusNode,
                                style: const TextStyle(color: Colors.black),
                                cursorColor: Colors.orange,

                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  hintText: 'Nhập Mật Khẩu',
                                  hintStyle:
                                      const TextStyle(color: Colors.grey),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.grey[300]!),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.orange),
                                  ),
                                ),
                                // controller: rePasswordController,
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
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor: Colors.red,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
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
                                onPressed: () {},
                                style: TextButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 255, 180, 59),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.0)),
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
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void _load() {
    widget._userBloc.add(LoadUserEvent());
  }
}
