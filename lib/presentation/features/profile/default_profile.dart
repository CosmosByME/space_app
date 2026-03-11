import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:space_app/data/models/user_model.dart';
import 'package:space_app/presentation/features/profile/all_posts.dart';
import 'package:space_app/presentation/features/profile/profile_info.dart';
import 'package:space_app/presentation/features/profile/profile_update.dart';
import 'package:space_app/presentation/features/profile/saved_posts.dart';
import 'package:space_app/presentation/features/profile/tab_bar.dart';

class DefaultProfile extends StatelessWidget {
  const DefaultProfile({super.key});

  @override
  Widget build(BuildContext context) {
    int currentIndex = 0;
    return Skeletonizer(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            stretch: true,
            pinned: true,
            expandedHeight: 230,
            toolbarHeight: 0,
            flexibleSpace: FlexibleSpaceBar(
              background: ProfileInfo(
                user: UserModel(
                  uid: "",
                  name: "@robert",
                  email: "",
                  username: "Robert Fox",
                  bio: "Software Engineer",
                  profileImageUrl: "",
                  followersCount: 624,
                  followingCount: 480,
                  postsCount: 67,
                  createdAt: DateTime.now(),
                  followed: false,
                ),
              ),
              stretchModes: const [
                StretchMode.zoomBackground,
                StretchMode.fadeTitle,
                StretchMode.blurBackground,
              ],
            ),
            bottom: CustomTabBar(currentIndex: currentIndex, onTap: (index) {}),
          ),
          currentIndex == 0
              ? const AllPosts()
              : currentIndex == 1
              ? const SavedPosts()
              : const SliverToBoxAdapter(child: ProfileUpdate()),
        ],
      ),
    );
  }
}
