import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/data/models/user_model.dart';
import 'package:space_app/presentation/features/profile/all_posts.dart';
import 'package:space_app/presentation/features/profile/cubit/cubit/user_cubit.dart';
import 'package:space_app/presentation/features/profile/cubit/profile_option_cubit.dart';
import 'package:space_app/presentation/features/profile/default_profile.dart';
import 'package:space_app/presentation/features/profile/profile_info.dart';
import 'package:space_app/presentation/features/profile/profile_update.dart';
import 'package:space_app/presentation/features/profile/saved_posts.dart';
import 'package:space_app/presentation/features/profile/tab_bar.dart';

class ProfilePageWrapper extends StatelessWidget {
  const ProfilePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (context) => UserCubit(), child: ProfilePage());
  }
}

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
    context.read<UserCubit>().getUser();
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
              if (state.state == StateEnum.loading ||
                  state.state == StateEnum.initial) {
                return DefaultProfile();
              }

              if (state.state == StateEnum.error) {
                return Center(child: Text('Error: ${state.error}'));
              }
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
                    return DefaultProfile();
                  }
                  final user = UserModel.fromMap(asyncSnapshot.data!.data()!);
                  return CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.transparent,
                        stretch: true,
                        pinned: true,
                        expandedHeight: 260,
                        toolbarHeight: 0,
                        flexibleSpace: FlexibleSpaceBar(
                          background: ProfileInfo(user: user),
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
