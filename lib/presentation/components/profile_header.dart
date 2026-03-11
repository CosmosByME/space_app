import 'package:flutter/material.dart';
import 'package:space_app/data/models/user_model.dart';
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
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(width: 1.5, color: AppColors.primaryB900),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(38),
                  child: user.profileImageUrl.isEmpty
                      ? Image.asset(
                          "assets/images/profile_pic.png",
                          height: 76,
                          width: 76,
                          fit: BoxFit.cover,
                        )
                      //Here I changed image.network to image.file
                      : Image.network(
                          user.profileImageUrl,
                          height: 76,
                          width: 76,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat(context, user.postsCount.toString(), "Posts"),
                    Text("|", style: TextStyle(fontSize: 18)),
                    _buildStat(
                      context,
                      user.followersCount.toString(),
                      "Followers",
                    ),
                    Text("|", style: TextStyle(fontSize: 18)),
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
              Text("|"),
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
            maxLines: 5,
            overflow: TextOverflow.visible,
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
