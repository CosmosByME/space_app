import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/data/services/token_service.dart';
import 'package:space_app/presentation/features/profile/all_posts.dart';
import 'package:space_app/presentation/features/profile/cubit/cubit/user_cubit.dart';
import 'package:space_app/presentation/features/profile/cubit/profile_option_cubit.dart';
import 'package:space_app/presentation/features/profile/profile_info.dart';
import 'package:space_app/presentation/features/profile/profile_update.dart';
import 'package:space_app/presentation/features/profile/saved_posts.dart';
import 'package:space_app/presentation/features/profile/tab_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProfileOptionCubit, int>(
        listener: (context, state) {
          if (_pageController.hasClients &&
              _pageController.page?.round() != state) {
            _pageController.animateToPage(
              state,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
        builder: (context, currentIndex) {
          return BlocBuilder<UserCubit, UserState>(
            builder: (context, state) {
              return StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .doc(state.user!.uid)
                    .snapshots(),
                builder: (context, asyncSnapshot) {
                  if (asyncSnapshot.hasError) {
                    return Center(child: Text('Error: ${asyncSnapshot.error}'));
                  }
                  if (asyncSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  // final user = UserModel.fromMap(asyncSnapshot.data!.data()!);
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        stretch: true,
                        pinned: true,
                        expandedHeight: 230,
                        toolbarHeight: 0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: ProfileInfo(),
                          stretchModes: [
                            StretchMode.zoomBackground,
                            StretchMode.fadeTitle,
                            StretchMode.blurBackground,
                          ],
                        ),
                        bottom: CustomTabBar(
                          currentIndex: currentIndex,
                          onTap: (index) {
                            context.read<ProfileOptionCubit>().changeOption(
                              index,
                            );
                          },
                        ),
                      ),
                      currentIndex == 0
                          ? AllPosts()
                          : currentIndex == 1
                          ? SavedPosts()
                          : SliverToBoxAdapter(child: ProfileUpdate()),
                    ],
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
