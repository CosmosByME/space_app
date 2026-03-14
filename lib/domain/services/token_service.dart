import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class TokenService {
  static Future<String> readToken() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        return user.uid;
      }
      throw Exception("No user is currently logged in.");
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  static void writeToken(String token) {
    // No longer needed, Firebase SDK handles session persistence securely.
  }

  static void deleteToken() {
    // No longer needed, Firebase SDK handles session destruction.
  }
}
