import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:space_app/data/services/page_index_cubit/cubit/page_index_cubit.dart';
import 'package:space_app/firebase_options.dart';
import 'package:space_app/presentation/components/app_bar.dart';
import 'package:space_app/presentation/components/bottom_app_bar.dart';
import 'package:space_app/presentation/features/auth/login/login_page.dart';
// import 'package:space_app/presentation/features/auth/sign_up/sign_up_page.dart';
import 'package:space_app/presentation/features/feed/feed_page.dart';
import 'package:space_app/presentation/features/notifications/notification_page.dart';
import 'package:space_app/presentation/features/profile/cubit/profile_option_cubit.dart';
import 'package:space_app/presentation/features/profile/profile_page.dart';
import 'package:space_app/presentation/features/search/search_page.dart';
import 'package:space_app/presentation/theme/app_theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: BlocProvider(
        create: (context) => PageIndexCubit(),
        child: LoginPage(),
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

List<String> images = [
  "https://gdgouxislhxtvilncrkk.supabase.co/storage/v1/object/public/images/53951942710_5f4cef91ce_c.jpg",
  "https://gdgouxislhxtvilncrkk.supabase.co/storage/v1/object/public/images/53970855226_596526383a_c.jpg",
  "https://gdgouxislhxtvilncrkk.supabase.co/storage/v1/object/public/images/53989782746_0e027eebc9_c.jpg",
  "https://gdgouxislhxtvilncrkk.supabase.co/storage/v1/object/public/images/54043097600_ee121a7ba5_c.jpg",
  "https://gdgouxislhxtvilncrkk.supabase.co/storage/v1/object/public/images/54088897300_03f4f1647a_c.jpg",
  "https://gdgouxislhxtvilncrkk.supabase.co/storage/v1/object/public/images/54107357754_b73921f095_c.jpg",
  "https://gdgouxislhxtvilncrkk.supabase.co/storage/v1/object/public/images/54960149350_8a79461ec1_c.jpg",
];
