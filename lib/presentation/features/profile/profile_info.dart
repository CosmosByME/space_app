import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:space_app/domain/models/user_model.dart';
import 'package:space_app/presentation/components/icons.dart';
import 'package:space_app/presentation/components/profile_header.dart';
import 'package:space_app/presentation/components/snack_bars.dart';
import 'package:space_app/presentation/features/profile/cubit/cubit/user_cubit.dart';

class ProfileInfo extends StatefulWidget {
  const ProfileInfo({super.key});

  @override
  State<ProfileInfo> createState() => _ProfileInfoState();
}

class _ProfileInfoState extends State<ProfileInfo> {
  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().getUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final stateEnum = state.state;
        if (stateEnum == StateEnum.initial || stateEnum == StateEnum.loading) {
          return Skeletonizer(
            child: ProfileHeader(
              user: UserModel(
                uid: "",
                name: "@robert",
                email: "",
                username: "RobertFox",
                bio: "Software Engineer",
                profileImageUrl: "",
                followersCount: 0,
                followingCount: 0,
                postsCount: 0,
                createdAt: DateTime.now(),
              ),
            ),
          );
        } else if (stateEnum == StateEnum.success) {
          final user = state.user!;
          return ProfileHeader(user: user);
        } else {
          showErrorSnackBar(context, "Failed to get User");
          return Container(
            padding: EdgeInsets.fromLTRB(
              16,
              MediaQuery.of(context).padding.top + 16,
              16,
              16,
            ),
            margin: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: SizedBox.square(dimension: 40, child: AppIcons.alertIcon),
            ),
          );
        }
      },
    );
  }
}
