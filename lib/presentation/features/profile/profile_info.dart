import 'package:flutter/material.dart';
import 'package:space_app/data/models/user_model.dart';
import 'package:space_app/presentation/components/profile_header.dart';

class ProfileInfo extends StatelessWidget {
  final UserModel user;
  const ProfileInfo({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return ProfileHeader(user: user);
  }
}
