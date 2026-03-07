import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:space_app/data/services/token_service.dart';

class AuthService {
  static Future<void> signInEmail(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final responce = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (responce.user != null) {
        TokenService.writeToken(responce.user!.uid);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> signUpEmail(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final responce = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (responce.user != null) {
        TokenService.writeToken(responce.user!.uid);
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
    }
  }

  static void logOut() async {
    final auth = FirebaseAuth.instance;
    await auth.signOut();
  }
}
