import 'package:flutter/material.dart';
import 'package:space_app/domain/services/auth_service.dart';
import 'package:space_app/domain/services/token_service.dart';
import 'package:space_app/presentation/components/snack_bars.dart';
import 'package:space_app/presentation/features/auth/login/validator.dart';
import 'package:space_app/presentation/features/home/home_page.dart';

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
      showErrorSnackBar(context, "Email or password is incorrect");
      return false;
    }
  }
  return false;
}
