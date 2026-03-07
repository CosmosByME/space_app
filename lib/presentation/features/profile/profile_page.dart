import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/presentation/components/icons.dart';
import 'package:space_app/presentation/features/profile/all_posts.dart';
import 'package:space_app/presentation/features/profile/cubit/profile_option_cubit.dart';
import 'package:space_app/presentation/features/profile/profile_update.dart';
import 'package:space_app/presentation/features/profile/saved_posts.dart';
import 'package:space_app/presentation/theme/colors.dart';

/// FIX 1: Wrap ProfilePage with BlocProvider so ProfileOptionCubit is available.
/// Use this widget wherever you previously used ProfilePage().
class ProfilePageWrapper extends StatelessWidget {
  const ProfilePageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileOptionCubit(),
      child: const ProfilePage(),
    );
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
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                stretch: true,
                pinned: true,
                expandedHeight: 230,
                toolbarHeight: 0,
                flexibleSpace: const FlexibleSpaceBar(
                  background: ProfileInfo(),
                  stretchModes: [
                    StretchMode.zoomBackground,
                    StretchMode.fadeTitle,
                    StretchMode.blurBackground,
                  ],
                ),
                bottom: _TabBar(
                  currentIndex: currentIndex,
                  onTap: (index) {
                    context.read<ProfileOptionCubit>().changeOption(index);
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
          // return Column(
          //   children: [
          //     // FIX 2: Replace CustomScrollView/SliverFillRemaining with a Column
          //     // so the PageView gets a proper bounded height without layout conflicts.
          //     ProfileInfo(),

          //     // Pinned Tab Bar
          //     _TabBar(
          //       currentIndex: currentIndex,
          //       onTap: (index) {
          //         context.read<ProfileOptionCubit>().changeOption(index);
          //       },
          //     ),

          //     // FIX 3: Expanded gives PageView a bounded height inside the Column.
          //     Expanded(
          //       child: PageView(
          //         controller: _pageController,
          //         onPageChanged: (index) {
          //           context.read<ProfileOptionCubit>().changeOption(index);
          //         },
          //         children: const [AllPosts(), SavedPosts(), ProfileUpdate()],
          //       ),
          //     ),
          //   ],
          // );
        },
      ),
    );
  }
}

/// Extracted tab bar as a proper StatelessWidget (no SliverDelegate needed).
class _TabBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const _TabBar({required this.currentIndex, required this.onTap});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      height: 56,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.neutralB100, width: 0.5),
          ),
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildTabIcon(
              context,
              0,
              AppIcons.gridIconSelected,
              AppIcons.gridIconUnSelected,
            ),
            _buildTabIcon(
              context,
              1,
              AppIcons.bookmarkIconSelected,
              AppIcons.bookmarkIconUnSelected,
            ),
            _buildTabIcon(
              context,
              2,
              AppIcons.settingsIconSelected,
              AppIcons.settingsIconUnSelected,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabIcon(
    BuildContext context,
    int index,
    Widget selectedIcon,
    Widget unselectedIcon,
  ) {
    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 24),
        child: currentIndex == index ? selectedIcon : unselectedIcon,
      ),
    );
  }
}

// Profile info header widget
class ProfileInfo extends StatelessWidget {
  const ProfileInfo({super.key});

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
              CircleAvatar(
                radius: 35,
                backgroundColor: AppColors.neutralB300,
                child: const Icon(Icons.person, size: 35, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStat(context, "12", "Posts"),
                    _buildStat(context, "207", "Followers"),
                    _buildStat(context, "64", "Following"),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text(
                "Robert Fox",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(width: 8),
              Text(
                "@robert",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.neutralB300),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "Software Engineer",
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
