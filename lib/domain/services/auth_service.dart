import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:space_app/domain/services/token_service.dart';

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

  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        // User canceled the sign-in
        return null;
      }
      
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      return await _auth.signInWithCredential(credential);
    } on Exception catch (e) {
      debugPrint("Google Sign-in Error: $e");
      return null;
    }
  }

  static Future<void> logOut() async {
    await _auth.signOut();
    TokenService.deleteToken();
  }
}
