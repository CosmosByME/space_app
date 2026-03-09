import 'package:flutter/material.dart';
import 'package:space_app/data/services/auth_service.dart';
import 'package:space_app/data/services/token_service.dart';
import 'package:space_app/presentation/components/snack_bars.dart';
import 'package:space_app/presentation/features/auth/sign_up/validator.dart';

Future<bool> handleSignUpAction(
  BuildContext context,
  String name,
  String email,
  String username,
  String password,
) async {
  if (validateSignUpForm(context, name, email, username, password)) {
    final response = await AuthService.signUpEmail(email, password);
    if (response != null) {
      showSuccessSnackBar(context, "Account created successfully");
      TokenService.writeToken(response);
      return true;
    } else {
      showErrorSnackBar(context, "Failed to create account");
      return false;
    }
  }
  return false;
}
