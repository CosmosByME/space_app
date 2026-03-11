import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/presentation/features/home/page_index_cubit.dart';
import 'package:space_app/presentation/components/icons.dart';

class CustomBottomAppBar extends StatefulWidget {
  final PageController pageController;
  const CustomBottomAppBar({super.key, required this.pageController});

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  @override
  Widget build(BuildContext context) {
    final index = context.read<PageIndexCubit>().state;
    return BlocConsumer<PageIndexCubit, int>(
      listener: (context, state) {
        widget.pageController.jumpToPage(state);
      },
      builder: (context, state) {
        return BottomAppBar(
          color: Theme.of(context).colorScheme.surface,
          height: 58,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  context.read<PageIndexCubit>().changeIndex(0);
                },
                child: index == 0
                    ? SizedBox(
                        height: 26,
                        width: 26,
                        child: AppIcons.homeIconSelected,
                      )
                    : SizedBox(
                        height: 26,
                        width: 26,
                        child: AppIcons.homeIconUnSelected,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<PageIndexCubit>().changeIndex(1);
                },
                child: index == 1
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: AppIcons.searchIconSelected,
                      )
                    : SizedBox(
                        height: 26,
                        width: 26,
                        child: AppIcons.searchIconUnSelected,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<PageIndexCubit>().changeIndex(2);
                },
                child: index == 2
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: AppIcons.notificationIconSelected,
                      )
                    : SizedBox(
                        height: 26,
                        width: 26,
                        child: AppIcons.notificationIconUnSelected,
                      ),
              ),
              GestureDetector(
                onTap: () {
                  context.read<PageIndexCubit>().changeIndex(3);
                },
                child: index == 3
                    ? SizedBox(
                        height: 30,
                        width: 30,
                        child: AppIcons.userIconSelected,
                      )
                    : SizedBox(
                        height: 26,
                        width: 26,
                        child: AppIcons.userIconUnSelected,
                      ),
              ),
            ],
          ),
        );
      },
    );
  }
}
