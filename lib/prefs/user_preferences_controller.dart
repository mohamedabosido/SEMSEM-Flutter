import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tokoto/Models/user.dart';

class UserPreferencesController {
  UserPreferencesController._internal();

  static final UserPreferencesController _instance =
      UserPreferencesController._internal();

  late SharedPreferences _sharedPreferences;

  factory UserPreferencesController() {
    return _instance;
  }

  Future<void> initSharePreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<void> saveUser({required UserModel user}) async {
    Map json = user.toJson();
    _sharedPreferences.setString('userData', jsonEncode(json));
  }
  void setDarkMode(bool darkMode){
    _sharedPreferences.setBool('darkMode', darkMode);
  }

  UserModel get user =>
      UserModel.fromJson(jsonDecode(_sharedPreferences.getString('userData')!));

  bool get darkMode => _sharedPreferences.getBool('darkMode') ?? false;

  Future<bool> logout() async {
    imageCache.clear;
    imageCache.clearLiveImages();
    return await _sharedPreferences.clear();
  }
}
