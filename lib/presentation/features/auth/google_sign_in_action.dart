import 'package:flutter/material.dart';
import 'package:space_app/domain/services/auth_service.dart';
import 'package:space_app/domain/services/token_service.dart';
import 'package:space_app/data/models/user_model.dart';
import 'package:space_app/data/repository/user_repository_impl.dart';
import 'package:space_app/presentation/components/snack_bars.dart';
import 'package:space_app/presentation/features/home/home_page.dart';

Future<bool> handleGoogleSignInAction(BuildContext context) async {
  UserRepositoryImpl repo = UserRepositoryImpl();

  final userCredential = await AuthService.signInWithGoogle();

  if (userCredential != null && userCredential.user != null) {
    TokenService.writeToken(userCredential.user!.uid);

    // If it's a new user, create a document for them in Firestore
    if (userCredential.additionalUserInfo?.isNewUser ?? false) {
      final String safeName = userCredential.user!.displayName ?? "User";
      
      // Create a base username from their email prefix, removing special chars
      String baseUsername = (userCredential.user!.email?.split('@').first ?? "user")
          .replaceAll(RegExp(r'[^a-zA-Z0-9]'), '')
          .toLowerCase();

      // Ensure username isn't totally empty
      if (baseUsername.isEmpty) baseUsername = "user${DateTime.now().millisecondsSinceEpoch}";

      UserModel user = UserModel(
        uid: userCredential.user!.uid,
        name: safeName,
        email: userCredential.user!.email ?? "",
        username: baseUsername,
        bio: "",
        profileImageUrl: userCredential.user!.photoURL ?? "",
        followersCount: 0,
        followingCount: 0,
        postsCount: 0,
        createdAt: DateTime.now(),
        followed: false,
      );
      
      await repo.addUser(user);
      if (context.mounted) showSuccessSnackBar(context, "Account created with Google!");
    } else {
      if (context.mounted) showSuccessSnackBar(context, "Logged in with Google");
    }

    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
    return true;
  }
  
  if (context.mounted) showErrorSnackBar(context, "Google Sign-In canceled or failed.");
  return false;
}
