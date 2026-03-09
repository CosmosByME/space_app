import 'package:flutter/material.dart';
import 'package:space_app/data/services/auth_service.dart';
import 'package:space_app/data/services/token_service.dart';
import 'package:space_app/presentation/components/snack_bars.dart';
import 'package:space_app/presentation/features/auth/login/validator.dart';

Future<bool> handleLoginAction(
  BuildContext context,
  String email,
  String password,
) async {
  if (isEmailValid(email)) {
    final response = await AuthService.signInEmail(email, password);
    if (response != null) {
      showSuccessSnackBar(context, "Logged in successfully");
      TokenService.writeToken(response);
      return true;
    } else {
      showErrorSnackBar(context, "Failed to login");
      return false;
    }
  }
  return false;
}
