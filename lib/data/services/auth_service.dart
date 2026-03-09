import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:space_app/data/services/token_service.dart';

class AuthService {
  static final _auth = FirebaseAuth.instance;

  static Future<String?> signInEmail(String email, String password) async {
    try {
      final responce = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return responce.user!.uid;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<String?> signUpEmail(String email, String password) async {
    try {
      final responce = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return responce.user!.uid;
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static void logOut() async {
    await _auth.signOut();
    TokenService.deleteToken();
  }
}
