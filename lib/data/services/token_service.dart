import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static final storage = SharedPreferencesAsync();

  static Future<String> readToken() async {
    try {
      final responce = await storage.getString("uid");
      return responce!;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static void writeToken(String token) async {
    try {
      await storage.setString("uid", token);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
