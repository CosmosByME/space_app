import 'package:flutter/material.dart';
import 'package:space_app/presentation/components/icons.dart';
import 'package:space_app/presentation/theme/colors.dart';

class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomTabBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

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
