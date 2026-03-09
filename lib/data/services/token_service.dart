import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static final _storage = SharedPreferencesAsync();

  static Future<String> readToken() async {
    try {
      final responce = await _storage.getString("uid");
      return responce!;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static void writeToken(String token) async {
    try {
      await _storage.setString("uid", token);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static void deleteToken() async {
    try {
      await _storage.remove("uid");
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
