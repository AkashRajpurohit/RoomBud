import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedData {
  Future addDataToSharedData(String key, dynamic value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    String stringifiedValue = json.encode(value ?? "");

    _pref.setString(key, stringifiedValue);
  }

  Future<dynamic> getDataFromSharedData(String key) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    return json.decode(_pref.get(key) ?? "");
  }

  void clearDB() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();

    await _pref.remove("usertype");

    print("Cleared usertype");

    var user = await _pref.get("usertype");

    print(user);
  }
}
