import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:space_app/presentation/components/app_bar.dart';
import 'package:space_app/presentation/components/bottom_app_bar.dart';
import 'package:space_app/presentation/features/feed/feed_page.dart';
import 'package:space_app/presentation/features/home/page_index_cubit.dart';
import 'package:space_app/presentation/features/notifications/notification_page.dart';
import 'package:space_app/presentation/features/profile/cubit/cubit/user_cubit.dart';
import 'package:space_app/presentation/features/profile/cubit/profile_option_cubit.dart';
import 'package:space_app/presentation/features/profile/profile_page.dart';
import 'package:space_app/presentation/features/search/search_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PageIndexCubit(),
      child: BlocProvider(
        create: (context) => UserCubit()..getUser(),
        child: MyHomePage(title: "Space App"),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageIndexCubit, int>(
      builder: (context, state) {
        return Scaffold(
          appBar: CustomAppBar(),
          body: RefreshIndicator.adaptive(
            onRefresh: () async {
              await Future.delayed(const Duration(seconds: 1));
            },
            child: PageView(
              onPageChanged: (index) {
                context.read<PageIndexCubit>().changeIndex(index);
              },
              controller: pageController,
              children: [
                FeedPage(),
                SearchPage(),
                NotificationPage(),
                BlocProvider(
                  create: (context) => ProfileOptionCubit(),
                  child: ProfilePage(),
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomAppBar(
            pageController: pageController,
          ),
        );
      },
    );
  }
}
