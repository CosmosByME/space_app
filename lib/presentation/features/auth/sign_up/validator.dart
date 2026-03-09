import 'package:flutter/material.dart';
import 'package:space_app/presentation/components/snack_bars.dart';

bool validateSignUpForm(
  BuildContext context,
  String name,
  String email,
  String username,
  String password,
) {
  if (name.isEmpty) {
    showErrorSnackBar(context, "Name is required");
    return false;
  }
  if (email.isEmpty) {
    showErrorSnackBar(context, "Email is required");
    return false;
  }
  if (username.isEmpty) {
    showErrorSnackBar(context, "Username is required");
    return false;
  }
  if (password.isEmpty) {
    showErrorSnackBar(context, "Password is required");
    return false;
  }

  if (!email.contains('@')) {
    showErrorSnackBar(context, "Email is invalid");
    return false;
  }

  if (password.length < 8) {
    showErrorSnackBar(context, "Password must be at least 8 characters long");
    return false;
  }
  if (!password.contains(RegExp(r'[A-Z]'))) {
    showErrorSnackBar(
      context,
      "Password must contain at least one uppercase letter",
    );
    return false;
  }

  if (!password.contains(RegExp(r'[a-z]'))) {
    showErrorSnackBar(
      context,
      "Password must contain at least one lowercase letter",
    );
    return false;
  }

  if (!password.contains(RegExp(r'[0-9]'))) {
    showErrorSnackBar(context, "Password must contain at least one number");
    return false;
  }

  if (!password.contains(RegExp(r'[!@#$%^&*]'))) {
    showErrorSnackBar(
      context,
      "Password must contain at least one special character",
    );
    return false;
  }

  return true;
}
