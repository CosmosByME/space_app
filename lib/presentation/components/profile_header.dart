import 'package:flutter/material.dart';
import 'package:space_app/domain/models/user_model.dart';
import 'package:space_app/presentation/theme/colors.dart';

class ProfileHeader extends StatelessWidget {
  final UserModel user;
  const ProfileHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              //Change to CashedNetworkImage
              CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.neutralB300,
                child: const Icon(Icons.person, size: 70, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat(context, user.postsCount.toString(), "Posts"),
                    _buildStat(
                      context,
                      user.followersCount.toString(),
                      "Followers",
                    ),
                    _buildStat(
                      context,
                      user.followingCount.toString(),
                      "Following",
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                user.username,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(width: 10),
              Text(
                user.name,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.neutralB300),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            user.bio,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.neutralB500),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(BuildContext context, String count, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(count, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 2),
        Text(
          label,
          style: Theme.of(
            context,
          ).textTheme.labelLarge?.copyWith(color: AppColors.neutralB300),
        ),
      ],
    );
  }
}
