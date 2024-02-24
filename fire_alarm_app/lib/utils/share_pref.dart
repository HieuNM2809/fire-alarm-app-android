import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharePref {
  Future<void> save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
  }

  Future<String> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String string = prefs.getString(key) ?? "";
    return string;
  }

  Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  Future<bool> checkPrefs(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String string = prefs.getString(key) ?? "";
    if (string != "") {
      return true;
    } else {
      return false;
    }
  }
}
