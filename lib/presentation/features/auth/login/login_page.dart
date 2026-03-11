import 'package:flutter/material.dart';
import 'package:space_app/presentation/components/app_bar.dart';
import 'package:space_app/presentation/components/custom_password_field.dart';
import 'package:space_app/presentation/components/custom_text_field.dart';
import 'package:space_app/presentation/components/icons.dart';
import 'package:space_app/presentation/components/other_method_button.dart';
import 'package:space_app/presentation/components/snack_bars.dart';
import 'package:space_app/presentation/features/auth/login/login_action.dart';
import 'package:space_app/presentation/features/auth/sign_up/sign_up_page.dart';
import 'package:space_app/presentation/theme/colors.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(title: LogoContainer(), centerTitle: true),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      showWarningSnackBar(
                        context,
                        "This feature is not available yet",
                      );
                    },
                    child: OtherMethodsButton(
                      icon: AppIcons.googleIcon,
                      text: "Sign up with Google",
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpPage();
                          },
                        ),
                      );
                    },
                    child: OtherMethodsButton(
                      icon: AppIcons.emailIcon,
                      text: "Sign up with Email",
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 10)),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      height: 1,
                      margin: EdgeInsets.only(right: 24),
                      width:
                          double.infinity, // Controls the thickness of the line
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.neutralB100),
                      ), // Color of the line // Adds space around the container
                    ),
                  ),
                  Text(
                    "OR",
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.neutralB400,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 24),
                      height: 1, // Controls the thickness of the line
                      color: AppColors
                          .neutralB100, // Color of the line // Adds space around the container
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  CustomTextField(controller: _emailController, text: "Email"),
                  CustomPasswordField(
                    controller: _passwordController,
                    text: "Password",
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(child: SizedBox(height: 26)),
          SliverToBoxAdapter(
            child: InkWell(
              onTap: () async {
                setState(() {
                  isLoading = true;
                });

                await handleLoginAction(
                  context,
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                );

                setState(() {
                  isLoading = false;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryB900,
                  borderRadius: BorderRadius.circular(6),
                ),
                alignment: Alignment.center,
                child: isLoading
                    ? SizedBox.square(
                        dimension: 25,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 4,
                        ),
                      )
                    : Text("Log in", style: TextStyle(color: Colors.white)),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return SignUpPage();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
