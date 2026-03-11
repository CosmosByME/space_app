import 'package:flutter/material.dart';
import 'package:space_app/domain/services/auth_service.dart';
import 'package:space_app/domain/services/token_service.dart';
import 'package:space_app/data/models/user_model.dart';
import 'package:space_app/data/repository/user_repository_impl.dart';
import 'package:space_app/presentation/components/snack_bars.dart';
import 'package:space_app/presentation/features/auth/sign_up/validator.dart';
import 'package:space_app/presentation/features/home/home_page.dart';

Future<bool> handleSignUpAction(
  BuildContext context,
  String name,
  String email,
  String username,
  String password,
) async {
  UserRepositoryImpl repo = UserRepositoryImpl();
  if (validateSignUpForm(context, name, email, username, password)) {
    final response = await AuthService.signUpEmail(email, password);
    if (response != null) {
      TokenService.writeToken(response);
      UserModel user = UserModel(
        uid: response,
        name: name,
        email: email,
        username: username,
        bio: "",
        profileImageUrl: "",
        followersCount: 0,
        followingCount: 0,
        postsCount: 0,
        createdAt: DateTime.now(),
        followed: false,
      );
      await repo.addUser(user);
      showSuccessSnackBar(context, "Account created successfully");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
      );
      return true;
    } else {
      showErrorSnackBar(context, "Failed to create account");
      return false;
    }
  }
  return false;
}
