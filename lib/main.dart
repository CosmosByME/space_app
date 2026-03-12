import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:space_app/presentation/features/auth/sign_up/sign_up_page.dart';
import 'package:space_app/presentation/features/home/home_page.dart';
import 'package:space_app/presentation/features/home/page_index_cubit.dart';
import 'package:space_app/firebase_options.dart';
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
      themeMode: ThemeMode.system,
      home: BlocProvider(
        create: (context) => PageIndexCubit(),
        child: pageSelector(),
      ),
    );
  }
}

Widget pageSelector() {
  final auth = FirebaseAuth.instance;
  if (auth.currentUser != null) {
    return MyHomePage(title: "Space App");
  } else {
    return SignUpPage();
  }
}
