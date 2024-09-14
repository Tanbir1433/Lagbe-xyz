import 'package:ecommerce_user_app/utility/extensions.dart';

import '../../utility/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import '../home_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      // savedEmail: 'testing@gmail.com',
      // savedPassword: '12345',
      loginAfterSignUp: false,
      logo: const AssetImage('assets/images/app_logo.png'),
      onLogin: (LoginData loginData) {
        context.userProvider.login(loginData);
        return null;
      },
      onSignup: (SignupData data) {
        context.userProvider.register(data);
        return null;
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const HomeScreen();
          },
        ));
      },
      onRecoverPassword: (_) => null,
      hideForgotPasswordButton: true,
      theme: LoginTheme(
        logoWidth: 0.60,
        primaryColor: AppColor.lightGrey,
        accentColor: AppColor.darkOrange,
        buttonTheme: LoginButtonTheme(
            backgroundColor: AppColor.darkOrange,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
        cardTheme: const CardTheme(
            color: Colors.white, surfaceTintColor: Colors.white),
        titleStyle: const TextStyle(color: Colors.black),
        switchAuthTextColor: AppColor.darkOrange,
        inputTheme: InputDecorationTheme(
          filled: true,
          suffixIconColor: Colors.blue,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none
          )
        )
      ),
    );
  }
}
