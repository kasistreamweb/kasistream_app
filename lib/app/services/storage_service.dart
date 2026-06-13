import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../models/user_model.dart';

class StorageService {
  static const String tokenKey = 'token';

  static const String userKey = 'user';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(tokenKey);
  }

  static Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(tokenKey);
  }

  static Future<void> saveUser(UserModel user) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(userKey, jsonEncode(user.toJson()));
  }

  static Future<UserModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getString(userKey);

    if (data == null) {
      return null;
    }

    return UserModel.fromJson(jsonDecode(data));
  }

  static Future<void> removeUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(userKey);
  }

  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.clear();
  }
}
